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

    static let INITIAL_POPULATION_COUNT = 10
    
    static let GENE_COUNT = 8
    
    static let ALPHA = GENE_COUNT/2
    
    static let CALC_FREQ = GENE_COUNT/ALPHA
    
    var originalDistance: Int?
    
    var karelController: Karel?
    
    var genomes: [Genome]?
    
    init(karel: Karel?) {
        
        karelController = karel!
    }
    
    func startGeneticAlgorithm() {
        
        findOriginalDistance()
        
        createInitialPopulation()
        executeGenomes()
        filterGenomesWithHighR2()
        sortAndRepopulateGenomes()
    }
    
    func findOriginalDistance() {
        
        originalDistance = self.karelController?.getCurrentBlockData()?.distance(self.karelController?.getDestinationBlockData())
    }
    
    func createInitialPopulation() {
        
        genomes = [Genome]()
        
        for _ in 0..<GAController.INITIAL_POPULATION_COUNT {
            
            genomes?.append(Genome.randomGenome(geneCount: GAController.GENE_COUNT))
        }
    }
    
    func executeGenomes() {
        
        DispatchQueue.global().async {
            
            for genome in self.genomes! {
                
                DispatchQueue.main.async {
                    // Reset Karel Environment
                    self.karelController?.resetKarelEnvironment()
                }
                print("Genome: ",genome.genes!)
                
                for i in 0..<genome.geneCount! {
                    
                    let gene = genome.genes![i]
                    
                    usleep(500000)
                    DispatchQueue.main.async {
                        //Do actions
                        switch gene {
                        case Gene.Left  :   self.karelController?.turnLeft()
                        case Gene.Move  :   self.karelController?.move()
                        case Gene.Right :   self.karelController?.turnRight()
                        }
                    }
                    
                    if (i % GAController.CALC_FREQ == 0) {
                        
                        let distance = self.karelController?.getCurrentBlockData()?.distance(self.karelController?.getDestinationBlockData())
                        
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
                }
                
                genome.r3 = genome.r3! / GAController.ALPHA
            }
        }
    }
    
    func filterGenomesWithHighR2() {
        
        var genomeCopy = [Genome]()
        for genome in genomes! {
            genomeCopy.append(Genome.copy(genome: genome))
        }
        
        for i in 0..<genomeCopy.count {
            
            let genome = genomeCopy[i]
            if genome.r2! > originalDistance! + 1 {
                genomes?.remove(at: i)
            }
        }
    }
    
    func sortAndRepopulateGenomes() {
        
        genomes?.sort(by: { $0.r4() < $1.r4()})
    }
}
