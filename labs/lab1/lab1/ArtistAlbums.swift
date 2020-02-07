//
//  ArtistAlbums.swift
//  music
//
//  Created by Sabrina on 1/23/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import Foundation

struct ArtistAlbums: Decodable {
    let name: String
    let albums: [String]
}
