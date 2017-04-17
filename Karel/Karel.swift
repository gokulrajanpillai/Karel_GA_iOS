//
//  Karel.swift
//  Karel
//
//  Created by RAJAN on 4/16/17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import Foundation

class Karel {
    
    static let sharedInstance = Karel()
    
    var canvasDelegate: CanvasDelegate? = nil
    
    let data = KarelData.sharedInstance
        
    func move() {
        
        canvasDelegate!.moveKarel(direction: data.direction)
    }
    
    func turnLeft() {
        data.turnLeft()
    }
    
    func turnRight() {
        data.turnRight()
    }
    
    func direction() -> KarelDirection {
        return data.direction
    }
    
    
}
