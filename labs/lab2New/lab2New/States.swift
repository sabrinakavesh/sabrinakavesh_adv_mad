//
//  States.swift
//  lab2
//
//  Created by Sabrina on 2/20/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import Foundation
import UIKit


//need to conform to codabel protocal since using encoding adn decoding
struct StatesDataModel: Codable {
    var state: String
    var cities: [String]
}

enum DataError: Error {
    case NoDataFile
    case CouldNotDecode
    case CouldNotEncode
}

class StatesDataController {
    
    var allData = [StatesDataModel]()
    let fileName = "usStates"
    let userDataFileName = "data.plist"
    
    init() {
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(StatesDataController.writeData(_:)), name: UIApplication.willResignActiveNotification, object: app) //only want this type of notification when posted from 'this' object, which is our own app
    }
    
    func getDataFile(dataFile: String) -> URL {
        //get path fro data file
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let docDir = dirPath[0] //documetns directory
        
        //url for our plist
        return docDir.appendingPathComponent(dataFile)
    }
    
    @objc func writeData(_ notification: NSNotification) throws {
        let dataFileURL = getDataFile(dataFile: userDataFileName)
        //get an encoder
        
        let encoder = PropertyListEncoder()
        //have to set the format of the output when encoding
        //set format - plist is a type of xml
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(allData.self)
            try data.write(to: dataFileURL)
            //encode data and write to file
        } catch {
            print(error)
            throw DataError.CouldNotEncode
        }
    }

    
    //load data from plist
    func loadData() throws {
        let pathURL: URL?
        //get the path where our data file would be
        let dataFileUrl = getDataFile(dataFile: userDataFileName)
        
        //check to see if the dat fiel exists
        if FileManager.default.fileExists(atPath: dataFileUrl.path){
                  pathURL = dataFileUrl
                  print("loading from user data!")
        } else {
            //load default data if we cant find a user data file
          pathURL = Bundle.main.url(forResource: fileName, withExtension: "plist")
          
        }
        
        //check for file and get url if possible
        if let dataURL = Bundle.main.url(forResource: fileName, withExtension: "plist") {
            
            let decoder = PropertyListDecoder()
            
            do {
                //get byte buffer (raw data)
                let data = try Data(contentsOf: dataURL)
                //decode to our model
                allData = try decoder.decode([StatesDataModel].self, from: data)
            } catch {
                throw DataError.CouldNotDecode
            }
            
        } else {
            //couldn't get path
            throw DataError.NoDataFile
        }
    }
    
    //fetch all states
    func getStates() -> [String] {
        //init empty array
        var allStates = [String]()
        //loop through data and append ot array
        for item in allData {
            allStates.append(item.state)
        }
        return allStates
    }
    
    //get array of cities based on state
    func getCities(idx: Int) -> [String] {
        return allData[idx].cities
    }
    
    //add a city
    func addCity(dataIdx: Int, newCity: String, cityIdx: Int) {
        allData[dataIdx].cities.insert(newCity, at: cityIdx)
    }
    
    //remove a city
    func deleteCity(dataIdx: Int, cityIdx: Int) {
        allData[dataIdx].cities.remove(at: cityIdx)
    }
}
