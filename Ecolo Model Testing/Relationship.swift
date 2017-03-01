//
//  SavannaRelationship.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

class Relationship: Hashable, CustomStringConvertible {
    
    let factorX: Factor
    let factorY: Factor
    let equation: (Factor, Factor) -> Void
    var description: String
    var hashValue: Int
    static var nextHashValue = 0
    
    init(factorX: Factor, factorY: Factor, equation:  @escaping (Factor, Factor) -> Void) {
        self.factorX = factorX
        self.factorY = factorY
        self.equation = equation
        description = "Relationship: " + factorY.description + " consumes " + factorX.description
        hashValue = Relationship.nextHashValue
        Relationship.nextHashValue += 1
    }
    
    func execute() {
        equation(factorX, factorY)
    }
    
    static func ==(r1: Relationship, r2: Relationship) -> Bool {
        return r1.hashValue == r2.hashValue
    }
}
