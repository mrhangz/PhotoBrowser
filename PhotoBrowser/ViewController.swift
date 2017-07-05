//
//  ViewController.swift
//  PhotoBrowser
//
//  Created by Teerawat Vanasapdamrong on 7/5/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

let numberOfColumns: CGFloat = 2
let numberOfRows: CGFloat = 3
let padding: CGFloat = 8.0

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadMoreBottomConstraint: NSLayoutConstraint!
    private let refreshControl = UIRefreshControl()
    private var currentPage = 1
    private var totalPage = 0
    fileprivate var photoArray: [Photo] = []
    
    var category: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        self.navigationItem.title = category!
        refreshCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshCollectionView() {
        currentPage = 1
        totalPage = 0
        photoArray = []
        collectionView.reloadData()
        getPhotos()
    }
    
    func getPhotos() {
        API().getPhotos(category: category!, page: currentPage) { [weak self] (result, error) in
            if (error != nil) {
                print("\(result["error"].string!)")
            } else {
                self?.currentPage = result["current_page"].int!
                self?.totalPage = result["total_pages"].int!
                for dict in result["photos"].array! {
                    let photo = Photo.init(id: dict["id"].intValue,
                                           name: dict["name"].stringValue,
                                           author: dict["user"]["username"].stringValue,
                                           imageUrl: dict["images"].arrayValue[0]["url"].stringValue,
                                           largeImageUrl: dict["images"].arrayValue[1]["url"].stringValue)
                    
                    self?.photoArray.append(photo)
                }
                UIView.animate(withDuration: 2.0, animations: {
                    self?.loadMoreBottomConstraint.constant = -50
                })
                self?.collectionView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    @IBAction func loadMore(sender: UIButton) {
        currentPage = currentPage + 1
        getPhotos()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for indexPath in collectionView.indexPathsForVisibleItems {
            if currentPage != totalPage && indexPath.row == photoArray.count - 1 {
                self.loadMoreBottomConstraint.constant = 8
                break
            } else {
                self.loadMoreBottomConstraint.constant = -50
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? FullScreenImageViewController
        destinationVC?.photoArray = photoArray
        destinationVC?.currentIndex = (sender as? IndexPath)?.row
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FullScreen", sender: indexPath)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell
        let photo = photoArray[indexPath.row]
        cell?.titleLabel.text = photo.name
        cell?.authorLabel.text = photo.author
        Alamofire.request(photo.imageUrl).responseImage { response in
            if let image = response.result.value {
                cell?.imageView.image = image
            }
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width / numberOfColumns - (padding / 2), height: self.view.frame.size.height / numberOfRows - (padding / 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
}

