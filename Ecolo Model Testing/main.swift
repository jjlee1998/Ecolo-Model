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


/*var sun = Factor(name: "Sun", level: 5000, delegate: savanna)
var rain = Factor(name: "Rain", level: 4000, delegate: savanna)*/
var grass = BioFactor(name: "Grass", level: 1.25, delegate: savanna, reproductionFrequency: 1, memberWeight: 0.00001) //2, 1, 1
var hare = BioFactor(name: "Hare", level: 0.5, delegate: savanna, reproductionFrequency: 1, memberWeight: 2.5)
var eagle = BioFactor(name: "Eagle", level: 0.25, delegate: savanna, reproductionFrequency: 1, memberWeight: 2.0)

/*savanna.add(sun)
savanna.add(rain)*/
savanna.add(grass)
savanna.add(hare)
savanna.add(eagle)

savanna.addNaturalSpeciesGrowthRate(species: grass, naturalGrowthRate: 3)
savanna.addPredatorPreyBinding(predator: hare, prey: grass, effectOnPrey: 6, predEfficiency: 1)
savanna.addOrganismDieoff(organism: hare, mortalityRate: 1)
savanna.addPredatorPreyBinding(predator: eagle, prey: hare, effectOnPrey: 1, predEfficiency: 4)
savanna.addOrganismDieoff(organism: eagle, mortalityRate: 2)

for i in 1...100 {
    savanna.nextCycle()
    print("\(i) – Grass: \((grass.level)), Hare: \(hare.level), Eagle: \(eagle.level)")
}
