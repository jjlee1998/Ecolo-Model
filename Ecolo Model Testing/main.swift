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
var phytoplankton = BioFactor(name: "Phytoplankton", level: 1.125, delegate: antarctic, reproductionFrequency: 1)
var krill = BioFactor(name: "Krill", level: 1.5, delegate: antarctic, reproductionFrequency: 1)
var penguin = BioFactor(name: "Penguin", level: 0.125, delegate: antarctic, reproductionFrequency: 1)
var orca = BioFactor(name: "Orca", level: 4, delegate: antarctic, reproductionFrequency: 1)




/*antarctic.add(sun)
antarctic.add(rain)*/
antarctic.add(phytoplankton)
antarctic.add(krill)
antarctic.add(penguin)
antarctic.add(orca)

antarctic.addNaturalSpeciesGrowthRate(species: phytoplankton, naturalGrowthRate: 3)
antarctic.addOrganismDieoff(organism: krill, mortalityRate: 1)
antarctic.addPredatorPreyBinding(predator: krill, prey: phytoplankton, effectOnPrey: 2, predEfficiency: 1)
antarctic.addOrganismDieoff(organism: penguin, mortalityRate: 2)
antarctic.addPredatorPreyBinding(predator: penguin, prey: krill, effectOnPrey: 1, predEfficiency: 4)
antarctic.addOrganismDieoff(organism: orca, mortalityRate: 0.5)
antarctic.addPredatorPreyBinding(predator: orca, prey: penguin, effectOnPrey: 1, predEfficiency: 4)

for i in 1...100 {
    antarctic.nextCycle()
    print("\(i) – phytoplankton: \((phytoplankton.level)), krill: \(krill.level), penguin: \(penguin.level), orca: \(orca.level)")
}
