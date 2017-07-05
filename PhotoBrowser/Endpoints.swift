//
//  Endpoints.swift
//  PhotoBrowser
//
//  Created by Teerawat Vanasapdamrong on 7/5/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

enum Endpoints {
    case GetPhotos
    
    var path: String {
        
        let baseUrl = "https://api.500px.com/v1"
        
        switch self {
        case .GetPhotos: return "\(baseUrl)/photos"
        }
    }
}
