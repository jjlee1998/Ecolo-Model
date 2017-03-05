//
//  SavannaAbioticElement.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

class Factor: CustomStringConvertible, Hashable {
    
    // Basic identification values:
    var name: String
    static var nextHashValue = 0
    var hashValue: Int
    var canReproduce: Bool
    let changeWeighting = 0.25
    
    // The factor can send requests to the delegate for global variables such as the season:
    var delegate: FactorDelegate
    
    // The array that contains all of this factor's targets – i.e., what it consumes – and the rules governing such:
    var targetFactors = [Factor: (Factor, Factor) -> Void]()
    
    // The current data for the factor:
    var level: Double
    var health: Double
    var description: String {
        return "\(name) – lvl \(level), health \(health))"
    }
    
    // The queued values for the next cycle.
    // Because multiple rules might want to set this factor's level and health to different values, we need to ...
    //... buffer them and take the average. These are the buffers:
    var nextLevelBuffer = [Double]()
    var nextHealthBuffer = [Double]()
    
    // Initializer:
    init(factorName: String, initialLevel: Double, initialHealth: Double, delegate: FactorDelegate, canReproduce: Bool) {
        name = factorName
        hashValue = Factor.nextHashValue
        Factor.nextHashValue += 1
        level = initialLevel
        health = initialHealth
        self.delegate = delegate
        self.canReproduce = canReproduce
    }
    
    // Required by the Equitable Protocol, which is required by the Hashable Protocol:
    static func ==(f1: Factor, f2: Factor) -> Bool {
        return f1.hashValue == f2.hashValue
    }
    
    // Called by the public to add a new level to the nextLevelBuffer:
    func requestNextLevel(_ nextLevel: Double) {
        nextLevelBuffer.append(nextLevel)
    }
    
    // Called by the public to add a new health to the nextHealthBuffer:
    func requestNextHealth(_ nextHealth: Double) {
        nextHealthBuffer.append(nextHealth)
    }
    
    // Called by the public to add new targets and new rules to this factor:
    func addTargetFactor(target: Factor, relationship: @escaping (Factor, Factor) -> Void) {
        targetFactors[target] = relationship
    }
    
    // Public utility function to print this factor's targets:
    func printTargets() {
        var resultString = "\t\(name) Targets:"
        for key in targetFactors.keys {
            resultString += " \(key.name),"
        }
        resultString.remove(at: resultString.index(before: resultString.endIndex))
        print(resultString)
    }
    
    func executeRules() {
        for (target, ruleFunction) in targetFactors {
            ruleFunction(self, target)
        }
    }
    
    func update() {
        var desiredNextLevel = level
        var desiredNextHealth = health
        if nextLevelBuffer.count != 0 {
            desiredNextLevel = (nextLevelBuffer.reduce(0, +) / Double(nextLevelBuffer.count))
        }
        if nextHealthBuffer.count != 0 {
            desiredNextHealth = (nextHealthBuffer.reduce(0, +) / Double(nextHealthBuffer.count))
        }
        level += (desiredNextLevel - level) * changeWeighting
        health += (desiredNextHealth - health) * changeWeighting
        nextLevelBuffer.removeAll()
        nextHealthBuffer.removeAll()
        reproduceOrDie()
    }
    
    func reproduceOrDie() {
        if health >= 500.0 && canReproduce && delegate.getSeasonNumber() == 5 {
            level *= 1.1
        } else if health <= 500 {
            level /= 1.1
        }
    }
}
