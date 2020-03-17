//
//  LangDialects.swift
//  project1
//
//  Created by Sabrina on 3/14/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import Foundation

struct LangDialects: Decodable {
    let langCategory: String
    let dialects: [String]
}

struct DialectTranslation: Decodable {
    let translated: String
    let text: String
    let translation: String
}

struct DialectTranslationData: Decodable {
    var data = [DialectTranslation]()
}
