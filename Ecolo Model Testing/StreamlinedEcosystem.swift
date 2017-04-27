//
//  StreamlinedEcosystem.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 4/26/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

protocol FactorDelegate {
    func getEulerIntervals() -> Int
    func getExtinctionThreshold() -> Double
    func getFactorsWithInteractions() -> [Factor: [Factor: Double]]
}

class StreamlinedEcosystem: CustomStringConvertible, FactorDelegate {
    
    let name: String
    let factorData: [String: [String: [String: String]]]
    let eulerIntervals = 100
    // Because the differential equations governing population are not integrable, population changes must be approximated using Euler's method.
    // These are the number of intervals (i.e., the number of times the calculation repeats) per cycle.
    // The higher the number, the more accurate the changes, but the slower the program.
    let extinctionThreshold = 10e-3
    // When the normalized population size drops below 10e-3, the population crashes and goes extinct due to lack of genetic diversity.
    var factors = [Factor: [Factor: Double]]()
    // The first factor is the one being affected. The second factor is the one affecting it.
    // The double is the interaction coefficient.
    // If a factor is affecting itself, then that represents natural growth or death rates.
    
    init?(name: String) {
        guard let path = Bundle.main.path(forResource: "FactorData", ofType: "plist"),
            let data = NSDictionary(contentsOfFile: path) as? [String: [String: [String: String]]] else {
            print("Failed to read in data at path FactorData.plist")
            return nil
        }
        self.name = name
        self.factorData = data
    }
    
    @discardableResult func add(_ newFactorName: String, ofType type: FactorType, withLevel level: Double) -> Bool {
        // First, retrieve the [String: String] dictionary of the new factor's interactions with all possible organisms.
        guard let newFactorInteractions = factorData[type.rawValue]?[newFactorName] else {
            print("Failed to add \(newFactorName); couldn't find it in FactorData.plist")
            return false
        }
        // Second, add the new factor to the main storage array with an empty array of associated factors and interaction coefficients.
        let newFactor = Factor(newFactorName, type: type, level: level, delegate: self)
        factors[newFactor] = [Factor: Double]()
        // Finally, iterate through the manin storage array and look to see which factors will be interacting with this new one.
        // If the two factors interact (i.e., an interaction coefficient exists) then add the appropriate [Factor: Double] bindings into the two dictionaries.
        for (existingFactor, _) in factors {
            if let stringCoeffForNew = newFactorInteractions[existingFactor.name], let coeffForNewFactor = Double(stringCoeffForNew) {
                factors[newFactor]![existingFactor] = coeffForNewFactor
            }
            if let stringCoeffForExisting = factorData[existingFactor.type.rawValue]?[existingFactor.name]?[newFactor.name],
                let coeffForExistingFactor = Double(stringCoeffForExisting) {
                factors[existingFactor]![newFactor] = coeffForExistingFactor
            }
        }
        return true
    }
    
    func nextCycle() {
        for _ in 0 ..< eulerIntervals {
            for (factor, _) in factors {
                factor.calculateDelta()
            }
            for (factor, _) in factors {
                factor.addDeltaToLevel()
            }
        }
    }
    
    func getFactorsWithInteractions() -> [Factor : [Factor : Double]] {
        return factors
    }
    
    func getExtinctionThreshold() -> Double {
        return extinctionThreshold
    }
    
    func getEulerIntervals() -> Int {
        return eulerIntervals
    }
    
    var description: String {
        return self.name
    }
    
    var currentState: String {
        return factors.reduce("", {$0 + "\t \($1.0.name): \($1.0.level)"})
    }
    
    var diagnostics: String {
        var result = ""
        for (factor, interactions) in factors {
            result += "\(factor.name) – lvl \(factor.level):"
            for (affectingFactor, coefficient) in interactions {
                result += "\n\t\(coefficient) from \(affectingFactor.name)"
            }
            result += "\n"
        }
        return result
    }
}
