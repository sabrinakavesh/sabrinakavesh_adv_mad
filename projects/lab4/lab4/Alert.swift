//
//  Alert.swift
//  lab4
//
//  Created by Sabrina on 3/10/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import Foundation

struct Translate: Decodable {
    let translated: String
    let text: String
    let translation: String
}

struct TranslateData: Decodable {
    var data = [Translate]()
}
