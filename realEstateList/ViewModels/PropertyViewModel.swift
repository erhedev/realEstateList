//
//  PropertyViewModel.swift
//  realEstateList
//
//  Created by Erik Hede on 02/06/2019.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct PropertyListViewModel {
    var propertyViewModels: [PropertyViewModel]
}

extension PropertyListViewModel {
    init(_ properties: [Property]) {
        self.propertyViewModels = properties.compactMap(PropertyViewModel.init)
    }
}

extension PropertyListViewModel {
    func propertyAt(_ index: Int) -> PropertyViewModel {
        return self.propertyViewModels[index]
    }
    
    mutating func setPropertyVmFavAt(_ index: Int, bool: Bool) {
        self.propertyViewModels[index].isFavourite = bool
    }
    
    func getFavourites() -> [Property] {
        var favourites = [Property]()
        for property in  self.propertyViewModels {
            if property.isFavourite {
                 favourites.append(property.property)
            }
        }
        return favourites
    }
}


struct PropertyViewModel {
    let property: Property
    var isFavourite: Bool = false
    
    init(_ property: Property) {
        self.property = property
    }
}

extension PropertyViewModel {
   
    var address: Observable<String> {
        return Observable<String>.just(property.streetAddress)
    }
    var price: Observable<String> {
        return Observable<String>.just(String(property.listPrice.formattedWithSeparator + " KR"))
    }
    var thumbNailURL: Observable<String> {
        return Observable<String>.just(property.thumb)
    }
    var id: Observable<Int> {
        return Observable<Int>.just(property.booliId)
    }
    var isOn: Observable<Bool> {
        return Observable<Bool>.just(self.isFavourite)
    }
    
    
}

