//
//  ArtistAlbumsController.swift
//  music
//
//  Created by Sabrina on 1/23/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import Foundation

class ArtistAlbumsController { //same name as file
    //properties
    var artistAlbumsData: [ArtistAlbums]? //made optional so when we load data later thres a chance it could fail so wouldn't have any data so don't want to assume we will have data when its possible we wont
    let filename = "artist-albums"
    
    //read from plist and decode to array of ArtistAlbums struct
    func loadData() {
        
    }
    
    //get all the artists and return array of strings
    func getAllArtists() -> [String] {
        
    }
    
    //get all the albums for any of the artists
    func getAlbums(idx: Int) {
        
    }
    
    
}
