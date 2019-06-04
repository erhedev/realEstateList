//
//  Properties.swift
//  realEstateList
//
//  Created by Erik Hede on 02/06/2019.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

struct PropertyResponse: Decodable {
    let count: Int
    let results: [Property]
}

struct Property: Codable {
    let booliId: Int
    let listPrice: Int
    let published: String
    let streetAddress: String
    let objectType: String
    let daysActive: Int
    let rooms: Int
    let livingArea: Int
    let constructionYear: Int
    let thumb: String
}
