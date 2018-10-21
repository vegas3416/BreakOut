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
    @IBOutlet weak var pointsScored: UILabel!
    
    @IBOutlet weak var bubbleView: SKView!
    
    var scene: StayAlive!
    var size: CGSize!
    
    var gameStarted: Bool = true
    var points: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        size = bubbleView.frame.size
        scene = StayAlive(size: size)
        
        //Don't present this just yet but looks good here
        bubbleView.presentScene(scene)
        gameStatus()
        
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
    
    func gamePoints(value: Int) {

        switch value {
        case 0...10:
            points = points + 10
            pointsScored.text = "\(points)"
        case 11...20:
            points = points + 9
            pointsScored.text = "\(points)"
        case 21...30:
            points = points + 8
            pointsScored.text = "\(points)"
        case 31...40:
            points = points + 7
            pointsScored.text = "\(points)"
        case 41...50:
            points = points + 6
            pointsScored.text = "\(points)"
        case 51...60:
            points = points + 5
            pointsScored.text = "\(points)"
        case 61...70:
            points = points + 4
            pointsScored.text = "\(points)"
        case 71...80:
            points = points + 3
            pointsScored.text = "\(points)"
        case 81...90:
            points = points + 2
            pointsScored.text = "\(points)"
        case 100:
            points = points + 1
            pointsScored.text = "\(points)"
        default:
            points = points + 1
            pointsScored.text = "\(points)"
        }
    }
    
}

