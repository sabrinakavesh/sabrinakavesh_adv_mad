//
//  DetailViewController.swift
//  pictureCollection
//
//  Created by Sabrina on 2/18/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //hold the name of the image
    var imageName : String?
    
    //connection
    @IBOutlet weak var imageView: UIImageView!
    
    //called when action buttin in nav bar is selected
    @IBAction func share(_ sender: Any) {
        var imageArray = [UIImage]() //only sharing one, but still need to pass in as an array
        
        imageArray.append(imageView.image!)
        
        let shareScreen = UIActivityViewController(activityItems: imageArray, applicationActivities: nil)
        
        shareScreen.modalPresentationStyle = .popover
        present(shareScreen, animated: true, completion: nil)
    }
    
    //set the source fo rthe image view
    override func viewWillAppear(_ animated: Bool) {
        if let name = imageName {
            imageView.image = UIImage(named: name)
        }
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
