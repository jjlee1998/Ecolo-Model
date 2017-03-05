//
//  Ecosystem.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

protocol FactorDelegate {
    func getSeasonNumber() -> Int
}

class Ecosystem: CustomStringConvertible, FactorDelegate {
    
    var season = 10
    var factors = [String: Factor]()
    var description: String
    
    init(name: String) {
        description = name
    }
    
    func getSeasonNumber() -> Int {
        return season
    }
    
    func add(_ factor: Factor) {
        factors[factor.description] = factor
    }
    
    @discardableResult func addFactorTargetBinding(consumingFactor: Factor, consumedFactor: Factor, relationship: @escaping (Factor, Factor) -> Void) -> Bool {
        
        guard factors.values.contains(consumingFactor) else {
            print("Could not add binding; could not find \(consumingFactor)")
            return false
        }
        
        guard factors.values.contains(consumedFactor) else {
            print("Could not add binding; could not find \(consumedFactor)")
            return false
        }
        
        factors[consumingFactor.description]?.addTargetFactor(target: consumedFactor, relationship: relationship)
        return true
    }
    
    func nextCycle() {
        season += 1
        if season > 10 {
            season = 1
        }
        for factor in factors.values {
            factor.executeRules()
            factor.update()
        }
    }
    
    func printFactors(withTargets: Bool = false) {
        for factor in factors.values {
            print(factor)
            if withTargets {
                factor.printTargets()
            }
            
        }
    }
}



