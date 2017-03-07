//
//  Ecosystem.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

protocol EcosystemProtocol {
    func getSun() -> Factor
}

class Ecosystem: CustomStringConvertible, EcosystemProtocol {
    
    var sun: Factor
    var cycle = 0
    var factors = [String: Factor]()
    var description: String
    
    init(name: String, sun: Factor) {
        description = name
        self.sun = sun
    }
    
    func add(_ factor: Factor) {
        factors[factor.description] = factor
    }
    
    func getSun() -> Factor {
        return sun
    }
    
    @discardableResult func addPredatorDieoff(predator: Factor, mortalityRate: Double) -> Bool {
        guard factors.values.contains(predator) else {
            print("Could not add binding; could not find predator \(predator)")
            return false
        }
        predator.add(equation: {-(mortalityRate * predator.level)})
        return true
    }
    
    @discardableResult func addResourceResourceBinding(dependentResource: Factor, independentResource: Factor) -> Bool {
        guard factors.values.contains(dependentResource) else {
            print("Could not add binding; could not find predator \(dependentResource)")
            return false
        }
        guard factors.values.contains(independentResource) else {
            print("Could not add binding; could not find prey \(independentResource)")
            return false
        }
        dependentResource.add(equation: {dependentResource.level * (1 - (dependentResource.level / (10000 - independentResource.level)))})
        return true
    }
    
    @discardableResult func addPreyResourceBinding(prey: Factor, resource: Factor, intrisicGrowthRate: Double) -> Bool {
        guard factors.values.contains(resource) else {
            print("Could not add binding; could not find predator \(resource)")
            return false
        }
        guard factors.values.contains(prey) else {
            print("Could not add binding; could not find prey \(prey)")
            return false
        }
        prey.add(equation: {intrisicGrowthRate * prey.level * (1 - (prey.level / resource.level))})
        return true
    }
    
    @discardableResult func addPredatorPreyBinding(predator: Factor, prey: Factor, attackRate: Double, conversionEfficiency: Double) -> Bool {
        guard factors.values.contains(predator) else {
            print("Could not add binding; could not find predator \(predator)")
            return false
        }
        guard factors.values.contains(prey) else {
            print("Could not add binding; could not find prey \(prey)")
            return false
        }
        prey.add(equation: {-attackRate * prey.level * predator.level})
        predator.add(equation: {conversionEfficiency * prey.level * predator.level})
        return true
    }
    
    func nextCycle() {
        cycle += 1
        getSun().level = 4000 + 1000 * cos(Double(cycle) * M_PI / 180 / 10)
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



