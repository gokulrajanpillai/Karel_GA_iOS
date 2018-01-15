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
    
    var karel: Karel?
    
    var canvas: Canvas! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        fetchInitialAndFinalStates()
        
    }
    
    override func viewDidLayoutSubviews() {
        karel = Karel(view: self.karelView)
    }
    
    // MARK: - GA
    
    /**
     Fetch the initial and final states of the map from the json inputs
     */
    func fetchInitialAndFinalStates() {
        
//        let initialStateJson:String = "{\"x\": 0, \"y\": 0, \"isWall\": \"false\", \"isKarelPresent\": \"true\",  \"karelDirection\": \"right\", \"isBeeperPresent\": \"false\"}"
//        let initialState = BlockData(json: initialStateJson)
//        
//        
//        let finalStateJson:String = "{\"x\": 0, \"y\": 0, \"isWall\": \"false\", \"isKarelPresent\": \"true\",  \"karelDirection\": \"right\", \"isBeeperPresent\": \"false\"}"
//        let finalState = BlockData(json: initialStateJson)
//        
        
    }
    
    // MARK: - User Actions

    @IBAction func turnLeft(_ sender: Any) {
        karel!.turnLeft()
    }

    @IBAction func turnRight(_ sender: Any) {
        karel!.turnRight()
    }
    
    @IBAction func move(_ sender: Any) {
        karel!.move()
    }
}

