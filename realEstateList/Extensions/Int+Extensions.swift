//
//  Int+Extensions.swift
//  realEstateList
//
//  Created by Erik Hede on 07/06/2019.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
