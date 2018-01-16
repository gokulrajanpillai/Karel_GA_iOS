
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
    }
}
