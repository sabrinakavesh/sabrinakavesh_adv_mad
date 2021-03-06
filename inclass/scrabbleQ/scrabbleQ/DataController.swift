//
//  DataController.swift
//  scrabbleQ
//
//  Created by Sabrina on 1/30/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import Foundation

enum DataError: Error {
    case NoDataFile
    case CouldNotDecode
    case NoWords
}

class DataController {
    var qNoWords: [String]?
    var filename = "q-words-no-u"
    
    func loadWords() throws {
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: ".plist") {
            let plistDecoder = PropertyListDecoder()
            //decode to array of strings
            do {
                let data = try Data(contentsOf: pathURL) //raw bite buffer data
                qNoWords = try plistDecoder.decode([String].self, from: data)
                
            } catch {
                throw DataError.CouldNotDecode
            }
        } else {
            throw DataError.NoDataFile
        }
    }
    
    func getWords() throws -> [String] {
        if let words = qNoWords {
            //we have words!
            return words
        } else {
            throw DataError.NoWords
        }
    }
}
