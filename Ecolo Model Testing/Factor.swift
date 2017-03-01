//
//  SavannaAbioticElement.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

class Factor: CustomStringConvertible, Hashable {
    
    static var nextHashValue = 0
    var hashValue: Int
    var level: Int
    var description: String
    
    init(factorName: String, initialLevel: Int) {
        self.description = factorName
        level = initialLevel
        hashValue = Factor.nextHashValue
        Factor.nextHashValue += 1
    }
    
    static func ==(f1: Factor, f2: Factor) -> Bool {
        return f1.hashValue == f2.hashValue
    }
}
