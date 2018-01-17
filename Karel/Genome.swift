
//
//  Genome.swift
//  Karel
//
//  Created by Gokul Rajan on 15.10.17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import UIKit

class Genome {
    
    var geneCount: Int?
    
    var genes: [Gene]?
    
    var r1: Int?
    
    var r2: Int?
    
    var r3: Int?
    
    var r4: Float?
    
    //Probability range of the Genome
    var pRange: Float?
    
    static func randomGenome(geneCount: Int) -> Genome {
        
        let genome: Genome = Genome(geneCount: geneCount)
        for _ in 0..<geneCount {
            genome.genes?.append(Gene.random())
        }
        
        return genome
    }
    
    init(geneCount: Int) {
        
        self.geneCount = geneCount
        self.genes = [Gene]()
        r1 = -1
        r2 = -1
        r3 = 0
    }
    
    
    func isEqual(genome: Genome) -> Bool {
        
        for i in 0..<self.geneCount! {
            
            if self.genes![i] != genome.genes![i] {
                return false
            }
        }
        
        return true
    }
    
    
    func copy() -> Genome {
        
        let genome: Genome = Genome(geneCount: self.geneCount!)
        
        genome.geneCount    = self.geneCount
        genome.r1           = self.r1
        genome.r2           = self.r2
        genome.r3           = self.r3
        genome.r4           = self.r4
        genome.pRange       = self.pRange

        for gene in self.genes! {
            
            genome.genes?.append(gene)
        }
        
        return genome
    }
    
    func optimize() {
        
        for i in 0..<self.geneCount! {
            
            if (i > 0) {
                if ((genes![i] == Gene.Left && genes![i-1] == Gene.Right) || (genes![i] == Gene.Right && genes![i-1] == Gene.Left)) {
                    genes?.remove(at: i)
                    genes?.remove(at: i-1)
                    genes?.insert(Gene.Move, at: i-1)
                    genes?.insert(Gene.Move, at: i-1)
                }
            }
            if (i > 1) {
                if (genes![i] == Gene.Left && genes![i-1] == Gene.Left && genes![i-2] == Gene.Left) {
                    genes?.remove(at: i)
                    genes?.remove(at: i-1)
                    genes?.remove(at: i-2)
                    genes?.insert(Gene.Move, at: i-2)
                    genes?.insert(Gene.Move, at: i-2)
                    genes?.insert(Gene.Right, at: i-2)
                }
                if (genes![i] == Gene.Right && genes![i-1] == Gene.Right && genes![i-2] == Gene.Right) {
                    genes?.remove(at: i)
                    genes?.remove(at: i-1)
                    genes?.remove(at: i-2)
                    genes?.insert(Gene.Move, at: i-2)
                    genes?.insert(Gene.Move, at: i-2)
                    genes?.insert(Gene.Left, at: i-2)
                }
            }
            if (i > 2) {
                if (genes![i] == Gene.Left && genes![i-1] == Gene.Left && genes![i-2] == Gene.Left && genes![i-3] == Gene.Left) {
                    genes?.remove(at: i)
                    genes?.remove(at: i-1)
                    genes?.remove(at: i-2)
                    genes?.remove(at: i-3)
                    genes?.insert(Gene.Move, at: i-3)
                    genes?.insert(Gene.Move, at: i-3)
                    genes?.insert(Gene.Move, at: i-3)
                    genes?.insert(Gene.Move, at: i-3)
                }
                if (genes![i] == Gene.Right && genes![i-1] == Gene.Right && genes![i-2] == Gene.Right && genes![i-3] == Gene.Right) {
                    genes?.remove(at: i)
                    genes?.remove(at: i-1)
                    genes?.remove(at: i-2)
                    genes?.remove(at: i-3)
                    genes?.insert(Gene.Move, at: i-3)
                    genes?.insert(Gene.Move, at: i-3)
                    genes?.insert(Gene.Move, at: i-3)
                    genes?.insert(Gene.Move, at: i-3)
                }
                if (genes![i] == Gene.Left && genes![i-1] == Gene.Move && genes![i-2] == Gene.Move && genes![i-3] == Gene.Left) {
                    genes?.remove(at: i)
                    genes?.remove(at: i-1)
                    genes?.remove(at: i-2)
                    genes?.remove(at: i-3)
                    genes?.insert(Gene.Left, at: i-3)
                    genes?.insert(Gene.Left, at: i-3)
                    genes?.insert(Gene.Move, at: i-3)
                    genes?.insert(Gene.Move, at: i-3)
                }
                if (genes![i] == Gene.Right && genes![i-1] == Gene.Move && genes![i-2] == Gene.Move && genes![i-3] == Gene.Right) {
                    genes?.remove(at: i)
                    genes?.remove(at: i-1)
                    genes?.remove(at: i-2)
                    genes?.remove(at: i-3)
                    genes?.insert(Gene.Right, at: i-3)
                    genes?.insert(Gene.Right, at: i-3)
                    genes?.insert(Gene.Move, at: i-3)
                    genes?.insert(Gene.Move, at: i-3)
                }
            }
        }
    }
    
    // MARK :- Genetic Operations
    
    func crossover(genome: Genome) -> Genome {
        
        let newGenome = genome.copy()
        
        for i in 0..<self.geneCount! {
            
            if (i%2 == 0) {
                newGenome.genes![i] = self.genes![i]
            }
        }
        
        return newGenome
    }
    
    func invert() {
        
        let lengthToInverse = (Int)(arc4random_uniform(UInt32(genes!.count)))
        let genomeCopy = self.copy()
        var j = self.geneCount! - 1
        for i in 0..<lengthToInverse {
            self.genes![i] = genomeCopy.genes![j]
            j = j-1
        }
    }
    
    func mutate() {
        
        let mutateCount = (Int)(arc4random_uniform(UInt32(genes!.count/2)))
        for _ in 0..<mutateCount {
            let mutateIndex = (Int)(arc4random_uniform(UInt32(genes!.count)))
            self.genes![mutateIndex] = Gene.random()
        }
    }
}
