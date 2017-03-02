//
//  SavannaAbioticElement.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

class Factor: CustomStringConvertible, Hashable {
    
    // This is an array of the stuff this factor eats, along with the equation governing that eating
    var targetFactors = [Factor: (Factor, Factor) -> Void]()
    
    var name: String
    static var nextHashValue = 0
    var hashValue: Int
    var level: Double
    var health: Double
    var description: String {
        return "\(name) – lvl \(level), health \(health), consumes: \(targetFactors.keys.map{$0.name})"
    }
    
    init(factorName: String, initialLevel: Double, initialHealth: Double) {
        hashValue = Factor.nextHashValue
        Factor.nextHashValue += 1
        level = initialLevel
        health = initialHealth
        name = factorName
    }
    
    static func ==(f1: Factor, f2: Factor) -> Bool {
        return f1.hashValue == f2.hashValue
    }
    
    func addTargetFactor(target: Factor, relationship: @escaping (Factor, Factor) -> Void) {
        targetFactors[target] = relationship
    }
}
