//
//  CategoryViewController.swift
//  PhotoBrowser
//
//  Created by Teerawat Vanasapdamrong on 7/5/2560 BE.
//  Copyright © 2560 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {
    
    var viewModel: CategoryViewModel = CategoryViewModel()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photoCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = viewModel.cellText(forIndex: indexPath.row)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowVC", sender: viewModel.photoCategories[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? ViewController
        let category = sender as! String
        let viewModel: ListViewModel = ListViewModel(category: category)
        destinationVC?.viewModel = viewModel
    }
    
}
