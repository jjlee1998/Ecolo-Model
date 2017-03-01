//
//  Savanna.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

class Savanna: CustomStringConvertible {
    
    var factors = [String: Factor]()
    var relationships = Set<Relationship>()
    var description = "Savanna Ecosystem!"
    
    init(){}
    
    func add(_ factor: Factor) {
        factors[factor.description] = factor
    }
    
    func add(_ relationship: Relationship) -> Bool {
        if factors.values.contains(relationship.factorX) || factors.values.contains(relationship.factorY) {
            relationships.insert(relationship)
            return true
        }
        return false
    }
    
    func nextCycle() {
        print("Next Cycle")
    }
    
    func printFactors() {
        for f in factors {
            print(f.0)
        }
    }
    
    func printRelationships() {
        for r in relationships {
            print(r)
        }
    }

}



