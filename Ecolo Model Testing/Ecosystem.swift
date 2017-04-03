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
    func getEulerIntervals() -> Int
    func getInteractionMatrix() -> Matrix
    func getMortalityMatrix() -> Matrix
    func getFactors() -> [Int: Factor]
}

class Ecosystem: CustomStringConvertible, EcosystemProtocol, FactorDelegate {
    
    var interactionMatrix = InteractionMatrix(size: 1)!
    var mortalityMatrix = Matrix(rowsY: 1, columnsX: 1)!
    
    var cycle = 0
    var factors = [Int: Factor]()
    var description: String
    var eulerIntervals = 100
    
    init(name: String) {
        description = name
    }
    
    func add(_ factor: Factor) {
        factors[factor.hashValue] = factor
    }
    
    func getCycle() -> Int {
        return cycle
    }
    
    func getEulerIntervals() -> Int {
        return eulerIntervals
    }
    
    func getInteractionMatrix() -> Matrix {
        return interactionMatrix
    }
    
    func getMortalityMatrix() -> Matrix {
        return mortalityMatrix
    }
    
    func getFactors() -> [Int: Factor] {
        return factors
    }
    
    /*@discardableResult func addResourceTimeBinding(resource: Factor, amplitude: Double, offset: Int) -> Bool {
        if factors.values.contains(resource) {
            let startLevel = resource.getLevel()
            sun.add(equation: {resource.setLevel(to: startgetLevel() + amplitude * sin(Double(resource.delegate.getCycle() - offset) * M_PI / 180)); return 0.0}, frequency: 1)
            return true
        }
        return false
    }
    
    @discardableResult func addOrganismDieoff(organism: BioFactor, mortalityRate: Double) -> Bool {
        if factors.values.contains(organism) {
            organism.add(equation: {(-1 * mortalityRate * organism.getLevel())}, frequency: 1)
            return true
        }
        return false
    }
    
    @discardableResult func addNaturalSpeciesGrowthRate(species: BioFactor, naturalGrowthRate: Double) -> Bool {
        if factors.values.contains(species) {
            species.add(equation: {naturalGrowthRate * species.getLevel()}, frequency: 1)
            return true
        }
        return false
    }
    
    @discardableResult func addPredatorPreyBinding(predator: BioFactor, prey: BioFactor, effectOnPrey: Double, predEfficiency: Double) -> Bool {
        if factors.values.contains(predator) && factors.values.contains(prey) {
            prey.add(equation: {-1 * effectOnPrey * prey.getLevel() * predator.getLevel()}, frequency: 1)
            predator.add(equation: {predEfficiency * prey.getLevel() * predator.getLevel()}, frequency: 1)
        }
        return false
    }
    */
 
    func nextCycle() {
        cycle += 1
        for _ in 0..<eulerIntervals {
            /*for factor in factors.values {
                factor.nextCycle()
            }*/
            for factor in factors.values {
                
                factor.update()
            }
        }
    }
    
    func printFactors() {
        for factor in factors.values {
            print(factor)
        }
    }
}



