//
//  BioFactor.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 3/13/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

class BioFactor: Factor {
    
    let reproductionFrequency: Int
    let memberWeight: Double
    
    init(name: String, level: Double, delegate: FactorDelegate, reproductionFrequency: Int, memberWeight: Double) {
        self.reproductionFrequency = reproductionFrequency
        self.memberWeight = memberWeight
        super.init(name: name, level: level, delegate: delegate)
    }
}
