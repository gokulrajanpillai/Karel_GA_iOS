
//
//  Genome.swift
//  Karel
//
//  Created by Gokul Rajan on 15.10.17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import UIKit

class Genome: NSObject {
    
    var geneCount: Int?
    
    var genes: [Gene]?
    
    var r1: Int?
    
    var r2: Int?
    
    var r3: Int?
    
    static func randomGenome(geneCount: Int) -> Genome {
        
        let genome: Genome = Genome(geneCount: geneCount)
        
        for _ in 0..<geneCount {
            
            genome.genes?.append(Gene.random())
        }
        
        return genome
    }
    
    static func copy(genome genomeToCopy: Genome) -> Genome {
        
        let genome: Genome = Genome(geneCount: genomeToCopy.geneCount!)
        
        for gene in genomeToCopy.genes! {
            
            genome.genes?.append(gene)
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
    
    func r4() -> Int {
        return r1! + r3!
    }
}
