//
//  ListViewModel.swift
//  PhotoBrowser
//
//  Created by Teerawat Vanasapdamrong on 7/16/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

class ListViewModel: NSObject {
    
    var currentPage = 1
    var totalPage = 0
    var photoArray: [Photo] = []
    var apiManager: APIManager = APIManager()
    
    var category: String
    
    init(category: String) {
        self.category = category
    }
    
    func refreshFeed(completion: @escaping () -> Void) {
        currentPage = 1
        totalPage = 0
        getPhotos(forPage: 1, completion: completion)
    }
    
    func getPhotos(forPage page: Int, completion: @escaping () -> Void) {
        apiManager.getPhotos(category: category, page: page) { (result, error) in
            if (error != nil) {
                completion()
            } else {
                if page == 1 {
                    self.photoArray = []
                }
                self.currentPage = result["current_page"].int!
                self.totalPage = result["total_pages"].int!
                for dict in result["photos"].array! {
                    let photo = Photo(json: dict)
                    self.photoArray.append(photo)
                }
                completion()
            }
        }
    }
    
    func getCellImage(forIndex index: Int, completion: @escaping (Any?) -> Void) {
        let imageURL = photoArray[index].imageUrl
        apiManager.getImage(imageURL: imageURL) { image in
            completion(image)
        }
    }
}
