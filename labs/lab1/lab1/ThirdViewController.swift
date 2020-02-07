//
//  ThirdViewController.swift
//  music
//
//  Created by Sabrina on 1/23/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    //delegate is how we supply the actual data and handle any action user does on picker
    
    //constants
    let activityComp = 1
    let locationComp = 0 //artist is first component, album is 2nd component
    
    //vars
    var activityPlaylist = ActivityController()
    var activity = [String]()
    var location = [String]()
    
    //view connections
    @IBOutlet weak var artistPicker: UIPickerView!
    @IBOutlet weak var artistLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call methods from artisalbumscontroller
        do {
            try activityPlaylist.loadData()
            activity = try activityPlaylist.getActivities(idx: 0)//
            location = try activityPlaylist.getAllLocations()
        } catch {
            //handle error better
            print(error)
        }
        // Do any additional setup after loading the view.
    }
    
    //datasource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 //can select artist and album
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == activityComp {
            return activity.count
        }
        else if component == locationComp {
            return location.count
        }
        else {
            print("Unknown component")
            return -1
        }
    }
    
    //Picker Delegate methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //switch based on component
        if component == activityComp {
            return activity[row]
        }
        else if component == locationComp {
            return location[row]
        }
        else {
            print("Unknown component")
            return "Unknown"
        }
//        artistLabel.text = "You like \(activity[activityIdx])"
    }
    
    //1: update albums and label when artist component is changed
    //2: update label when album component is change
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        check whcih compnent changed
        if component == locationComp {
            //task 1
            do {
                activity = try activityPlaylist.getActivities(idx: row)
                //if changed artist component, component = 0
            } catch {
                print(error)
            }
            //we need to reload ocmponent so it doesnt reuse data (i.e. changed to drake from rihanna and tries to get 7th album it doesnt exist
            //reload compnent
            artistPicker.reloadComponent(activityComp)
            artistPicker.selectRow(0, inComponent: activityComp, animated: true)

        }
        //get the currently seleted indices artist and album
        let activityIdx = pickerView.selectedRow(inComponent: activityComp)
        let locationIdx = pickerView.selectedRow(inComponent: locationComp)

        artistLabel.text = "You like \(activity[activityIdx]) \(location[locationIdx])" //named choiceLabel in example
    }
    


}
