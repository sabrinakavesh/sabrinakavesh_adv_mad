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
    
    //load the data
    func loadData() {
        //get authenticated users id
        let authUserId = Auth.auth().currentUser?.uid
        
        if let userID = authUserId {
            
            
            db.collection("users").document(userID).collection("runs").addSnapshotListener({querySnapshot, error in
                        //check for results
                        guard let collection = querySnapshot else {
                            print("error fetching collectin: \(error!)")
                            return
                        }
                        
                        //get al lthe documents in teh collection
                        let docs = collection.documents
                        
                        //empty current data
                        self.runData.removeAll()
                        
                        for doc in docs {
                            let data = doc.data()
                            //get the date
                            let date = (data["Date"] as! Timestamp).dateValue()
                            //get the miles
                            let miles = data["Miles"] as! Double
                            //get notes
                            let notes = data["Notes"] as! String
                            
                            //get the id
                            let id = doc.documentID
                            
                            let newRun = Run(date: date, miles: miles, notes: notes, id: id)
                            
                            self.runData.append(newRun)
                        }
                        
            //            print(self.runData)
                        //pass data onto new view controller
                        self.onDataUpdate(self.runData)
                    
                    })
        }
        else {
            print("could not find authenicated users id")
        }
        
        
        
    }
    
    
    //write a new run to database
    func writeData(date: Date, miles: Double, notes: String) {
        
        let authUserId = Auth.auth().currentUser?.uid
        
        if let userID = authUserId {
            db.collection("users").document(userID).collection("runs").addDocument(data: [
                "Date": Timestamp(date: date),
                "Miles": miles,
                "Notes": notes
            ])

        }
        
    }
    
}
