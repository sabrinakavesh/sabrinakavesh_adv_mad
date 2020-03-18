//
//  Alert.swift
//  lab4
//
//  Created by Sabrina on 3/10/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import Foundation

struct Alert: Decodable {
    let category: String
    let description: String
    let title: String
}

struct AlertData: Decodable {
    var data = [Alert]()
}
