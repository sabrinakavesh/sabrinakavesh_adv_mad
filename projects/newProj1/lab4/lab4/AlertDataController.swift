//
//  AlertDataController.swift
//  lab4
//
//  Created by Sabrina on 3/10/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import Foundation

class AlertDataController {
    //current campsites
    var currentTranslation = TranslateData()
    //closure to notify view controller
    var onDataUpdate: ((_ data: [Translate]) -> Void)?
    
    func loadJson(stateCode: String, dialect: String) {
//        let urlPath = "https://developer.nps.gov/api/v1/alerts?stateCode=\(stateCode)&api_key=Cd66S5mQ2i1uVbOTidvzTjBwPd8a2DexguH3MfT9"
        let dialect = dialect.lowercased()
        let urlPath = "https://api.funtranslations.com/translate/\(dialect).json?text=\(stateCode)"
        
        //check url validity
        guard let url = URL(string: urlPath) else {
            //invalid
            print("bad url")
            return
        }
        //valid url
        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            
            let statusCode = httpResponse.statusCode
            
            //check response status
            guard statusCode == 200 else {
                print("file download error: \(statusCode)")
                return
            }
            
            print("download complete!")
            
            DispatchQueue.main.async {
                self.parseJson(rawData: data!)
            }
        })
        //make the request
        session.resume()
    }
    
    //parse response and notify view controller
    func parseJson(rawData: Data) {
        do {
            //decode
            let parsedData = try JSONDecoder().decode(TranslateData.self, from: rawData)
            //clear the current data
            currentTranslation.data.removeAll()
            
            for translate in parsedData.data {
                currentTranslation.data.append(translate)
            }
        } catch {
            print("json parsing error")
        }
        print("json parsed successfully!")
        
        onDataUpdate?(currentTranslation.data)
    }
}
