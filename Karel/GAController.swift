//
//  GAController.swift
//  Karel
//
//  Created by Gokul Rajan on 15.10.17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import UIKit


protocol GADelegate {
    
    func getCurrentBlockData() -> BlockData?
    
    func getDestinationBlockData() -> BlockData?
}

class GAController: NSObject {

    fileprivate static let POPULATION_COUNT = 10
    
    fileprivate static let GENE_COUNT = 8
    
    fileprivate static let ALPHA = GENE_COUNT/2
    
    fileprivate static let CALC_FREQ = GENE_COUNT/ALPHA
    
    fileprivate var karelReachedDestination = false
    
    fileprivate var originalDistance: Int?
    
    fileprivate var karelController: Karel?
    
    fileprivate var genomes: [Genome]?
    
    init(karel: Karel?) {
        
        karelController = karel!
    }
    
    func startGeneticAlgorithm() {
        
        DispatchQueue.global().async {
            
            self.initializeGA()
            while !self.karelReachedDestination {
                
                self.executeGenomes()
                self.filterGenomesWithHighR2()
                self.sortAndRepopulateGenomes()
                self.createNextGeneration()
            }
        }
    }
    
    fileprivate func initializeGA() {
        
        findOriginalDistance()
        createInitialPopulation()
    }
    
    fileprivate func findOriginalDistance() {
        
        originalDistance = self.karelController?.getCurrentBlockData()?.distance(self.karelController?.getDestinationBlockData())
    }
    
    fileprivate func createInitialPopulation() {
        
        genomes = [Genome]()
        
        for _ in 0..<GAController.POPULATION_COUNT {
            
            genomes?.append(Genome.randomGenome(geneCount: GAController.GENE_COUNT))
        }
    }
    
    fileprivate func calculateR1andR2(index: Int, genome: Genome) {
        
        if (index % GAController.CALC_FREQ == 0) {
            
            let distance = self.karelController?.getCurrentBlockData()?.distance(self.karelController?.getDestinationBlockData())
            
            if distance != 0 {
                
                //Set r1 value (Minimum distance)
                if (genome.r1! == -1 || genome.r1! > distance!) {
                    genome.r1 = distance
                }
                
                //Set r2 value (Maximum distance)
                if genome.r2! == -1 || genome.r2! < distance! {
                    genome.r2 = distance
                }
                
                //Set r3 value (Maximum distance)
                genome.r3 = genome.r3! + distance!
            }
            else {
                print("Successfull genome: ",genome.genes!)
            }
        }
    }
    
    fileprivate func calculateR3(genome: Genome) {
        genome.r3 = genome.r3! / GAController.ALPHA
    }
    
    fileprivate func resetEnvironment() {
        DispatchQueue.main.async {
            // Reset Karel Environment
            self.karelController?.resetKarelEnvironment()
        }
    }
    
    fileprivate func executeGeneInEnvironment(gene: Gene) {
        usleep(250000)
        DispatchQueue.main.async {
            //Do actions
            switch gene {
            case Gene.Left  :   self.karelController?.turnLeft()
            case Gene.Move  :   self.karelController?.move()
            case Gene.Right :   self.karelController?.turnRight()
            }
        }
    }
    
    func executeGenomes() {
        
        for genome in self.genomes! {
            
            self.resetEnvironment()
            print("Executing genome: ",genome.genes!)
            for i in 0..<genome.geneCount! {
                
                self.executeGeneInEnvironment(gene: genome.genes![i])
                self.calculateR1andR2(index: i, genome: genome)
            }
            self.calculateR3(genome: genome)
        }
    }
    
    func filterGenomesWithHighR2() {
        
        var genomeCopy = [Genome]()
        for genome in genomes! {
            genomeCopy.append(genome.copy())
        }
        
        for i in 0..<genomeCopy.count {
            
            let genome = genomeCopy[i]
            if genome.r2! > originalDistance! + 1 {
                genomes?.remove(at: i)
            }
        }
    }
    
    // Sort based on r1+r3
    func sortAndRepopulateGenomes() {
        
        genomes?.sort(by: { ($0.r1!+$0.r3!) < ($1.r1!+$1.r3!)})
        while ((genomes?.count)! < GAController.POPULATION_COUNT) {
            genomes?.append(genomes!.first!.copy())
        }
    }
    
    func createNextGeneration() {
        
        assignGenomeProbabilityRange()
        
        var newPopulation = [Genome]()
        while newPopulation.count < genomes!.count {
        
            let parent1 = selectParentFromGenomes()
            let parent2 = selectParentFromGenomes()
            if parent1.isEqual(genome: parent2) {
                parent1.mutate()
            }
            newPopulation.append(parent1.crossover(genome: parent2))
            newPopulation.append(parent2.crossover(genome: parent1))
        }
        self.genomes = newPopulation
    }
    
    func selectParentFromGenomes() -> Genome {
        
        var randomValue = Float(arc4random()) / Float(UINT32_MAX)
        genomes?.sort(by: { $0.pRange! < $1.pRange!})
        for genome in genomes! {
            randomValue -= genome.pRange!
            if randomValue <= 0 {
                return genome
            }
        }
        
        return (genomes?.last)!
    }
    
    func assignGenomeProbabilityRange() {

        var sumOfRanks: Int? = 0
        for genome in genomes! {
            sumOfRanks = sumOfRanks! + genome.r1! + genome.r3!
        }
        
        var sumOfR4: Float? = 0
        for genome in genomes! {
            genome.r4 = (Float)((genome.r1! + genome.r3!) / sumOfRanks!)
            sumOfR4 = sumOfR4! + genome.r4!
        }
        
        for genome in genomes! {
            genome.pRange = genome.r4! / sumOfR4!
        }
    }
}
