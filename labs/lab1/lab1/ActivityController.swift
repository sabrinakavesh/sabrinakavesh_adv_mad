//
//  ArtistAlbumsController.swift
//  music
//
//  Created by Sabrina on 1/23/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import Foundation

enum DataError: Error {
    case BadFilePath
    case CouldNotDecodeData
    case NoData
}

class ActivityController { //same name as file
    //properties
    var activityPlaylistData: [ActivityPlaylist]? //made optional so when we load data later thres a chance it could fail so wouldn't have any data so don't want to assume we will have data when its possible we wont
    let filename = "artist-albums"
    
    //read from plist and decode to array of ArtistAlbums struct
    func loadData() throws { //throws: eitehr this function will execute correctly or we will throw an error
        print("Loading Data....")
        
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist") {
            //found the file
            let decoder = PropertyListDecoder()
            
            do {
                let data = try Data(contentsOf: pathURL)
                activityPlaylistData = try decoder.decode([ActivityPlaylist].self, from: data)
                print("Data loaded")
            } catch {
                throw DataError.CouldNotDecodeData
            }
            
        } else {
            throw DataError.BadFilePath
        }
    }
    
    //get all the artists and return array of strings
    func getAllLocations() throws -> [String] {
        var location = [String]()

        if let data = activityPlaylistData {
            //we have data
            for activityStruct in data {
                location.append(activityStruct.name)
            }
            return location
        } else {
            throw DataError.NoData
        }
    }
    
    //get all the albums for any of the artists
    func getActivities(idx: Int) throws -> [String] {
        //make sure we have dat
        if let data = activityPlaylistData {
            //good data
            return data[idx].category
        } else {
            //no dat
            throw DataError.NoData
        }
        
    }
    
    
}
