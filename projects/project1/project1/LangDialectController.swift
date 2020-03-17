//
//  LangDialectController.swift
//  project1
//
//  Created by Sabrina on 3/14/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import Foundation

enum DataError: Error {
    case BadFilePath
    case CouldNotDecodeData
    case NoData
}

class LangDialectController {
    
    var currentTranslation = DialectTranslationData()
    var onDataUpdate: ((_ data: [DialectTranslation]) -> Void)?
    
    //makes http request based on
//    func loadJson(dialectName: String) throws {
//        let urlPath = "https://api.funtranslations.com/translate/\(dialectName)"
//
//                //check url validity
//        guard let url = URL(string: urlPath) else {
//            //invalid
//            print("bad url")
//            return
//        }
//
//        //valid url
//        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
//            let httpResponse = response as! HTTPURLResponse
//
//            let statusCode = httpResponse.statusCode
//
//            //check response status
//            guard statusCode == 200 else {
//                print("file download error: \(statusCode)")
//                return
//            }
//
//            print("download complete!")
//
//            DispatchQueue.main.async {
//                self.parseJson(rawData: data!)
//            }
//        })
//        //make the request
//        session.resume()
//
//    }
//
//    //parse response and notify view controller
//    func parseJson(rawData: Data) {
//        do {
//            //decode
//            let parsedData = try JSONDecoder().decode(DialectTranslationData.self, from: rawData)
//            //clear the current data
//            currentTranslation.data.removeAll()
//
//            for dialect in parsedData.data {
//                currentTranslation.data.append(dialect)
//            }
//        } catch {
//            print("json parsing error")
//        }
//        print("json parsed successfully!")
//
//        onDataUpdate?(currentTranslation.data)
//    }

    
    //do i need this part? no plural dialect data
    var langDialectData: [LangDialects]?
    let filename = "languages"
    
    func loadData() throws {
        print("loading data....")
        
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist") {
            //found the file
            let decoder = PropertyListDecoder()
            
            do {
                let data = try Data(contentsOf: pathURL)
                langDialectData = try decoder.decode([LangDialects].self, from: data)
                print("Data loaded")
            } catch {
                throw DataError.CouldNotDecodeData
            }
            
        } else {
            throw DataError.BadFilePath
        }
    }
    
    //get all the artists and return array of strings
    func getAllLanguages() throws -> [String] {
        var languages = [String]()
        
        if let data = langDialectData {
            //we have data
            for langStruct in data {
                languages.append(langStruct.langCategory)
            }
            return languages
        } else {
            throw DataError.NoData
        }
    }
    
    //get all the albums for any of the artists
    func getDialects(idx: Int) throws -> [String] {
        //make sure we have dat
        if let data = langDialectData {
            //good data
            return data[idx].dialects
        } else {
            //no dat
            throw DataError.NoData
        }
    }
    
}
