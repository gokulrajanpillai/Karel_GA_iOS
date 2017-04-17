//
//  Karel.swift
//  Karel
//
//  Created by RAJAN on 4/15/17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import UIKit

class KarelView : UIView {
    
    var karel = Karel.sharedInstance
    
    override init(frame: CGRect) {
        
        super.init(frame:frame)
        self.backgroundColor = UIColor.white
        NotificationCenter.default.addObserver(self, selector: #selector(setNeedsDisplay as (Void) -> (Void)), name: NSNotification.Name(rawValue: "KarelDirectionChanged"), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let karel = UIImageView(image: UIImage(named: imageForDirection()))
        karel.frame = self.bounds
        karel.contentMode = .scaleAspectFill
        self.addSubview(karel)
    }
    
    func imageForDirection() -> String {
        
        switch karel.direction() {
            
        case .Left  : return "karelLeft"
        case .Right : return "karelRight"
        case .Top   : return "karelUp"
        case .Down  : return "karelDown"
            
        }
    }
    
}
