//
//  CategoryViewModel.swift
//  PhotoBrowser
//
//  Created by Teerawat Vanasapdamrong on 7/16/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

class CategoryViewModel: NSObject {
    
    let photoCategories = [
        "Uncategorized",
        "Celebrities",
        "Film",
        "Journalism",
        "Nude",
        "Black and White",
        "Still Life",
        "People",
        "Landscapes",
        "City and Architecture",
        "Abstract",
        "Animals",
        "Macro",
        "Travel",
        "Fashion",
        "Commercial",
        "Concert",
        "Sport",
        "Nature",
        "Performing Arts",
        "Family",
        "Street",
        "Underwater",
        "Food",
        "Fine Art",
        "Wedding",
        "Transportation",
        "Urban Exploration",
        "Aerial",
        "Night"
    ]
    
    func cellText(forIndex index: Int) -> String {
        return photoCategories[index]
    }
    
}
