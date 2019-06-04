////
////  StorageService.swift
////  realEstateList
////
////  Created by Erik Hede on 04/06/2019.
////  Copyright © 2019 Erik Hede. All rights reserved.
////
//import Foundation
//
//// MARK: - Protocols
//protocol StorageServiceProtocol {
//    func save(property: Property)
//    func fetchProperties() -> [Property]?
//}
//
//class StorageService: StorageServiceProtocol {
//
//    // MARK: - Private Constants
//    private let userDefaults = UserDefaults()
//    private let key = "favourites"
//    
//    // MARK: - Public Functions
//    func save(property: Property) {
//        
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(property) {
//            let defaults = UserDefaults.standard
//            defaults.set(encoded, forKey: key)
//        }
//    }
//    
//    func fetchProperties() -> Int? {
//        let orders = userDefaults.object(forKey: key) as? [Int]
//        return orders?.last
//    }
//}
//
//
//if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
//    let decoder = JSONDecoder()
//    if let loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
//        print(loadedPerson.name)
//    }
//}
