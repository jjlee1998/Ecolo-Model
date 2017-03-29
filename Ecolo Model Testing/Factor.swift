//
//  SavannaAbioticElement.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

enum FactorType {
    case Producer
    case Consumer
}

class Factor: CustomStringConvertible, Hashable {
    
    private static var nextHashValue = 0
    let hashValue: Int
    let name: String
    private(set) var level: Double
    private var delegate: FactorDelegate
    let type: FactorType
    private var delta = 0.0
    var description: String {
        return "\(name)"
    }
    
    init(name: String, level: Double, delegate: FactorDelegate, type: FactorType) {
        self.name = name
        hashValue = Factor.nextHashValue
        Factor.nextHashValue += 1
        self.level = level
        self.delegate = delegate
        self.type = type
    }
    
    static func ==(f1: Factor, f2: Factor) -> Bool {
        return f1.hashValue == f2.hashValue
    }
    
    func setLevel(to newLevel: Double) {
        level = newLevel
    }
    
    func lotkaVolterra() {
        switch type {
            case .Producer: lvProducer()
            case .Consumer: lvConsumer()
        }
    }
    
    private func lvProducer() {
        
    }
    
    private func lvConsumer() {
        
    }
    
    /*func nextCycle() {
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
    }*/
}
