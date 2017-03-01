//
//  main.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/27/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

var sv = Savanna()
print(sv, terminator: "\n\n")

sv.add(Factor(factorName: "Sun", initialLevel: 500))
sv.add(Factor(factorName: "Rain", initialLevel: 500))
sv.add(Organism(factorName: "Grass", initialLevel: 1000, initialHealth: 1000))
sv.add(Organism(factorName: "Hare", initialLevel: 100, initialHealth: 1000))
sv.add(Organism(factorName: "Eagle", initialLevel: 10, initialHealth: 1000))

sv.printFactors()
print()

func sunRainEquation(sun: Factor, rain: Factor) {
    rain.level = 1000 - sun.level
}
func sunGrassEquation(sun: Factor, grass: Factor) {
    let grassOrganism = grass as! Organism
    let originalGrassHealth = grassOrganism.health
    let desiredGrassHealth = sun.level * sun.level / 250 + 4 * sun.level
    grassOrganism.health = originalGrassHealth + (desiredGrassHealth - originalGrassHealth) / 10
}
func rainGrassEquation(rain: Factor, grass: Factor) {
    let grassOrganism = grass as! Organism
    let originalGrassHealth = grassOrganism.health
    let desiredGrassHealth = rain.level * rain.level / 250 + 4 * rain.level
    grassOrganism.health = originalGrassHealth + (desiredGrassHealth - originalGrassHealth) / 10
}
func grassHareEquation(grass: Factor, hare: Factor) {
    let grassOrganism = grass as! Organism
    let hareOrganism = hare as! Organism
}

if sv.add(Relationship(factorX: sv.factors["Sun"]!, factorY: sv.factors["Rain"]!, equation: sunRainEquation)) &&
    sv.add(Relationship(factorX: sv.factors["Sun"]!, factorY: sv.factors["Grass"]!, equation: sunGrassEquation)) {
    print("Successfully created all relationships.")
} else {
    print("Failed to create relationships.")
}

sv.printRelationships()
