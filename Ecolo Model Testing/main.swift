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

var sun = Factor(factorName: "Sun", initialLevel: 500, initialHealth: 1000)
var rain = Factor(factorName: "Rain", initialLevel: 500, initialHealth: 1000)
var grass = Factor(factorName: "Grass", initialLevel: 1000, initialHealth: 1000)
var hare = Factor(factorName: "Hare", initialLevel: 100, initialHealth: 1000)
var eagle = Factor(factorName: "Eagle", initialLevel: 10, initialHealth: 1000)

savanna.add(sun)
savanna.add(rain)
savanna.add(grass)
savanna.add(hare)
savanna.add(eagle)

savanna.printFactors()
print()

func rainSunBinding(rain: Factor, sun: Factor) {
    rain.level = 1000 - sun.level
}
savanna.addFactorTargetBinding(consumingFactor: rain, consumedFactor: sun, relationship: rainSunBinding)

func grassSunBinding(grass: Factor, sun: Factor) {
    grass.health = sun.level / 250
}
