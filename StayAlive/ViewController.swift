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
   

    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var health: UILabel!
    @IBOutlet weak var healthTitle: UILabel!
    var healthValue: Int = 100
    
    @IBOutlet weak var bubbleView: SKView!
    
    var scene: StayAlive!
    var size: CGSize!
    
    var gameStarted: Bool = true
    
    @IBOutlet weak var score: UILabel!
    var totalPoints: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        size = bubbleView.frame.size
        scene = StayAlive(size: size)
        
        //Don't present this just yet but looks good here
        bubbleView.presentScene(scene)
        gameStatus()
        health.text = "\(healthValue)%"
        score.text = "\(totalPoints)"
        scene.gamePointsDelegate = self
    }

    @IBAction func gameStatusButtonPressed(_ sender: Any) {
      gameStatus()
        //print(gameStarted)
    }
    
    func gameStatus(){
        if gameStarted {
            pauseButton.setTitle("Pause", for: .normal)
            gameStarted = false

            scene.isPaused = false
            
        } else {
            pauseButton.setTitle("Start", for: .normal)
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
    func gamePoints(value: Int, healthPadHit: Bool, zombieKilled: Bool) {
        
        if healthValue >= 75 {
            healthTitle.textColor = UIColor.green
        } else if healthValue < 75 && healthValue >= 50 {
            healthTitle.textColor = UIColor.yellow
        } else if healthValue < 50 && healthValue >= 25 {
            healthTitle.textColor = UIColor.orange
        } else {
            healthTitle.textColor = UIColor.red
        }
        
        if healthPadHit {
            if healthValue == 100 {
                return
            } else {
                healthValue = healthValue + 10
                if healthValue > 100 {
                    healthValue = 100
                }
                health.text = "\(healthValue)%"
            }
        } else {

            switch value {
            case 0...10:
                if zombieKilled {
                    totalPoints += 10
                    score.text = "\(totalPoints)"
                } else {
                    healthValue = healthValue - 10
                    health.text = "\(healthValue)%"
                }
            case 11...20:
                if zombieKilled {
                    totalPoints += 9
                    score.text = "\(totalPoints)"
                } else {
                    healthValue = healthValue - 9
                    health.text = "\(healthValue)%"
                }
            case 21...30:
                if zombieKilled {
                    totalPoints += 8
                    score.text = "\(totalPoints)"
                } else {
                    healthValue = healthValue - 8
                    health.text = "\(healthValue)%"
                }
            case 31...40:
                if zombieKilled {
                    totalPoints += 7
                    score.text = "\(totalPoints)"
                } else {
                    healthValue = healthValue - 7
                    health.text = "\(healthValue)%"
                }
            case 41...50:
                if zombieKilled {
                    totalPoints += 6
                    score.text = "\(totalPoints)"
                } else {
                    healthValue = healthValue - 6
                    health.text = "\(healthValue)%"
                }
            case 51...60:
                if zombieKilled {
                    totalPoints += 5
                    score.text = "\(totalPoints)"
                } else {
                    healthValue = healthValue - 5
                    health.text = "\(healthValue)%"
                }
            case 61...70:
                if zombieKilled {
                    totalPoints += 4
                    score.text = "\(totalPoints)"
                } else {
                    healthValue = healthValue - 4
                    health.text = "\(healthValue)%"
                }
            case 71...80:
                if zombieKilled {
                    totalPoints += 3
                    score.text = "\(totalPoints)"
                } else {
                    healthValue = healthValue - 3
                    health.text = "\(healthValue)%"
                }
            case 81...90:
                if zombieKilled {
                    totalPoints += 2
                    score.text = "\(totalPoints)"
                } else {
                    healthValue = healthValue - 2
                    health.text = "\(healthValue)%"
                }
            case 100:
                if zombieKilled {
                    totalPoints += 1
                    score.text = "\(totalPoints)"
                } else {
                    healthValue = healthValue - 1
                    health.text = "\(healthValue)%"
                }
            default:
                if zombieKilled {
                    totalPoints += 1
                    score.text = "\(totalPoints)"
                } else {
                    healthValue = healthValue - 1
                    health.text = "\(healthValue)%"
                }
            }
        }
    }
}

