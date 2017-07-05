//
//  Photo.swift
//  PhotoBrowser
//
//  Created by Teerawat Vanasapdamrong on 7/5/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

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
}
