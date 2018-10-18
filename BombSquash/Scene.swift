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
    
    var gameSpeed: CGFloat = 10.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
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
            
            addBubble()
            dropBubbles()
            removeExcessBubbles()
        }
       
    }
    
    func addBubble() {
        let bubble = SKShapeNode(circleOfRadius: 6)        //SKSpriteNode(color: UIColor.white, size: CGSize(width: 10, height: 10))
        bubble.fillColor = UIColor.red
        sceneBackground.addChild(bubble)
        let startPoint = CGPoint(x: size.width/2, y: 0)
        bubble.position = startPoint
    }
    
    func dropBubbles() {
        for child in sceneBackground.children {
            let xOffset: CGFloat = CGFloat(arc4random_uniform(20)) - 10.0
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
