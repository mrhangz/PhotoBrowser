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
    @IBOutlet weak var loadMoreButton: UIButton!
    private let refreshControl = UIRefreshControl()
    var viewModel: ListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
        self.navigationItem.title = viewModel.category
        viewModel.refreshFeed() {
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func refreshFeed() {
        viewModel.refreshFeed() {
            self.reloadCollectionView()
        }
    }
    
    @IBAction func loadMore() {
        viewModel.getPhotos(forPage: viewModel.currentPage + 1) {
            self.reloadCollectionView()
        }
    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
        self.loadMoreButton.isHidden = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for indexPath in collectionView.indexPathsForVisibleItems {
            if viewModel?.currentPage != viewModel?.totalPage && indexPath.row == viewModel.photoArray.count - 1 {
                self.loadMoreButton.isHidden = false
                break
            } else {
                self.loadMoreButton.isHidden = true
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? FullScreenImageViewController
        destinationVC?.photoArray = viewModel.photoArray
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = viewModel.photoArray[indexPath.row]
        cell.titleLabel.text = photo.name
        cell.authorLabel.text = photo.author
        viewModel.getCellImage(forIndex: indexPath.row) { (image) in
            cell.imageView.image = image as? UIImage
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoArray.count
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / numberOfColumns - (padding / 2), height: collectionView.frame.size.height / numberOfRows - (padding / 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
}

