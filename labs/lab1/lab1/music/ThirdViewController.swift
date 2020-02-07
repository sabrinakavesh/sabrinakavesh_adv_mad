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
    let artistComp = 0
    let albumComp = 1 //artist is first component, album is 2nd component
    
    //vars
    var artistAlbums = ArtistAlbumsController()
    var artists = [String]()
    var albums = [String]()
    
    //view connections
    @IBOutlet weak var artistPicker: UIPickerView!
    @IBOutlet weak var artistLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call methods from artisalbumscontroller
        do {
            try artistAlbums.loadData()
            artists = try artistAlbums.getAllArtists()
            albums = try artistAlbums.getAlbums(idx: 0)
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
        if component == artistComp {
            return artists.count
        } else if component == albumComp {
            return albums.count
        } else {
            print("Unknown component")
            return -1
        }
    }
    
    //Picker Delegate methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //switch based on component
        if component == artistComp {
            return artists[row]
        } else if component == albumComp {
            return albums[row]
        } else {
            print("Unknown component")
            return "Unknown"
        }
    }
    
    //1: update albums and label when artist component is changed
    //2: update label when album component is change
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //check whcih compnent changed
        if component == artistComp {
            //task 1
            do {
                albums = try artistAlbums.getAlbums(idx: row)
                //if changed artist component, component = 0
            } catch {
                print(error)
            }
            //we need to reload ocmponent so it doesnt reuse data (i.e. changed to drake from rihanna and tries to get 7th album it doesnt exist
            //reload compnent
            artistPicker.reloadComponent(albumComp)
            artistPicker.selectRow(0, inComponent: albumComp, animated: true)
            
        }
        //get the currently seleted indices artist and album
        let artistIdx = pickerView.selectedRow(inComponent: artistComp)
        let albumIdx = pickerView.selectedRow(inComponent: albumComp)
        
        artistLabel.text = "You like \(albums[albumIdx]) by \(artists[artistIdx])" //named choiceLabel in example
    }
    


}
