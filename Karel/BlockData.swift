//
//  BlockData.swift
//  Karel
//
//  Created by RAJAN on 4/15/17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import Foundation
import EVReflection

class BlockData : EVObject {
    
    public var x = 0
    public var y = 0
    
    public var IS_WALL        = false
    {
        didSet {
            postSetNotify()
        }
    }
    
    public var HAS_KAREL       = false
        {
        didSet {
            postSetNotify()
        }
    }
    
    public var HAS_BEEPER      = false
        {
        didSet {
            postSetNotify()
        }
    }
    
//    public var HAS_WALL_LEFT   = false
//        {
//        didSet {
//            postSetNotify()
//        }
//    }
//    public var HAS_WALL_RIGHT  = false
//        {
//        didSet {
//            postSetNotify()
//        }
//    }
//    public var HAS_WALL_UP     = false
//        {
//        didSet {
//            postSetNotify()
//        }
//    }
//    public var HAS_WALL_DOWN   = false
//        {
//        didSet {
//            postSetNotify()
//        }
//    }
//
    
    func postSetNotify() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "BlockUpdated"), object: nil)
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    required convenience init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
