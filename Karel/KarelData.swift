//
//  KarelData.swift
//  Karel
//
//  Created by RAJAN on 4/16/17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import Foundation

enum KarelDirection : Int {
    case Right = 0, Top ,Left, Down
}

class KarelData {
    
//    static let sharedInstance = KarelData()
    
    var direction: KarelDirection = .Right
    
    func turnLeft() {
        let rawValue = (direction.rawValue + 1) % 4
        direction = KarelDirection(rawValue: rawValue)!
        directionUpdated()
    }
    
    func turnRight() {
        for _ in 1...3 {
            turnLeft()
            directionUpdated()
        }
    }
    
    func directionUpdated() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "KarelDirectionChanged"), object: nil)
    }
    
    func reset() {
        direction = .Right
    }
}
