//
//  ViewController.swift
//  lab4
//
//  Created by Sabrina on 3/10/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //list of states
    let stateOptions = ["Yoda", "Oldenglish",
    "Shakespeare",
    "Pirate",
    "Ermahgerd",
    "Minion",
    "Groot",
    "Ferb-latin",
    "Na&apos;vi",
    "Romulan",
    "Vulcan",
    "Klingon",
    "Sith",
    "Mandalorian",
    "Dothraki",
    "Valyrian"]
    
    //holds current selected state
    var selectedState = String()
    //instantiate data controller
    var alertDC = AlertDataController()
    //local copy of results
    var data = [Translate]()

    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var dialectPicker: UIPickerView!
    @IBOutlet weak var translatedTextLabel: UILabel!
    
    //    var textToTranslate = String()
//    textToTranslate = String(inputText.text!)
    
    @IBAction func searchAlerts(_ sender: Any) {
        //load data
        let urlString = String(inputText.text!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        alertDC.loadJson(stateCode: urlString!, dialect: selectedState)
        
//        let alert = UIAlertController(title: nil, message: "Searching in \(selectedState)", preferredStyle: .alert)
//
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.medium
//        loadingIndicator.startAnimating()
//
//        //add spinner
//        alert.view.addSubview(loadingIndicator)
//        present(alert, animated: true, completion: nil)
        

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //init to first item in state array
        selectedState = stateOptions[0]
        
        alertDC.onDataUpdate = {[weak self](data: [Translate]) in self?.searchDone(translate: data)}
    }
    
    //notified when we have data
    func searchDone(translate: [Translate]) {
        dismiss(animated: true, completion: nil)
        
        data = translate
        
        performSegue(withIdentifier: "SearchResults", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //check segue id
//        if segue.identifier == "SearchResults" {
//            //downcast destination
//            let resultsVC = segue.destination as! ResultsViewController
//
//            resultsVC.title = "\(selectedState) Alerts"
//            resultsVC.results = data
//        }
//    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stateOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stateOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedState = stateOptions[row]
        translatedTextLabel.text = data[row].translation

    }


}

