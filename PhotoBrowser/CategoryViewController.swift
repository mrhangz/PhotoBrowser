//
//  CategoryViewController.swift
//  PhotoBrowser
//
//  Created by Teerawat Vanasapdamrong on 7/5/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

let PhotoCategories = [
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

class CategoryViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PhotoCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = PhotoCategories[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowVC", sender: PhotoCategories[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? ViewController
        
        destinationVC?.category = sender as? String
    }
    
}
