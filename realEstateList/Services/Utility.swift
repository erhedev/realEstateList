//
//  Utility.swift
//  realEstateList
//
//  Created by Erik Hede on 04/06/2019.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

class Utility {
    // Singleton
    private static let _instance = Utility()
    static var Instance: Utility{
        return _instance
    }
    
    var favIDs = [Int]()
    var checkedCells = [Int]()
    var propertyListViewModel: PropertyListViewModel!
}
