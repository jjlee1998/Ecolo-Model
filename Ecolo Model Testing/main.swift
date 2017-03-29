//
//  main.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/27/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation


var antarctic = Ecosystem(name: "Antarctic Ecosystem")
print(antarctic, terminator: "\n\n")


/*var sun = Factor(name: "Sun", level: 5000, delegate: antarctic)
var rain = Factor(name: "Rain", level: 4000, delegate: antarctic)*/
var phytoplankton = BioFactor(name: "Phytoplankton", level: 2, delegate: antarctic, reproductionFrequency: 1) //2
var fish = BioFactor(name: "Fish", level: 1.5, delegate: antarctic, reproductionFrequency: 1) //1.5
var penguin = BioFactor(name: "Penguin", level: 1, delegate: antarctic, reproductionFrequency: 1) //1
var orca = BioFactor(name: "Orca", level: 1, delegate: antarctic, reproductionFrequency: 1) //1

//how can we design puzzles?
//Too many fish are present - player needs to somehow adjust ecosystem to have lower levels of fish
//Is the goal to bring the ecosystem to equilibrium?

/*antarctic.add(sun)
 antarctic.add(rain)*/
antarctic.add(phytoplankton)
antarctic.add(fish)
antarctic.add(penguin)
antarctic.add(orca)

antarctic.addNaturalSpeciesGrowthRate(species: phytoplankton, naturalGrowthRate: 3)
antarctic.addOrganismDieoff(organism: fish, mortalityRate: 1)
antarctic.addPredatorPreyBinding(predator: fish, prey: phytoplankton, effectOnPrey: 2, predEfficiency: 1)
antarctic.addOrganismDieoff(organism: penguin, mortalityRate: 2)
antarctic.addPredatorPreyBinding(predator: penguin, prey: fish, effectOnPrey: 1, predEfficiency: 2)
antarctic.addOrganismDieoff(organism: orca, mortalityRate: 0.5)
antarctic.addPredatorPreyBinding(predator: orca, prey: penguin, effectOnPrey: 1, predEfficiency: 0.5)

func takeOption(input: String) {
    var inputArray = input.characters.split{$0 == " "}.map(String.init)
    switch inputArray[0] {
    case "cycle":
        let cycleNumber = Int(inputArray[1])!
        for i in 1...cycleNumber {
            antarctic.nextCycle()
            print("\(i) – phytoplankton: \((phytoplankton.level)), fish: \(fish.level), penguin: \(penguin.level), orca: \(orca.level)")
        }
    case "setLevel":
        let newLevel = Double(inputArray[2])!
        print(type(of: inputArray[1]))
        if antarctic.factors[inputArray[1]] != nil {
            antarctic.factors[inputArray[1]]!.level = newLevel
        }
        else {
            print("error: factor is not contained in this ecosystem")
        }
    case "printFactors":
        for (_, factor) in antarctic.factors {
            print("\(factor): \(factor.level)")
        }
    default: print("invalid input")
    }
}

//Something like a driver?
var interactionMatrix = Matrix<Double>(rows: 4, columns: 4, fillValue: 0)!
interactionMatrix.setElement(row: 2, column: 0, newElement: -1.0)
interactionMatrix.setElement(row: 3, column: 1, newElement: 0.5)
interactionMatrix.setElement(row: 1, column: 1, newElement: -1.0)
interactionMatrix.setElement(row: 2, column: 2, newElement: 2.0)
interactionMatrix.setElement(row: 0, column: 2, newElement: -2.0)
interactionMatrix.setElement(row: 1, column: 3, newElement: 1.0)
print(interactionMatrix)

var densityMatrix = Matrix<Double>(rows: 4, columns: 1, fillValue: 0)!
densityMatrix.setElement(row: 0, column: 0, newElement: 2.0)
densityMatrix.setElement(row: 1, column: 0, newElement: 1.5)
densityMatrix.setElement(row: 2, column: 0, newElement: 1.0)
densityMatrix.setElement(row: 3, column: 0, newElement: 1.0)
print(densityMatrix)

var constantMatrix = interactionMatrix * densityMatrix
print(constantMatrix!)


print("Welcome to \(antarctic)!")
print("Current state:\nPhytoplankton: \((phytoplankton.level)), Fish: \(fish.level), Penguin: \(penguin.level), Orca: \(orca.level)")
print("Controls:")
print("cycle n: ecosystem cycles n times")
print("setLevel m n: set level of organism m to n")
print("printFactors: print all factors in \(antarctic)")
while antarctic.cycle != 100 {
    var input = readLine()
    takeOption(input: input!)
}
print("Thanks for playing")


/*
 for i in 1...100 {
    antarctic.nextCycle()
    print("\(i) – phytoplankton: \((phytoplankton.level)), fish: \(fish.level), penguin: \(penguin.level), orca: \(orca.level)")
}

*/
