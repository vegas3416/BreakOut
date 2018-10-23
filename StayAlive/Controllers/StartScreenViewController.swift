//
//  StartScreenViewController.swift
//  StayAlive
//
//  Created by Jason Villegas on 10/22/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import UIKit
import SpriteKit


class StartScreenViewController: UIViewController, YouDeadDelegate {
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var delegate: YouDeadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var vc = GameViewController()
        
        
    }
    
    func youDead(score: Int) {
        scoreLabel.text = "\(score)"
    }

}
