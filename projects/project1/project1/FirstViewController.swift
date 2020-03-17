//
//  FirstViewController.swift
//  project1
//
//  Created by Sabrina on 3/5/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var languagePicker: UIPickerView!
    @IBOutlet weak var translatedTextField: UITextView!
    @IBOutlet weak var inputTextField: UITextField!
    
    //constants
    let langComp = 0;
    let dialectComp = 1;
    
    //vars
    var langDialect = LangDialectController()
    var languages = [String]()
    var dialects = [String]()
    
//    var data = [DialectTranslation]()
//    var selectedDialect = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            try langDialect.loadData()
            languages = try langDialect.getAllLanguages()
            dialects = try langDialect.getDialects(idx: 0)
        } catch {
            //handle error better
            print(error)
        }
        
//        selectedDialect = pickerView.selectedRow(inComponent: dialectComp)
//        selectedDialect = dialects[0]
        
//        langDialect.onDataUpdate = {[weak self] (data:[DialectTranslation]) in self?.searchDone(dialectName: data)}
    }
    
//    @IBAction func translateButton(_ sender: Any) {
//        //load data
//        do {
//            try langDialect.loadJson(dialectName: selectedDialect)
//
//            let alert = UIAlertController(title: nil, message: "Translating to \(selectedDialect)", preferredStyle: .alert)
//
//            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 5, width: 50, height: 50))
//            loadingIndicator.hidesWhenStopped = true
//            loadingIndicator.style = UIActivityIndicatorView.Style.medium
//            loadingIndicator.startAnimating()
//
//            //add spinner
//            alert.view.addSubview(loadingIndicator)
//            present(alert, animated: true, completion: nil)
//        } catch {
//            print(error)
//        }
//
//
//    }
    
//    func searchDone(dialectName: [DialectTranslation]) {
//        dismiss(animated: true, completion: nil)
//
//        data = dialectName
//
////        performSegue(withIdentifier: "SearchResults", sender: nil)
//    }

    
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == langComp {
            return languages.count
        } else if component == dialectComp {
            return dialects.count
        } else {
            print ("Unknown component")
            return -1
        }
    }
    
    //Picker Delegate methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //switch based on component
        if component == langComp {
            return languages[row]
        } else if component == dialectComp {
            return dialects[row]
        } else {
            print("Unknown component")
            return "Unknown"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //check whcih compnent changed
        if component == langComp {
            //task 1
            do {
                dialects = try langDialect.getDialects(idx: row)
                //if changed artist component, component = 0
            } catch {
                print(error)
            }
            //we need to reload ocmponent so it doesnt reuse data (i.e. changed to drake from rihanna and tries to get 7th album it doesnt exist
            //reload compnent
            languagePicker.reloadComponent(dialectComp)
            languagePicker.selectRow(0, inComponent: dialectComp, animated: true)
            
        }
        //get the currently seleted indices language and dialect
//        let languageIdx = pickerView.selectedRow(inComponent: langComp)
        let dialectIdx = pickerView.selectedRow(inComponent: dialectComp)
        
        translatedTextField.text = "You chose \(dialects[dialectIdx])"
        
        
//        artistLabel.text = "You like \(albums[albumIdx]) by \(artists[artistIdx])" //named choiceLabel in example
    }
    
//    func showTranslation() {
//        translatedTextField.text = String(inputTextField.text!)
//    }
//
//    @objc func dismissKeyboard() {
//           view.endEditing(true)
//       }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//           textField.resignFirstResponder()
//           return true
//       }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//           showTranslation() //currently updates after each entry, do so only shows when done
//       }



}

