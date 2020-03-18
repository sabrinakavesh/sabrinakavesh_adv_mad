////
////  ResultsViewController.swift
////  lab4
////
////  Created by Sabrina on 3/10/20.
////  Copyright © 2020 Sabrina. All rights reserved.
////
//
//import UIKit
//
//class ResultsViewController: UITableViewController {
//    
//    var results = [Translate]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return results.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertCell", for: indexPath)
//
//        // Configure the cell...
//        cell.textLabel!.text = results[indexPath.row].translation
//
//        return cell
//    }
//
//
//    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "DetailSegue" {
//            //get the selected campsites
//            let idx = tableView.indexPath(for: sender as! UITableViewCell)
//            let selectedAlert = results[idx!.row]
//            
//            
//            let detailVC = segue.destination as! DetailViewController
//            
//            detailVC.title = selectedAlert.translation
//            detailVC.siteCategory = selectedAlert.text
//            detailVC.siteDescription = selectedAlert.translated
//        }
//    }
//
//}
