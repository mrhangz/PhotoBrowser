//
//  API.swift
//  PhotoBrowser
//
//  Created by Teerawat Vanasapdamrong on 7/5/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let TimeoutIntervalForRequest: TimeInterval = 10
private let TimeoutIntervalForResource: TimeInterval = 10
private let PhotosPerPage: Int = 12
private let ConsumerKey = "asZmaIYrYqzLAL6O2HQKc2hOZZTN1L4nuQG8L0YL"
//https://api.500px.com/v1/photos?feature=fresh_today&only=Performing Arts&page=2&sort=created_at&image_size=3&rpp=10&include_store=store_download&include_states=voted&consumer_key=asZmaIYrYqzLAL6O2HQKc2hOZZTN1L4nuQG8L0YL
private var params: [String: Any] = [
    "feature": "fresh_today",
    "sort": "created_at",
    "rpp": PhotosPerPage,
    "image_size": [3,6],
    "consumer_key": ConsumerKey
]

class APIManager: NSObject {
    
    lazy var manager: SessionManager = {
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = TimeoutIntervalForRequest
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForResource = TimeoutIntervalForResource
        return Alamofire.SessionManager.default
    }()
    
    func getPhotos(category: String, page: Int, callback: @escaping (JSON, Error?) -> Void) {
        let url = Endpoints.GetPhotos.path
        params["only"] = category
        params["page"] = page
        manager.request(url, method: .get, parameters: params)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    callback(JSON(response.result.value!), nil)
                case .failure(let error):
                    callback(JSON(response.data!), error)
                }
        }
    }
    
    func getImage(imageURL: String, completion: @escaping (UIImage?) -> Void) {
        Alamofire.request(imageURL).responseImage { response in
            if let image = response.result.value {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
    
}
