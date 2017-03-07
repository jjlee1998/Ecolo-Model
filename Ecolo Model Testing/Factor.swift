//
//  SavannaAbioticElement.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

class Factor: CustomStringConvertible, Hashable {
    
    var name: String
    static var nextHashValue = 0
    var hashValue: Int
    var populationEquations = [() -> Double]()
    var level: Double
    var delta = 0.0
    var description: String {
        return "\(name) – lvl \(level)"
    }
    
    init(factorName: String, initialLevel: Double) {
        name = factorName
        hashValue = Factor.nextHashValue
        Factor.nextHashValue += 1
        level = initialLevel
    }
    
    // Required by the Equitable Protocol, which is required by the Hashable Protocol:
    static func ==(f1: Factor, f2: Factor) -> Bool {
        return f1.hashValue == f2.hashValue
    }
    
    // Called by the public to add new targets and new rules to this factor:
    func add(equation: @escaping () -> Double) {
        populationEquations.append(equation)
    }
    
    func nextCycle() {
        delta = populationEquations.reduce(0.0, {$0 + $1()})
        //print("\(name) delta \(delta)")
    }
    
    func update() {
        level += delta
    }
}
