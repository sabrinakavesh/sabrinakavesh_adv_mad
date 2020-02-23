//
//  DetailViewController.swift
//  lab2
//
//  Created by Sabrina on 2/22/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var statesData = StatesDataController()
    var selectedState = 0
    var cityList = [String]()
    
    override func viewWillAppear(_ animated: Bool) { //viewwillappear laods every time the view appears
        cityList = statesData.getCities(idx: selectedState)
    }

    override func viewDidLoad() { //only called teh first time a view is loaded
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //called automatically
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        if segue.identifier == "save" {
            //downcast to access members
            let source = segue.source as! AddCityViewController
            
            //update the model, double check to make sure new city name is not empty
            if source.addedCity.isEmpty == false {
                //update the model, add new city to data model, notify of changes
                statesData.addCity(dataIdx: selectedState, newCity: source.addedCity, cityIdx: cityList.count)
                
                //update the local copy
                cityList.append(source.addedCity)
                
                //update the table view based on data changes
                tableView.reloadData()
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = cityList[indexPath.row]

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //notify data model
            cityList.remove(at: indexPath.row)
            //update instance
            statesData.deleteCity(dataIdx: selectedState, cityIdx: indexPath.row)
            //update table
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        //get idx of rows
        let fromRow = fromIndexPath.row
        let toRow = to.row
        
        //get name of country being moved
        let moveCity = cityList[fromRow]
        
        //swap in array
        cityList.swapAt(fromRow, toRow)
        
        //swap in data controller
        statesData.deleteCity(dataIdx: selectedState, cityIdx: fromRow)
        statesData.addCity(dataIdx: selectedState, newCity: moveCity, cityIdx: toRow)

    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
