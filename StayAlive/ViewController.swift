//
//  ViewController.swift
//  BombSquash
//
//  Created by Jason Villegas on 10/16/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController, ScoredPointsDelegate {
   

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var health: UILabel!
    
    @IBOutlet weak var bubbleView: SKView!
    
    var scene: StayAlive!
    var size: CGSize!
    
    var gameStarted: Bool = true
    var healthValue: Int = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        size = bubbleView.frame.size
        scene = StayAlive(size: size)
        
        //Don't present this just yet but looks good here
        bubbleView.presentScene(scene)
        gameStatus()
        health.text = "\(healthValue)"
        scene.gamePointsDelegate = self
    }

    @IBAction func gameStatusButtonPressed(_ sender: Any) {
      gameStatus()
        //print(gameStarted)
    }
    
    func gameStatus(){
        if gameStarted {
            startButton.setTitle("Pause", for: .normal)
            gameStarted = false

            scene.isPaused = false
            
        } else {
            startButton.setTitle("Start", for: .normal)
            gameStarted = true
            
            scene.isPaused = true
        }
    }
    
    @IBAction func gameSpeedSlider(_ sender: UISlider) {
        //print("Slider value: ", CGFloat(sender.value))
        scene.gameSpeed = CGFloat(sender.value)
        
    }
    
    func aliveOrDead() {
        
    }
    
    //TODO: If points are 100 return if zero YOU LOSE needs setup
    func gamePoints(value: Int, healthPadHit: Bool) {
        
        if healthPadHit {
            if healthValue == 100 {
                return
            } else {
                healthValue = healthValue + 10
                if healthValue > 100 {
                    healthValue = 100
                }
                health.text = "\(healthValue)"
            }
        } else {

            switch value {
            case 0...10:
                healthValue = healthValue - 10
                health.text = "\(healthValue)"
            case 11...20:
                healthValue = healthValue - 9
                health.text = "\(healthValue)"
            case 21...30:
                healthValue = healthValue - 8
                health.text = "\(healthValue)"
            case 31...40:
                healthValue = healthValue - 7
                health.text = "\(healthValue)"
            case 41...50:
                healthValue = healthValue - 6
                health.text = "\(healthValue)"
            case 51...60:
                healthValue = healthValue - 5
                health.text = "\(healthValue)"
            case 61...70:
                healthValue = healthValue - 4
                health.text = "\(healthValue)"
            case 71...80:
                healthValue = healthValue - 3
                health.text = "\(healthValue)"
            case 81...90:
                healthValue = healthValue - 2
                health.text = "\(healthValue)"
            case 100:
                healthValue = healthValue - 1
                health.text = "\(healthValue)"
            default:
                healthValue = healthValue - 1
                health.text = "\(healthValue)"
            }
        }
    }
}

