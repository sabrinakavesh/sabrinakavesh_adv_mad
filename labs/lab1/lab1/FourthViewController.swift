//
//  FourthViewController.swift
//  music
//
//  Created by Sabrina on 1/28/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    let spotifyScheme = "spotify://"
    let appleScheme = "music://"
    let itunesScheme = "http://www.apple.com/music"
    //you can pass specific songs or longer urls to take user to specific song or playlist. just look up specific syntax for web
    //try to open spotify if that doesnt work, try to open appple music, if that then open safari and got to itunes website
    //know they have safari installed
    
    func schemeAvailable(scheme: String) -> Bool {
        //takes in string adn returns a boolean
        //make url from scheme
        if let url = URL(string: scheme) {
            return UIApplication.shared.canOpenURL(url)
            //application: hanldes how ui applicaitons interact and so we are checking shared space to see what apps have been shared with us and we have access to and will return a boolean. true/false if we can open this
        }
        return false
    }
    
    func openApp(scheme: String) {
        if let url = URL(string: scheme) {
            UIApplication.shared.open(url, options: [:], completionHandler: {
                (success) in
                print("successfully opened \(scheme)")
                //whatever we might want to do we put here
                //save data
                //persist user location in app
            })
            //want signature where takes in boolean and returns nothing. can also just type nill for completionHandler, but this
        }
    }
    
    @IBAction func goToMusic(_ sender: Any) {
        let spotifyInstalled = schemeAvailable(scheme: spotifyScheme) //+ rest of url depending on activity
        let appleMusicInstalled = schemeAvailable(scheme: appleScheme)
        
        if spotifyInstalled {
            openApp(scheme: spotifyScheme)
        } else if appleMusicInstalled {
            openApp(scheme: appleScheme)
        } else {
            openApp(scheme: itunesScheme)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //to open: check if application can open a url, then try to open it

        // Do any additional setup after loading the view.
    }
    


}
