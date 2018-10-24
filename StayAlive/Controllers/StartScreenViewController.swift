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
        
    }
    
    @IBAction func startButtonSelected(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GameVC") as! GameViewController
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    func youDead(score: Int) {
        scoreLabel.text = "\(score)"
    }

}
