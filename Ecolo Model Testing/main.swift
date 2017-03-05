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

var sun = Factor(factorName: "Sun", initialLevel: 500, initialHealth: 1000, delegate: savanna, canReproduce: false)
var rain = Factor(factorName: "Rain", initialLevel: 500, initialHealth: 1000, delegate: savanna, canReproduce: false)
var grass = Factor(factorName: "Grass", initialLevel: 1000, initialHealth: 1000, delegate: savanna, canReproduce: true)
var hare = Factor(factorName: "Hare", initialLevel: 100, initialHealth: 1000, delegate: savanna, canReproduce: true)
var eagle = Factor(factorName: "Eagle", initialLevel: 10, initialHealth: 1000, delegate: savanna, canReproduce: true)

savanna.add(sun)
savanna.add(rain)
savanna.add(grass)
savanna.add(hare)
savanna.add(eagle)

func rainSunBinding(rain: Factor, sun: Factor) {
    rain.requestNextLevel(1000 - sun.level)
    //print("Rain - Sun Binding Called")
}
savanna.addFactorTargetBinding(consumingFactor: rain, consumedFactor: sun, relationship: rainSunBinding)

func organismResourceBinding(organism: Factor, resource: Factor) {
    organism.requestNextHealth((-0.004 * pow(resource.level, 2.0)) + (4 * resource.level))
    //print("\(organism.name) - \(resource.name) Binding Called")
}
savanna.addFactorTargetBinding(consumingFactor: grass, consumedFactor: sun, relationship: organismResourceBinding)
savanna.addFactorTargetBinding(consumingFactor: grass, consumedFactor: rain, relationship: organismResourceBinding)

func predatorPreyBinding(predator: Factor, prey: Factor) {
    var targetPredatorHealth = predator.health
    let targetPreyLevel = (prey.level - predator.level)
    if prey.level >= predator.level {
        targetPredatorHealth += (prey.level / 1000) * (1000 - predator.health)
        predator.requestNextHealth(targetPredatorHealth)
        prey.requestNextLevel(targetPreyLevel)
    } else {
        predator.requestNextHealth(predator.health * (prey.level / predator.level))
        prey.requestNextLevel(targetPreyLevel)
    }
    //print("\(predator.name) - \(prey.name) Binding Called")
}
savanna.addFactorTargetBinding(consumingFactor: hare, consumedFactor: grass, relationship: predatorPreyBinding)
savanna.addFactorTargetBinding(consumingFactor: eagle, consumedFactor: hare, relationship: predatorPreyBinding)

for _ in 1...100 {
    savanna.nextCycle()
    print("Sun l: \((sun.level)) | Rain l: \((rain.level)) | Grass l: \((grass.level)) h: \((grass.health)) | Hare l: \((hare.level)) h: \((hare.health)) | Eagle l: \((eagle.level)) h: \((eagle.health))")
}
