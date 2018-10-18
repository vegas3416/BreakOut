//
//  ViewController.swift
//  BombSquash
//
//  Created by Jason Villegas on 10/16/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pointsScored: UILabel!
    
    @IBOutlet weak var bubbleView: SKView!
    
    var scene: BubbleScene!
    var size: CGSize!
    
    var gameStarted: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        size = bubbleView.frame.size
        scene = BubbleScene(size: size)
    }

    @IBAction func gameStatusButtonPressed(_ sender: Any) {
      gameStatus()
        print(gameStarted)
    }
    
    func gameStatus(){
        if gameStarted {
            startButton.setTitle("Pause", for: .normal)
            gameStarted = false
            
            bubbleView.presentScene(scene)
            
        } else {
            startButton.setTitle("Start", for: .normal)
            gameStarted = true
            scene.isPaused = true
            //Need to stop the scene from moving
        }
    }
    
    @IBAction func gameSpeedSlider(_ sender: UISlider) {
        //print("Slider value: ", CGFloat(sender.value))
        scene.gameSpeed = CGFloat(sender.value)
        
    }
    
}

