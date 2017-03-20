//
//  Ecosystem.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

protocol EcosystemProtocol {
}

protocol FactorDelegate {
    func getCycle() -> Int
}

class Ecosystem: CustomStringConvertible, EcosystemProtocol, FactorDelegate {
    
    var cycle = 0
    var factors = [String: Factor]()
    var description: String
    
    init(name: String) {
        description = name
    }
    
    func add(_ factor: Factor) {
        factors[factor.description] = factor
    }
    
    func getCycle() -> Int {
        return cycle
    }
    
    @discardableResult func addResourceTimeBinding(resource: Factor, amplitude: Double, offset: Int) -> Bool {
        if factors.values.contains(resource) {
            let startLevel = resource.level
            sun.add(equation: {resource.setLevel(to: startLevel + amplitude * sin(Double(resource.delegate.getCycle() - offset) * M_PI / 180)); return 0.0}, frequency: 1)
            return true
        }
        return false
    }
    
    @discardableResult func addOrganismDieoff(organism: BioFactor, mortalityRate: Double) -> Bool {
        if factors.values.contains(organism) {
            organism.add(equation: {-(mortalityRate * organism.level)}, frequency: 1)
            return true
        }
        return false
    }
    
    /*@discardableResult func addResourceResourceBinding(dependentResource: Factor, independentResource: Factor) -> Bool {
        if factors.values.contains(dependentResource) && factors.values.contains(independentResource) {
            dependentResource.add(equation: {-0.0008 * independentResource.level + 4.0}, frequency: 1)
            return true
        }
        return false
    }*/
    
    @discardableResult func addPreyResourceBinding(prey: BioFactor, resource: Factor, intrisicGrowthRate: Double) -> Bool {
        if factors.values.contains(resource) && factors.values.contains(prey) {
            prey.add(equation: {intrisicGrowthRate * prey.level * (1 - (prey.level / resource.level))}, frequency: prey.reproductionFrequency)
            return true
        }
        return false
    }
    
    @discardableResult func addPredatorPreyBinding(predator: BioFactor, prey: BioFactor, attackRate: Double, conversionEfficiency: Double) -> Bool {
        if factors.values.contains(predator) && factors.values.contains(prey) {
            prey.add(equation: {-attackRate * prey.level * predator.level}, frequency: 1)
            predator.add(equation: {conversionEfficiency * prey.level * predator.level}, frequency: predator.reproductionFrequency)
        }
        return false
    }
    
    func nextCycle() {
        cycle += 1
        for factor in factors.values {
            factor.nextCycle()
            factor.update()
        }
    }
    
    func printFactors() {
        for factor in factors.values {
            print(factor)
        }
    }
}



