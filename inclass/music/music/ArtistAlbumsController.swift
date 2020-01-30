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

class ArtistAlbumsController { //same name as file
    //properties
    var artistAlbumsData: [ArtistAlbums]? //made optional so when we load data later thres a chance it could fail so wouldn't have any data so don't want to assume we will have data when its possible we wont
    let filename = "artist-albums"
    
    //read from plist and decode to array of ArtistAlbums struct
    func loadData() throws { //throws: eitehr this function will execute correctly or we will throw an error
        print("Loading Data....")
        
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist") {
            //found the file
            let decoder = PropertyListDecoder()
            
            do {
                let data = try Data(contentsOf: pathURL)
                artistAlbumsData = try decoder.decode([ArtistAlbums].self, from: data)
                print("Data loaded")
            } catch {
                throw DataError.CouldNotDecodeData
            }
            
        } else {
            throw DataError.BadFilePath
        }
    }
    
    //get all the artists and return array of strings
    func getAllArtists() throws -> [String] {
        var artists = [String]()
        
        if let data = artistAlbumsData {
            //we have data
            for artistStruct in data {
                artists.append(artistStruct.name)
            }
            return artists
        } else {
            throw DataError.NoData
        }
    }
    
    //get all the albums for any of the artists
    func getAlbums(idx: Int) throws -> [String] {
        //make sure we have dat
        if let data = artistAlbumsData {
            //good data
            return data[idx].albums
        } else {
            //no dat
            throw DataError.NoData
        }
        
    }
    
    
}
