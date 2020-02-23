//
//  AddCityViewController.swift
//  lab2
//
//  Created by Sabrina on 2/22/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {
    
    //connect textfield
    @IBOutlet weak var cityTextField: UITextField!
    
    //var to store user input
    var addedCity = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //only care if they hit save
        if segue.identifier == "save" {
            //make sure they emtered info
            if cityTextField.text?.isEmpty == false {
                addedCity = cityTextField.text!
            }
        }
    }
    

}
