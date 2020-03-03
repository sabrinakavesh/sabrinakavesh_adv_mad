//
//  AddRunController.swift
//  miles
//
//  Created by Sabrina on 2/27/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit

class AddRunController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    //outlet connections
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var milesTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    //user input
    var notes : String?
    var date : Date?
    var miles : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(AddRunController.didTapView))
        //when they tap on the view it will call the method
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    //keyboard dismissal
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //override when user enters newline character
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        //all other characters are fine so return true        
        return true
    }
    
    @objc func didTapView() {
        self.view.endEditing(true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SaveSegue" {
            if let userMiles = Double(milesTextField.text!) {
                miles = userMiles
                date = datePicker.date
                if notesTextView.text.isEmpty == false {
                    //user entered notes
                    notes = notesTextView.text
                } else {
                    //no notes
                    print("Not a valid mileage: \(milesTextField.text!)")
                }
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    //keyboard dissmissal
    

}
