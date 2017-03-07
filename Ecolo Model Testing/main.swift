//
//  main.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/27/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

var sun = Factor(factorName: "Sun", initialLevel: 5000)

var savanna = Ecosystem(name: "Savanna Ecosystem", sun: sun)
print(savanna, terminator: "\n\n")

var rain = Factor(factorName: "Rain", initialLevel: 4000)
var grass = Factor(factorName: "Grass", initialLevel: 1000)
var hare = Factor(factorName: "Hare", initialLevel: 100)
var eagle = Factor(factorName: "Eagle", initialLevel: 10)

savanna.add(sun)
savanna.add(rain)
savanna.add(grass)
savanna.add(hare)
savanna.add(eagle)

savanna.addPredatorDieoff(predator: hare, mortalityRate: 0.05)
savanna.addPredatorDieoff(predator: eagle, mortalityRate: 0.01)
savanna.addResourceResourceBinding(dependentResource: rain, independentResource: sun)
savanna.addPreyResourceBinding(prey: grass, resource: rain, intrisicGrowthRate: 1.1)
savanna.addPreyResourceBinding(prey: grass, resource: sun, intrisicGrowthRate: 1.1)
savanna.addPredatorPreyBinding(predator: hare, prey: grass, attackRate: 0.01, conversionEfficiency: 0.0001)
savanna.addPredatorPreyBinding(predator: eagle, prey: hare, attackRate: 0.01, conversionEfficiency: 0.0001)

for i in 1...500 {
    savanna.nextCycle()
    print("\(i) – Sun: \(sun.level), Rain: \(rain.level), Grass: \((grass.level)), Hare: \(hare.level), Eagle: \(eagle.level)")
}
