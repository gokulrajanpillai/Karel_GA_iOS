//
//  Block.swift
//  Karel
//
//  Created by RAJAN on 14.09.17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import UIKit

protocol BlockViewDelegate {
    
    func getKarelDirection() -> KarelDirection
}

class BlockView: UIView, BlockViewDelegate {
 
    var blockData   : BlockData
    
    var delegate    : CanvasDelegate?
    
    init(data: BlockData, frame: CGRect, delegate: CanvasDelegate) {
        self.blockData = data
        super.init(frame: frame)
        drawBackground()
        NotificationCenter.default.addObserver(self, selector: #selector(setNeedsDisplay as () -> (Void)), name: NSNotification.Name(rawValue: "BlockUpdated"), object: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    override func draw(_ rect: CGRect) {
        
        drawBoundaries()
        drawBackground()
        drawKarel(frame: rect)
    }
    
    func drawBoundaries() {
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height-1))
        path.move(to: CGPoint(x: self.bounds.width-1, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width-1, y: self.bounds.height-1))
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width-1, y: 0))
        path.move(to: CGPoint(x: 0, y: self.bounds.height-1))
        path.addLine(to: CGPoint(x: self.bounds.width-1, y: self.bounds.height-1))
        
        UIColor.lightGray.set()
        path.stroke()
        path.fill()
    }
    
    func drawBackground() {
        
        if blockData.IS_WALL {
            self.backgroundColor = UIColor.black
        }
        else {
            self.backgroundColor = UIColor.white
        }
//        let path = UIBezierPath()
//
//        if (blockData.HAS_WALL_LEFT) {
//            path.move(to: CGPoint(x: 0, y: 0))
//            path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
//        }
//        if (blockData.HAS_WALL_RIGHT) {
//            path.move(to: CGPoint(x: self.bounds.width-1, y: 0))
//            path.addLine(to: CGPoint(x: self.bounds.width-1, y: self.bounds.height-1))
//        }
//        if (blockData.HAS_WALL_UP) {
//            path.move(to: CGPoint(x: 0, y: 0))
//            path.addLine(to: CGPoint(x: self.bounds.width-1, y: 0))
//        }
//        if (blockData.HAS_WALL_DOWN) {
//            path.move(to: CGPoint(x: 0, y: self.bounds.height-1))
//            path.addLine(to: CGPoint(x: self.bounds.width-1, y: self.bounds.height-1))
//        }
//
//        UIColor.blue.set()
//        path.stroke()
//        path.fill()
    }
    
    func drawKarel(frame : CGRect) {
        if (blockData.HAS_KAREL) {
            addKarel()
        }
        else {
            removeKarel()
        }
    }
    
    func addKarel() {
        
        let kDim = self.frame.width - 20
        let frame = CGRect(x: ((self.frame.width/2) - (kDim/2)), y: ((self.frame.height/2) - (kDim/2)), width: kDim, height: kDim)
        
        let karelView = KarelView(frame: frame, delegate: self)
        karelView.tag = 777
        addSubview(karelView)
    }
    
    func removeKarel() {
        self.subviews.forEach({
            if $0.tag == 777 {
                $0.removeFromSuperview()
            }
        })
    }
    
    // MARK: - BlockView delegate
    func getKarelDirection() -> KarelDirection {
        return (delegate?.getKarelDirection())!
    }
}
