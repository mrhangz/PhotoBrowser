//
//  FullScreenPhotoViewController.swift
//  PhotoBrowser
//
//  Created by Teerawat Vanasapdamrong on 7/6/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FullScreenImageViewController: UICollectionViewController {
    
    var photoArray: [Photo]?
    var currentIndex: Int?
    
    override func viewDidLoad() {
        collectionView?.scrollToItem(at: IndexPath(row: currentIndex!, section: 0), at: .left, animated: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = photoArray![indexPath.row]
        cell.titleLabel.text = photo.name
        cell.authorLabel.text = photo.author
        Alamofire.request(photo.largeImageUrl).responseImage { response in
            if let image = response.result.value {
                cell.imageView.image = image
            }
        }
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let index = self.collectionView!.contentOffset.x / self.view.frame.size.width
        coordinator.animate(alongsideTransition: { context in
            let newXOffset = self.collectionView!.frame.size.width * index
            self.collectionView?.scrollRectToVisible(CGRect(x: newXOffset, y: 0, width: self.collectionView!.frame.size.width, height: self.collectionView!.frame.size.height), animated: false)
        })
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray?.count ?? 0
    }
    
}

extension FullScreenImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height - 64)
    }
}
