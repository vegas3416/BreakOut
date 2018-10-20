//
//  Scene.swift
//  BombSquash
//
//  Created by Jason Villegas on 10/16/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import Foundation

import SpriteKit

protocol ScoredPointsDelegate {
    func gamePoints(value: Int)
}

class BubbleScene: SKScene {
    
    var gamePointsDelegate: ScoredPointsDelegate?
    
    var sceneBackground: SKSpriteNode!

    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    var gameTimer: Timer!
    
    var gameSpeed: CGFloat = 10.0
    var zombieCounter = 0

    override func didMove(to view: SKView) {

        anchorPoint = CGPoint(x: 0, y: 1.0)
        sceneBackground = SKSpriteNode(color: UIColor.lightGray, size: size)
        sceneBackground.anchorPoint = CGPoint(x: 0, y: 1.0) //Anchors to top left
        sceneBackground.position = CGPoint(x: 0, y: 0)
        sceneBackground.zPosition = -1
        self.addChild(sceneBackground)
        
        //gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(addBubble), userInfo: nil, repeats: true)


    }

    override func update(_ currentTime: CFTimeInterval) {

        //Add bubbles at correct time
        if lastUpdateTime > 0 {
            if currentTime - lastUpdateTime > 1 {
                addItem()
                lastUpdateTime = currentTime
            }
        } else {
            lastUpdateTime = currentTime
        }

        //Take care of bubble movement and removal of bubble
        dropBubbles()
        removeExcessBubbles()
       
        checkCollisions()
    }

    func addItem() {

        zombieCounter += 1
        var fallingItem = SKSpriteNode()
        let sizeOfItem = CGFloat(arc4random_uniform(91) + 10)
        
        if zombieCounter > 5 {
            fallingItem = SKSpriteNode(imageNamed: "boy")
            fallingItem.name = "boy"
            fallingItem.size = CGSize(width: 25, height: 25)
            fallingItem.zPosition = sizeOfItem
            zombieCounter = 0
        } else {
            fallingItem = SKSpriteNode(imageNamed: "zombie")
            fallingItem.name = "zombie"
            let sizeOfItem = CGFloat(arc4random_uniform(91) + 10)
            fallingItem.size = CGSize(width: sizeOfItem, height: sizeOfItem)
            fallingItem.zPosition = sizeOfItem
        }
        
        sceneBackground.addChild(fallingItem)
        
        //Holder for starting point until actual start is set
        var startingPoint = CGPoint(x: 0, y: 0)
        let randomValue = arc4random_uniform(UInt32(self.size.width))

        if randomValue < UInt32(fallingItem.frame.width) {
            startingPoint = CGPoint(x: fallingItem.frame.width / 2, y: 0)
        } else if randomValue + UInt32(fallingItem.frame.width) > UInt32(size.width) {
            startingPoint = CGPoint(x: size.width - (fallingItem.frame.width / 2), y: 0)
        } else {
            startingPoint = CGPoint(x: Int(randomValue), y: 0)
        }
 
        fallingItem.position = startingPoint
    }
    
    func dropBubbles() {
        for child in sceneBackground.children {
            let xOffset: CGFloat = 0
            let yOffset: CGFloat = gameSpeed
            let newLocation = CGPoint(x: child.position.x + xOffset, y: child.position.y - yOffset)
            let moveAction = SKAction.move(to: newLocation, duration: 1)
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
    
    func checkCollisions() {
        var hitZombies: [SKSpriteNode] = []
        sceneBackground.enumerateChildNodes(withName: "zombie") { node, _ in
            let zombie = node as! SKSpriteNode
            let boys = self.sceneBackground.children.filter { $0.name == "boy" }
            
            if boys.count == 0 { return }
            
            for boy in boys {
                if zombie.frame.intersects(boy.frame) {
                    hitZombies.append(zombie)
                }
            }

        }
        
        for zombie in hitZombies {
            print("hit Zombie")
        }
    }
    
    func boyRunsAway(boy: SKSpriteNode) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if isPaused {
            return
        }

        let touchLocation = touch.location(in: self)
        
        let nodes = sceneBackground.nodes(at: touchLocation)
        
        if nodes.count == 0 {
            return
        }
        
        //This is so that only one node is removed if multiple nodes reside in the same location
        let maxNode = nodes.reduce(nodes[0]) { $0.zPosition > $1.zPosition ? $0 : $1 }
        
        //Don't want to allow user to dismiss boy node
        if maxNode.name == "boy" {
            return
        }
        gamePointsDelegate?.gamePoints(value: Int(maxNode.frame.size.width))
        maxNode.removeFromParent()
    }
}
