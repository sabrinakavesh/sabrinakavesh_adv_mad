//
//  FavoriteController.swift
//  project1
//
//  Created by Sabrina on 3/5/20.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import Foundation
import UIKit

struct Favorite {
    var sourceText : String
    var targetText : String
    var translateLang : String
}

class FavoritesDataController {
    var favorites = [Favorite]()
    
    func addFavorite(source: String, target: String, lang: String) {
        favorites.append(Favorite(sourceText: source, targetText: target, translateLang: lang))
    }
    
    func getFavorites() -> [Favorite] {
        return favorites
    }
    
    //want only one insance to exist at a time
    //dont want an instance in tranlationvc and favoritevc, want instance to be global
    
//    //get array of countries based on continent
//    func getCountries(idx: Int) -> [String] {
//        return allData[idx].countries
//    }
//
//    //add a country
//    func addCountry(dataIdx: Int, newCountry: String, countryIdx: Int) {
//        allData[dataIdx].countries.insert(newCountry, at: countryIdx)
//    }
//
//    //delete a country
//    func deleteCountry(dataIdx: Int, countryIdx: Int) {
//        allData[dataIdx].countries.remove(at: countryIdx)
//    }
}
