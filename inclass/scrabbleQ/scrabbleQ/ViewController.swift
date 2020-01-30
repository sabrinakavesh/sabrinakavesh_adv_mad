//
//  ViewController.swift
//  scrabbleQ
//
//  Created by Sabrina on 1/30/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit

class ViewController: UITableViewController { //if using reg view controller neeed UITableViewDelegate and DataSource, but bc using table view controller they are inherited
    
    //variables
    var words = [String]()
    
    //connect to data controller
    var data = DataController()
    
    //make a serach controller
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        do {
            try data.loadWords()
            words = try data.getWords()
            
            let resultsController = SearchResultsController()
            resultsController.allWords = words
            
            searchController = UISearchController(searchResultsController: resultsController) //tell it whre to call update method seach results
            searchController.searchBar.placeholder = "Filter"
            searchController.searchBar.sizeToFit()
            
            tableView.tableHeaderView = searchController.searchBar
            searchController.searchResultsUpdater = resultsController //cant set a results controller that doesnt conform to update search results protocol (?)
            
            
        } catch {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //get cell from the queue
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrabbleCell", for: indexPath) //make sure the "ScrabbleCell" part matches the unique id you gave it in the story board
        
        cell.textLabel?.text = words[indexPath.row]//has both section and row and only want row at this point, indexpath is a tuple
        
        return cell
    }
    
    //delegate method bc responds to user interaction on the interface
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Word Selected", message: "You selected \(words[indexPath.row])", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil) //so user can close it
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
        //could be where you transtion to a new view controlle or show details etc
    }
    
    

}

