//
//  ViewController.swift
//  BombSquash
//
//  Created by Jason Villegas on 10/16/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import UIKit
import SpriteKit

protocol YouDeadDelegate {
    //This is sent to the startViewcontroller to update the score label
    func youDead(score: Int)
}

class GameViewController: UIViewController, ScoredPointsDelegate {
    
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var health: UILabel!
    @IBOutlet weak var healthTitle: UILabel!
    
    @IBOutlet weak var gameSlider: UISlider!
    var healthValue: Int = 100
    
    var gameSpeed: Float = 10
    
    @IBOutlet weak var bubbleView: SKView!
    
    var scene: StayAlive!
    var size: CGSize!
    
    var delegate: YouDeadDelegate?
    
    @IBOutlet weak var score: UILabel!
    var totalPoints: Int = 0
    
    @IBOutlet weak var zombieCounter: UILabel!
    @IBOutlet weak var zombieCounterTitleLabel: UILabel!
    
    var sliderManuallyUpdated: Bool = false
    var gameLevel: Int = 1
    
    var alertController = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        size = bubbleView.frame.size
        scene = StayAlive(size: size)
        bubbleView.presentScene(scene)
        
        let sliderThumbImage = UIImage(named: "boyRight")
        let resizedImage = sliderThumbImage?.resizeImage(30, opaque: false)
        gameSlider.setThumbImage(resizedImage , for: .normal)
        
        health.text = "\(healthValue)%"
        score.text = "\(totalPoints)"
        scene.gamePointsDelegate = self
        
        scene.gameSpeed = CGFloat(gameSpeed)
    }
    
    func didUserManuallyUpdateSlider() {
        
        if gameLevel == 1 && gameSlider.value > 10 {
            sliderManuallyUpdated = true
        } else if gameLevel == 2 && gameSlider.value != 30 {
            sliderManuallyUpdated = true
        } else if gameLevel == 3 && gameSlider.value != 50 {
            sliderManuallyUpdated = true
        } else if gameLevel == 4 && gameSlider.value != 70 {
            sliderManuallyUpdated = true
        } else if gameLevel == 5 && gameSlider.value != 90 {
            sliderManuallyUpdated = true
        }
        
    }
    
    func zombieCounter(counter: Int, level: Int) {
        gameLevel = level
        
        if sliderManuallyUpdated {
            return
        }
        
        switch level {
        case 1:
            gameSlider.value = 10
            gameSpeedSlider(gameSlider)
        case 2:
            gameSlider.value = 30
            gameSpeedSlider(gameSlider)
        case 3:
            gameSlider.value = 50
            gameSpeedSlider(gameSlider)
        case 4:
            gameSlider.value = 70
            gameSpeedSlider(gameSlider)
        case 5:
            gameSlider.value = 90
            gameSpeedSlider(gameSlider)
        default:
            gameSlider.value = 10
            gameSpeedSlider(gameSlider)
        }
        zombieCounter.text = "\(counter)"
    }

    @IBAction func gameStatusButtonPressed(_ sender: Any) {
        gameStatus()
    }

    func gameStatus(){
        
        scene.isPaused = true

        alertController = UIAlertController(title: "Paused", message: "Would you like to resume game or restart?", preferredStyle: .alert)
        
        let resumeAction = UIAlertAction(title: "Resume", style: .default) { _ in
            self.scene.isPaused = false
        }
        
        let restartAction = UIAlertAction(title: "Restart", style: .default) { _ in
            self.delegate?.youDead(score: self.totalPoints)
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(resumeAction)
        alertController.addAction(restartAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func gameSpeedSlider(_ sender: UISlider) {
        didUserManuallyUpdateSlider()
        scene.gameSpeed = CGFloat(sender.value)
        
        if sliderManuallyUpdated {
            zombieCounter.isHidden = true
            zombieCounterTitleLabel.isHidden = true
        }
    }
    
    func youDead() {
        
        scene.isPaused = true
        let messageString: String
        if totalPoints < 100 {
            messageString = "Wow, I don't want you on my team during a zombie battle. You scored: \(totalPoints)"
        } else if totalPoints >= 100 && totalPoints < 200 {
            messageString = "Ehhh, you should of ran faster. Score: \(totalPoints)"
        } else if totalPoints > 200 && totalPoints < 500 {
            messageString = "OK OK..you might beat out my grandma but she still almost had you. Score: \(totalPoints)"
        } else {
            messageString = "Now we are talking...Next time take the shotgun. We will take out even more next time. Great Score: \(totalPoints)!!"
        }
        
        alertController = UIAlertController(title: "YOU DEAD!!", message: messageString, preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default) { (alert) in
            self.delegate?.youDead(score: self.totalPoints)
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)

        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkHealthValue() {
        if healthValue <= 0 {
            youDead()
        }
        if healthValue >= 75 {
            healthTitle.textColor = UIColor.green
        } else if healthValue < 75 && healthValue >= 50 {
            healthTitle.textColor = UIColor.yellow
        } else if healthValue < 50 && healthValue >= 25 {
            healthTitle.textColor = UIColor.orange
        } else {
            healthTitle.textColor = UIColor.red
        }
    }
    
    func noNegativeScore(value: Int) -> String {
        if healthValue - value <= 0 {
            healthValue = 0
            return "\(healthValue)%"
        }
        healthValue = healthValue - value
        return "\(healthValue)%"
    }
    //TODO: If points are 100 return if zero YOU LOSE needs setup
    func gamePoints(value: Int, healthPadHit: Bool, zombieKilled: Bool) {
        if healthPadHit {
            if healthValue == 100 {
                checkHealthValue()
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
                    health.text = noNegativeScore(value: 10)
                }
            case 11...20:
                if zombieKilled {
                    totalPoints += 9
                    score.text = "\(totalPoints)"
                } else {
                    health.text = noNegativeScore(value: 9)
                }
            case 21...30:
                if zombieKilled {
                    totalPoints += 8
                    score.text = "\(totalPoints)"
                } else {
                    health.text = noNegativeScore(value: 8)
                }
            case 31...40:
                if zombieKilled {
                    totalPoints += 7
                    score.text = "\(totalPoints)"
                } else {
                    health.text = noNegativeScore(value: 7)
                }
            case 41...50:
                if zombieKilled {
                    totalPoints += 6
                    score.text = "\(totalPoints)"
                } else {
                    health.text = noNegativeScore(value: 6)
                }
            case 51...60:
                if zombieKilled {
                    totalPoints += 5
                    score.text = "\(totalPoints)"
                } else {
                    health.text = noNegativeScore(value: 5)
                }
            case 61...70:
                if zombieKilled {
                    totalPoints += 4
                    score.text = "\(totalPoints)"
                } else {
                    health.text = noNegativeScore(value: 4)
                }
            case 71...80:
                if zombieKilled {
                    totalPoints += 3
                    score.text = "\(totalPoints)"
                } else {
                    health.text = noNegativeScore(value: 3)
                }
            case 81...90:
                if zombieKilled {
                    totalPoints += 2
                    score.text = "\(totalPoints)"
                } else {
                    health.text = noNegativeScore(value: 2)
                }
            case 91...100:
                if zombieKilled {
                    totalPoints += 1
                    score.text = "\(totalPoints)"
                } else {
                    health.text = noNegativeScore(value: 1)
                }
            default:
                if zombieKilled {
                    totalPoints += 1
                    score.text = "\(totalPoints)"
                } else {
                    health.text = noNegativeScore(value: value)
                }
            }
        }
        checkHealthValue()
    }
}

