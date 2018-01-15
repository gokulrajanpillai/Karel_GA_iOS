
//
//  Genome.swift
//  Karel
//
//  Created by Gokul Rajan on 15.01.18.
//  Copyright © 2018 RAJAN. All rights reserved.
//

import UIKit

class Genome: NSObject {
    
    var geneCount: Int?
    
    var genes: Array<Gene>?
    
    static func randomGenome(geneCount: Int) -> Genome {
        
        let genome: Genome = Genome(geneCount: geneCount)
        
        for _ in 0..<geneCount {
            
            genome.genes?.append(Gene.random())
        }
        
        return genome
    }
    
    init(geneCount: Int) {
        
        self.geneCount = geneCount
    }
}
