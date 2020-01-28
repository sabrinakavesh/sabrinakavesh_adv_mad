//
//  FirstViewController.swift
//  music
//
//  Created by Sabrina on 1/23/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var musicPicker: UIPickerView!    
    @IBOutlet weak var choiceLabel: UILabel!
    
    let genres = ["Rock", "Country", "Indie", "Hip Hop", "Pop"] //this is bad practice, dont normally put this code here
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { //components are oclumns in the picker
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    //delegate methodsd are where we supply the components
    //Mark: Picker Delegate Methods
    //most common way to supply data uses picker view title for row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //watn title for each row to be the item in our array at that index
        return genres[row]
    }
    
    //didSelectRow listens for anytime the user changes the selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choiceLabel.text = "You like \(genres[row])" //only get indexes so have to go back and get the title, think it through because if change something you have to change multiple places
    }


}

