//
//  DetailViewController.swift
//  lab4
//
//  Created by Sabrina on 3/10/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
     //data
       var siteDescription = String()
       var siteCategory = String()
       
       
       override func viewWillAppear(_ animated: Bool) {
           descriptionLabel.text = siteDescription
           categoryLabel.text = siteCategory
       }
       
       override func viewDidLoad() {
           super.viewDidLoad()

           // Do any additional setup after loading the view.
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
