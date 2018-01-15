//
//  Karel.swift
//  Karel
//
//  Created by RAJAN on 4/15/17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import UIKit

class KarelView : UIView {
    
    var delegate: BlockViewDelegate?
    
    init(frame: CGRect, delegate: BlockViewDelegate) {
        
        super.init(frame:frame)
        self.backgroundColor = UIColor.white
        NotificationCenter.default.addObserver(self, selector: #selector(setNeedsDisplay as () -> (Void)), name: NSNotification.Name(rawValue: "KarelDirectionChanged"), object: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let karel = UIImageView(image: imageForDirection())
        karel.frame = self.bounds
        karel.contentMode = .scaleAspectFill
        self.addSubview(karel)
    }
    
    func imageForDirection() -> UIImage? {
        
        switch (delegate?.getKarelDirection())! {
            
            case .Left  : return imageForName(name: "karelLeft")
            case .Right : return imageForName(name: "karelRight")
            case .Top   : return imageForName(name: "karelUp")
            case .Down  : return imageForName(name: "karelDown")
        }
    }
    
    func imageForName(name: String) -> UIImage? {
        
        let frameworkBundle = Bundle(for: KarelView.self)
        let imagePath = frameworkBundle.path(forResource: name, ofType: "png")
        if imagePath != nil {
            return UIImage(contentsOfFile: imagePath!)
        }
        return nil
    }
    
}
