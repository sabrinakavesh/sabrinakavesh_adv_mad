//
//  RunDataController.swift
//  miles
//
//  Created by Sabrina on 2/27/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import Foundation
import Firebase

struct Run {
    var date: Date
    var miles: Double
    var notes: String
    var id: String
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }//get consistent date formatting
    
}

class RunDataController {
    //store reference to database
    var db: Firestore!
    
    //store data locally
    var runData = [Run]() //initalized to empty
    
    //notify view controller
    var onDataUpdate: (([Run]) -> Void)!
    
    init() {
        //use default settings
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        //init db ref
        db = Firestore.firestore()
    }
    
}
