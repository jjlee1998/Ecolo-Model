
//  main.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/27/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

var antarctic = Ecosystem(name: "Antarctic Ecosystem")
print(antarctic, terminator: "\n\n")

var sunlight = Factor(name: "Sunlight", level: 3, delegate: antarctic, type: .Resource)
var phytoplankton = Factor(name: "Phytoplankton", level: 2, delegate: antarctic, type: .Producer)
var fish = Factor(name: "Fish", level: 1.5, delegate: antarctic, type: .Consumer)
var penguin = Factor(name: "Penguin", level: 1, delegate: antarctic, type: .Consumer)
var orca = Factor(name: "Orca", level: 1, delegate: antarctic, type: .Consumer)

antarctic.add(sunlight)
antarctic.add(phytoplankton)
antarctic.add(fish)
antarctic.add(penguin)
antarctic.add(orca)

antarctic.addPairing(factor1: orca, factor2: penguin, effect1: 0.5, effect2: -1.0)
antarctic.addPairing(factor1: penguin, factor2: fish, effect1: 2.0, effect2: -1.0)
antarctic.addPairing(factor1: fish, factor2: phytoplankton, effect1: 1.0, effect2: -2.0)
antarctic.addPairing(factor1: phytoplankton, factor2: sunlight, effect1: 0.01, effect2: 0.0)
print(antarctic.interactionMatrix)

antarctic.addNaturalChangeConstant(factor: orca, constant: -0.5)
antarctic.addNaturalChangeConstant(factor: penguin, constant: -2.0)
antarctic.addNaturalChangeConstant(factor: fish, constant: -1.0)
antarctic.addNaturalChangeConstant(factor: phytoplankton, constant: 3.0)
print(antarctic.mortalityMatrix)

var exit = false

func takeOption(input: String) {
    var inputArray = input.characters.split{$0 == " "}.map(String.init)
    switch inputArray[0] {
    case "cycle":
        let cycleNumber = Int(inputArray[1])!
        for i in 1...cycleNumber {
            antarctic.nextCycle()
            print("\(i) – phytoplankton: \((phytoplankton.level)), fish: \(fish.level), penguin: \(penguin.level), orca: \(orca.level)")
        }
    case "printFactors":
        for factor in antarctic.factors.values {
            print("\(factor): \(factor.level)")
        }
    case "exit":
        exit = true
    default: print("invalid input")
    }
}

print("Welcome to \(antarctic)!")
print("Current state:\nPhytoplankton: \((phytoplankton.level)), Fish: \(fish.level), Penguin: \(penguin.level), Orca: \(orca.level)")
print("Controls:")
print("cycle n: ecosystem cycles n times")
print("setLevel m n: set level of organism m to n")
print("printFactors: print all factors in \(antarctic)")
print("exit: end program")
while !exit {
    var input = readLine()
    takeOption(input: input!)
}
print("Thanks for playing")
