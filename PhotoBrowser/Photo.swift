//
//  Photo.swift
//  PhotoBrowser
//
//  Created by Teerawat Vanasapdamrong on 7/5/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Photo {
    var id: Int
    var name: String
    var author: String
    var imageUrl: String
    var largeImageUrl: String
    
    init(id: Int, name: String, author: String, imageUrl: String, largeImageUrl: String) {
        self.id = id
        self.name = name
        self.author = author
        self.imageUrl = imageUrl
        self.largeImageUrl = largeImageUrl
    }
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.author = json["user"]["username"].stringValue
        self.imageUrl = json["images"].arrayValue[0]["url"].stringValue
        self.largeImageUrl = json["images"].arrayValue[1]["url"].stringValue
    }
}
