//
//  Ecosystem.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

class Ecosystem: CustomStringConvertible {
    
    var factors = [String: Factor]()
    var description: String
    
    init(name: String) {
        description = name
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
        print("Next Cycle")
    }
    
    func printFactors() {
        for f in factors {
            print(f.0)
        }
    }
}



