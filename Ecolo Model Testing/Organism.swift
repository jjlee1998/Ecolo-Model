//
//  SavannaOrganism.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

class Organism: Factor {
    
    var health: Int
    
    init(factorName: String, initialLevel: Int, initialHealth: Int) {
        self.health = initialHealth
        super.init(factorName: factorName, initialLevel: initialLevel)
    }
}
