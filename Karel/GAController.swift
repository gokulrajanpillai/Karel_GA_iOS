//
//  GAController.swift
//  Karel
//
//  Created by Gokul Rajan on 15.10.17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import UIKit


class GAController: NSObject {

    static let INITIAL_POPULATION_COUNT = 10
    
    static let GENE_COUNT = 8
    
    static let ALPHA = GENE_COUNT/2
    
    var karelController: Karel?
    
    var genomes: [Genome]?
    
    init(karel: Karel?) {
        
        karelController = karel!
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
                for gene in genome.genes! {
                    usleep(500000)
                    DispatchQueue.main.async {
                        //Do actions
                        switch gene {
                        case Gene.Left  :   self.karelController?.turnLeft()
                        case Gene.Move  :   self.karelController?.move()
                        case Gene.Right :   self.karelController?.turnRight()
                        }
                    }
                }
            }
        }
        
    }
}
