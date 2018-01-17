//
//  ViewController.swift
//  Karel
//
//  Created by RAJAN on 14.09.17.
//  Copyright © 2017 RAJAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var karelView: UIView!
    
    var karel: Karel?
    
    var canvas: Canvas! = nil
    
    var gAController: GAController?
    
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
    
    
    // MARK: - User Actions

    @IBAction func startGeneticAlgorithm(_ sender: Any) {
        gAController = GAController(karel: karel)

        gAController?.startGeneticAlgorithm()
//        gAController?.createInitialPopulation()
//        gAController?.executeGenomes()
//        karel!.turnLeft()
    }

//    @IBAction func turnRight(_ sender: Any) {
//        karel!.turnRight()
//    }
//
//    @IBAction func move(_ sender: Any) {
//        karel!.move()
//    }
    
}

