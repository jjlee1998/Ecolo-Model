
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
    let name: String
    var delegate: FactorDelegate
    /*private(set)*/ var level: Double
    var delta = 0.0
    var equations = [(Int, () -> Double)]()
    var description: String {
        return "\(name)"
    }
    
    init(name: String, level: Double, delegate: FactorDelegate) {
        self.name = name
        hashValue = Factor.nextHashValue
        Factor.nextHashValue += 1
        self.level = level
        self.delegate = delegate
    }
    
    static func ==(f1: Factor, f2: Factor) -> Bool {
        return f1.hashValue == f2.hashValue
    }
    
    func setLevel(to newLevel: Double) {
        level = newLevel
    }
    
    func getLevel() -> Double {
        //print("Level \(level) gotten for \(name)")
        return level
    }
    
    func add(equation: @escaping () -> Double, frequency: Int) {
        if frequency > 0 {
            equations.append((frequency, equation))
        }
    }
    
    func nextCycle() {
        delta = 0.0
        for (frequency, equation) in equations {
            if delegate.getCycle() % frequency == 0 {
                delta += equation()
            }
        }
    }
    
    func update() {
        level += delta / Double(delegate.getEulerIntervals())
        if level < 1e-6 {
            level = 0
        }
    }
}
