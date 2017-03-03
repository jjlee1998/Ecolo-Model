//
//  SavannaAbioticElement.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

class Factor: CustomStringConvertible, Hashable {
    
    var delegate: FactorDelegate
    var targetFactors = [Factor: (Factor, Factor) -> Void]()
    var name: String
    static var nextHashValue = 0
    var hashValue: Int
    var level: Double
    var levelNextCycle: Double
    var health: Double
    var healthNextCycle: Double
    var description: String {
        return "\(name) – lvl \(level), health \(health))"
    }
    
    init(factorName: String, initialLevel: Double, initialHealth: Double, delegate: FactorDelegate) {
        hashValue = Factor.nextHashValue
        Factor.nextHashValue += 1
        level = initialLevel
        health = initialHealth
        name = factorName
        healthNextCycle = initialHealth
        levelNextCycle = initialLevel
        self.delegate = delegate
    }
    
    static func ==(f1: Factor, f2: Factor) -> Bool {
        return f1.hashValue == f2.hashValue
    }
    
    func addTargetFactor(target: Factor, relationship: @escaping (Factor, Factor) -> Void) {
        targetFactors[target] = relationship
    }
    
    func printTargets() {
        var resultString = "\t\(name) Targets:"
        for key in targetFactors.keys {
            resultString += " \(key.name),"
        }
        resultString.remove(at: resultString.index(before: resultString.endIndex))
        print(resultString)
    }
}
