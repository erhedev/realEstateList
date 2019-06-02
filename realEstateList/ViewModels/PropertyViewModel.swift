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
    let propertyViewModels: [PropertyViewModel]
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
}

struct PropertyViewModel {
    
    let property: Property
    
    init(_ property: Property) {
        self.property = property
    }
    
}

extension PropertyViewModel {
   
    var address: Observable<String> {
        return Observable<String>.just(property.streetAddress)
    }
    var price: Observable<String> {
        return Observable<String>.just(String(property.listPrice))
    }
    var thumbNailURL: Observable<String> {
        return Observable<String>.just(property.thumb)
    }
    
}
