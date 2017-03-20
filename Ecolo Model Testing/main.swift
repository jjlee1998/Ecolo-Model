//
//  main.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/27/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation


var savanna = Ecosystem(name: "Savanna Ecosystem")
print(savanna, terminator: "\n\n")


var sun = Factor(name: "Sun", level: 5000, delegate: savanna)
var rain = Factor(name: "Rain", level: 4000, delegate: savanna)
var grass = BioFactor(name: "Grass", level: 500, delegate: savanna, reproductionFrequency: 1, memberWeight: 0.00001)
var hare = BioFactor(name: "Hare", level: 100, delegate: savanna, reproductionFrequency: 1, memberWeight: 2.5)
var eagle = BioFactor(name: "Eagle", level: 10, delegate: savanna, reproductionFrequency: 12, memberWeight: 2.0)

savanna.add(sun)
savanna.add(rain)
savanna.add(grass)
savanna.add(hare)
savanna.add(eagle)

savanna.addResourceTimeBinding(resource: sun, amplitude: 1000, offset: 90)
savanna.addResourceTimeBinding(resource: rain, amplitude: 2000, offset: 90)
savanna.addOrganismDieoff(organism: grass, mortalityRate: 0.01)
savanna.addOrganismDieoff(organism: hare, mortalityRate: 0.01)
savanna.addOrganismDieoff(organism: eagle, mortalityRate: 0.01)
savanna.addPreyResourceBinding(prey: grass, resource: rain, intrisicGrowthRate: 1.1)
savanna.addPreyResourceBinding(prey: grass, resource: sun, intrisicGrowthRate: 1.1)
savanna.addPredatorPreyBinding(predator: hare, prey: grass, attackRate: 0.01, conversionEfficiency: 0.01)
savanna.addPredatorPreyBinding(predator: eagle, prey: hare, attackRate: 0.01, conversionEfficiency: 0.01)

for i in 1...200 {
    savanna.nextCycle()
    print("\(i) – Sun: \(sun.level), Rain: \(rain.level), Grass: \((grass.level)), Hare: \(hare.level), Eagle: \(eagle.level)")
}
