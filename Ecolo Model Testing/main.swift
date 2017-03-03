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

var sun = Factor(factorName: "Sun", initialLevel: 500, initialHealth: 1000, delegate: savanna)
var rain = Factor(factorName: "Rain", initialLevel: 500, initialHealth: 1000, delegate: savanna)
var grass = Factor(factorName: "Grass", initialLevel: 1000, initialHealth: 1000, delegate: savanna)
var hare = Factor(factorName: "Hare", initialLevel: 100, initialHealth: 1000, delegate: savanna)
var eagle = Factor(factorName: "Eagle", initialLevel: 10, initialHealth: 1000, delegate: savanna)

savanna.add(sun)
savanna.add(rain)
savanna.add(grass)
savanna.add(hare)
savanna.add(eagle)

func rainSunBinding(rain: Factor, sun: Factor) {
    rain.levelNextCycle = 1000 - sun.level
}
savanna.addFactorTargetBinding(consumingFactor: rain, consumedFactor: sun, relationship: rainSunBinding)

func organismResourceBinding(organism: Factor, resource: Factor) {
    let targetOrganismHealth = (-0.004 * pow(resource.level, 2.0)) + (4 * resource.level)
    organism.healthNextCycle = organism.health + ((targetOrganismHealth - organism.health) / 2)
}
savanna.addFactorTargetBinding(consumingFactor: grass, consumedFactor: sun, relationship: organismResourceBinding)
savanna.addFactorTargetBinding(consumingFactor: grass, consumedFactor: rain, relationship: organismResourceBinding)

func predatorPreyBinding(predator: Factor, prey: Factor) {
    var targetPredatorHealth = predator.health
    let targetPreyLevel = (prey.level - predator.level)
    if prey.level >= predator.level {
        targetPredatorHealth += (prey.level / 1000) * (1000 - predator.health)
        prey.levelNextCycle = targetPreyLevel
        predator.healthNextCycle += targetPredatorHealth / 2
    } else {
        predator.healthNextCycle *= (prey.level / predator.level)
        prey.levelNextCycle -= targetPreyLevel / 2
    }
}
savanna.addFactorTargetBinding(consumingFactor: hare, consumedFactor: grass, relationship: predatorPreyBinding)
savanna.addFactorTargetBinding(consumingFactor: eagle, consumedFactor: hare, relationship: predatorPreyBinding)

savanna.printFactors(withTargets: true)

for _ in 1...100 {
    savanna.nextCycle()
}
