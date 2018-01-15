//
//  Gene.swift
//  Karel
//
//  Created by Gokul Rajan on 15.01.18.
//  Copyright © 2018 RAJAN. All rights reserved.
//

import UIKit

enum Gene: UInt32 {
    case Left
    case Right
    case Move
    
    /**
     Random function
     - parameter alpha: Describe the alpha param
     - Returns: A random gene from the list of enum
     */
    static func random() -> Gene {

        let maxValue = Move.rawValue
        let rand = arc4random_uniform(maxValue+1)
        return Gene(rawValue: rand)!
    }
}
