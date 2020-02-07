//
//  SecondViewController.swift
//  music
//
//  Created by Sabrina on 1/23/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var musicPicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    let genres = ["Rock", "Country", "Indie", "Hip Hop", "Pop"]
    let decades = ["1960s", "1970s", "1980s", "1990s", "2000s", "2010s"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: dataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 //multiple components so return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return genres.count
        } else if component == 1 {
            return decades.count
        } else {
            print("Unknown component")
            return -1
        }
    }
    
    //MARK: delegate methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return genres[row]
        } else if component == 1 {
            return decades[row]
        } else {
            print("Unkown component")
            return nil //wants an optional string
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let genre = pickerView.selectedRow(inComponent: 0)
        let decade = pickerView.selectedRow(inComponent: 1)
        //use genre and decade to create label
        choiceLabel.text = "You like \(genres[genre]) from the \(decades[decade])"
    }
    


}

