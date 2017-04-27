
//  main.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 2/27/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

let antarctic = StreamlinedEcosystem(name: "Antarctic Ecosystem")!
antarctic.add("Sunlight", ofType: .Resource, withLevel: 3)
antarctic.add("Phytoplankton", ofType: .Producer, withLevel: 2)
antarctic.add("Fish", ofType: .Consumer, withLevel: 2)
antarctic.add("Penguin", ofType: .Consumer, withLevel: 1)
antarctic.add("Orca", ofType: .Consumer, withLevel: 1)
antarctic.add("Leopard Seal", ofType: .Consumer, withLevel: 1)
antarctic.add("Baleen Whale", ofType: .Consumer, withLevel: 0.5)

var exit = false
var cycles = 0

func takeOption(input: String) {
    var inputArray = input.characters.split{$0 == " "}.map(String.init)
    switch inputArray[0] {
    case "cycle":
        let cycleNumber = Int(inputArray[1])!
        for _ in 1...cycleNumber {
            cycles += 1
            antarctic.nextCycle()
            print("\(cycles) | \(antarctic.currentState)")
        }
    case "printFactors":
        print(antarctic.currentState)
    case "diagnostics":
        print(antarctic.diagnostics)
    case "exit":
        exit = true
    default: print("invalid input")
    }
}

print("Welcome to \(antarctic)!")
print("Current state:\(antarctic.currentState)")
print("Controls:")
print("cycle n: ecosystem cycles n times")
print("printFactors: print all factors in \(antarctic) and their levels")
print("diagnostics: print the ecosystem members, their levels, and their interactions")
print("exit: end program")
while !exit {
    var input = readLine()
    takeOption(input: input!)
}
print("Thanks for playing")
