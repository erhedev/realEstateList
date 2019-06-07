//
//  Formatter+Extension.swift
//  realEstateList
//
//  Created by Erik Hede on 07/06/2019.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}
