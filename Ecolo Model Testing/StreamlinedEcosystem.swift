//
//  StreamlinedEcosystem.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 4/26/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

class StreamlinedEcosystem: CustomStringConvertible, FactorDelegate {
    
    let name: String
    let factorData: [String: [String: [String: Double]]]
    
    let eulerIntervals = 100
    // Because the differential equations governing population are not integrable, population changes must be approximated using Euler's method.
    // These are the number of intervals (i.e., the number of times the calculation repeats) per cycle.
    // The higher the number, the more accurate the changes, but the slower the program.
    
    var interactions = [Factor: [Factor: Double]]()
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
    
    func printFactorData() {
        print(factorData)
    }
    
    func add(_ newFactorName: String, ofType type: FactorType, withLevel level: Double) -> Bool {
        guard let newFactorData = factorData[type.rawValue]?[newFactorName] else {
            print("Failed to add \(newFactorName) because I couldn't find it in the factorData")
            return false
        }
        let newFactor = Factor(name: newFactorName, level: level, delegate: <#T##FactorDelegate#>, type: <#T##FactorType#>)
    }
    
    var description: String {
        return interactions.reduce("", {" " + $0 + $1.key.name})
    }
}
