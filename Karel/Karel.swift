//
//  Karel.swift
//  Karel
//
//  Created by RAJAN on 4/16/17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import Foundation
import UIKit

protocol KarelDelegate {
    
    func getKarelDirection() -> KarelDirection
    
}

class Karel: KarelDelegate, GADelegate {
    
    let karelData: KarelData?
    
    var karelEnvironmentView: UIView?
    
    var canvas: Canvas?
    
    init(view: UIView, row: Int = 5, column: Int = 5, backgroundColor: UIColor = UIColor.white) {
        
        karelEnvironmentView     = view
        karelData                = KarelData()
        canvas                   = Canvas(frame: (karelEnvironmentView?.bounds)!, row: row, column: column, backgroundColor: backgroundColor, delegate: self)
        self.karelEnvironmentView?.addSubview(self.canvas!)
    }
    
    func resetKarelEnvironment() {
        canvas!.resetEnvironment()
        karelData?.reset()
    }
    
    func move() {
        canvas!.moveKarel(direction: karelData!.direction)
    }
    
    func turnLeft() {
        karelData!.turnLeft()
    }
    
    func turnRight() {
        karelData!.turnRight()
    }
    
    func getKarelDirection() -> KarelDirection {
        return karelData!.direction
    }

    // MARK :- GA Delegate
    func getCurrentBlockData() -> BlockData? {
        
        return canvas!.currentKarelBlock
    }
    
    func getDestinationBlockData() -> BlockData? {
        
        return canvas!.finalBlock
    }
}
