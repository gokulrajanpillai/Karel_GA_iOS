//
//  ViewController.swift
//  Karel
//
//  Created by RAJAN on 4/14/17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var karelView: UIView!
    
    var karel = Karel.sharedInstance
    
    var canvas: Canvas! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    static var i : Int = 0
    
    override func viewDidLayoutSubviews() {
        
        if (ViewController.i == 0) {
            
            canvas = Canvas(frame: self.karelView.bounds);
            karel.canvasDelegate = canvas as CanvasDelegate
            self.karelView.addSubview(canvas);
            ViewController.i+=1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func turnLeft(_ sender: Any) {
        karel.turnLeft()
    }

    @IBAction func turnRight(_ sender: Any) {
        karel.turnRight()
    }
    
    @IBAction func move(_ sender: Any) {
        karel.move()
    }
}

