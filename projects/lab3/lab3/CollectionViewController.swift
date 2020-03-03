//
//  CollectionViewController.swift
//  lab3
//
//  Created by Sabrina on 3/2/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

     var parkImages = [String]() //this is lazy way to do this, but hsould use mvc structure in practice
       
       //constants for layout
       let spacing : CGFloat = 8 //8 margin around collection view
       let numberItemsPerRow : CGFloat = 3 //core graphics float, can use when working with graphics
       let spacingBetweenCells : CGFloat = 8

       override func viewDidLoad() {
           super.viewDidLoad()
           
           //populate array wiht image names
           for i in 1...20 {
               parkImages.append("park" + String(i)) //
           }
           
           //instantiate
           let layout = UICollectionViewFlowLayout()
           //configure layout
           layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing) //margins
           layout.minimumLineSpacing = spacing
           layout.minimumInteritemSpacing = spacing
           //apply to collction view
           collectionView.collectionViewLayout = layout
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           //gets called everytime it creates a new item and says how large it should be
           //get total amount of empty space
           let totalSpacing = (2 * spacing) + ((numberItemsPerRow - 1) * spacingBetweenCells)
           let width = (collectionView.bounds.width - totalSpacing) / numberItemsPerRow //substract total amount of white space
           
           return CGSize(width: width, height: width)
       }

       
       // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using [segue destinationViewController].
            //Pass the selected object to the new view controller.
           
           //check identified
           if segue.identifier == "showDetail" {
               //get ref to destination controller
               let detailVC = segue.destination as! DetailViewController
               //get the cell
               let indexPath = collectionView.indexPath(for: sender as! CollectionViewCell)
               
               //set properties in destionation
               detailVC.title = "Park #\(indexPath!.row) "
               detailVC.imageName = parkImages[indexPath!.row]
           }
       }
       

       // MARK: UICollectionViewDataSource

       override func numberOfSections(in collectionView: UICollectionView) -> Int {
           //return the number of sections
           return 1
       }


       override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           // return the number of items
           return parkImages.count
       }

       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell //downcast so we have access to imagry in that class and bc we know they are all images
       
           //construct uiimage and set source of imageView
           let image = UIImage(named: parkImages[indexPath.row])
           cell.imageView.image = image
       
           return cell
       }
       
       //set size for header
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
           return CGSize.init(width: 50, height: 50)
       }
       
       //set content for header
       override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
           var header : HeaderView?
            var footer : FooterView?
        
//        switch kind {
//
//        case UICollectionView.elementKindSectionHeader:
//                   header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? HeaderView
//                   header?.headerLabel.text = "2019"
//            return header!
//
//        case UICollectionView.elementKindSectionFooter :
//                footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as? FooterView
//                footer?.footerLabel.text = "Over 327 Million people visited National Parks in 2019"
//            return footer!
//
//        default:
//            assert(false, "Unexpected element kind")
//        }
        
           if kind == UICollectionView.elementKindSectionHeader {
               header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? HeaderView
               header?.headerLabel.text = "2019"
                return header!
           }
        if kind == UICollectionView.elementKindSectionFooter {
            footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as? FooterView
            footer?.footerLabel.text = "Over 327 Million people visited National Parks in 2019"
            
            return footer!
        }
           
//        return header!; footer
        fatalError()
       }
    
    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//            var footer : FooterView?
//
//            if kind == UICollectionView.elementKindSectionFooter {
//                footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as? FooterView
//                footer?.footerLabel.text = "Over 327 Million people visited National Parks in 2019"
//            }
//
//            return footer!
//           }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
