//
//  LocalStorageService.swift
//  realEstateList
//
//  Created by Erik Hede on 06/06/2019.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

class LocalStorageService {
    
    private let userDefaults = UserDefaults()
    private let key = "favourites"
    
    func save(favourites: [Int]) {
        
        var favs = userDefaults.object(forKey: key) as? [Int] ?? [Int]()
        for fav in favourites {
            favs.append(fav)
        }
        userDefaults.set(favs, forKey: key)
    }
    
    func deleteFavourites() {
        userDefaults.removeObject(forKey: key)
        print(userDefaults.array(forKey: key))
    }
    
    func fetchFavourites() -> [Int]? {
        let favourites = userDefaults.array(forKey: key) as? [Int] ?? [Int]()
        return favourites
    }
}

