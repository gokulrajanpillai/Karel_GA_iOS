//
//  Canvas.swift
//  Karel
//
//  Created by RAJAN on 4/14/17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import UIKit

protocol CanvasDelegate {
    
    func moveKarel(direction : KarelDirection)
}

class Canvas: UIView, CanvasDelegate{
    
    var BLOCK_DIM : Int
    
    let BLOCK_DIM_X = 7
    
    let BLOCK_DIM_Y = 12
    
    var currentKarelBlock : BlockData! = nil
    
    var blocks = [[BlockData]]()
    
    override init(frame: CGRect) {
        BLOCK_DIM = Int(Float(frame.width) / Float(BLOCK_DIM_X))
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let BLOCK_SIZE = CGSize(width: self.BLOCK_DIM, height: self.BLOCK_DIM)
        
        let BLOCK_DIM = Int(self.BLOCK_DIM)
        
        for x in 0...BLOCK_DIM_X-1 {
            
            blocks.append([])
            
            for y in 0...BLOCK_DIM_Y-1 {
                blocks[x].append(BlockData(x: x, y: y))
                
                let blockData = blocks[x][y]
                
                if (x==0 && y==BLOCK_DIM_Y-1) {
                    blockData.HAS_KAREL = true
                    currentKarelBlock = blockData
                }
                
                self.addSubview(BlockView(data: blockData, frame: CGRect(origin: CGPoint(x: x*BLOCK_DIM, y: y*BLOCK_DIM), size: BLOCK_SIZE)))
            }
        }
    }
    
    func moveKarel(direction: KarelDirection) {
    
        let futureKarelBlock = getFutureBlock(direction: direction)
        
        if ((futureKarelBlock) != nil) {
            currentKarelBlock.HAS_KAREL =   false
            futureKarelBlock!.HAS_KAREL  =   true
            currentKarelBlock = futureKarelBlock!
        }
    }
    
    func getFutureBlock(direction: KarelDirection) -> BlockData? {
        
        let x = currentKarelBlock.x
        let y = currentKarelBlock.y
        
        switch direction {
        case .Left  : return x-1 < 0 ? nil:getBlock(x: x-1, y: y)
        case .Right : return x+1 >= BLOCK_DIM_X ? nil: getBlock(x: x+1, y: y)
        case .Top   : return y-1 < 0 ? nil: getBlock(x: x, y: y-1)
        case .Down  : return y+1 >= BLOCK_DIM_Y ? nil: getBlock(x: x, y: y+1)
        }
    }
    
    func getBlock(x: Int, y: Int) -> BlockData {
        
        return blocks[x][y]
    }
}
