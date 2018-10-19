//
//  Scene.swift
//  BombSquash
//
//  Created by Jason Villegas on 10/16/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import Foundation

import SpriteKit

class BubbleScene: SKScene {
    
    
    var sceneBackground: SKSpriteNode!
    
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    var gameTimer: Timer!
    
    var gameSpeed: CGFloat = 10.0
    
    override func didMove(to view: SKView) {
        
        anchorPoint = CGPoint(x: 0, y: 1.0)
        sceneBackground = SKSpriteNode(color: UIColor.lightGray, size: size)
        sceneBackground.anchorPoint = CGPoint(x: 0, y: 1.0) //Anchors to top left
        sceneBackground.position = CGPoint(x: 0, y: 0)
        sceneBackground.zPosition = -1
        self.addChild(sceneBackground)
        
    }

    override func update(_ currentTime: CFTimeInterval) {
        
        if self.isPaused {
            lastUpdateTime = 0
        } else {
            if lastUpdateTime > 0 {
                dt = currentTime - lastUpdateTime
            } else {
                dt = 0
            }
            lastUpdateTime = currentTime
            
            //addBubble()
            dropBubbles()
            removeExcessBubbles()
        }
       
    }
    
    @objc
    func addBubble() {
        //Need to randomly make the bubble sizes
        
        //let bubble = SKSpriteNode(imageNamed: IMAGE)  //use this if we want to use an image instead

        
        let bubble = SKShapeNode(circleOfRadius: CGFloat(arc4random_uniform(25) + 5))
        bubble.fillColor = UIColor.red
        sceneBackground.addChild(bubble)
        var startingPoint = CGPoint(x: 0, y: 0)
        let randomValue = arc4random_uniform(UInt32(size.width))
        print("Random: \(randomValue) + BubbleWidth: \(UInt32(bubble.frame.width))")
        if randomValue < UInt32(bubble.frame.width) {
            startingPoint = CGPoint(x: bubble.frame.width / 2, y: 0)
        } else if randomValue + UInt32(bubble.frame.width) > UInt32(size.width) {
            startingPoint = CGPoint(x: size.width - (bubble.frame.width / 2), y: 0)
        } else {
            startingPoint = CGPoint(x: Int(randomValue), y: 0)
        }
 
        bubble.position = startingPoint
    }
    
    func dropBubbles() {
        for child in sceneBackground.children {
            let xOffset: CGFloat = 0
            let yOffset: CGFloat = gameSpeed
            let newLocation = CGPoint(x: child.position.x + xOffset, y: child.position.y - yOffset)
            let moveAction = SKAction.move(to: newLocation, duration: 0.2)
            child.run(moveAction)
        }
    }
    
    func removeExcessBubbles() {
        for child in sceneBackground.children {
            if child.position.y < (-1)*size.height {
                child.removeFromParent()
            }
        }
    }
}
