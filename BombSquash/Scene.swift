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
    //let playableRect: CGRect

    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    var gameTimer: Timer!
    
    var gameSpeed: CGFloat = 10.0
    var zombieCounter = 0
    
    let boy = SKSpriteNode(imageNamed: "boy")
    let boyMovePtsPerSec: CGFloat = 450.0
    var velociyOfBoy = CGPoint.zero
    
    let door = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 10))
    
//    override init(size: CGSize) {
//        let playableHeight = size.height
//        let playableWidth = size.width
//        playableRect = CGRect( x: 0, y: playableWidth, width: playableWidth, height: playableHeight)
//        super.init(size: size)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    

    override func didMove(to view: SKView) {

        anchorPoint = CGPoint(x: 0, y: 1.0)
        sceneBackground = SKSpriteNode(color: UIColor.lightGray, size: size)
        sceneBackground.anchorPoint = CGPoint(x: 0, y: 1.0) //Anchors to top left
        sceneBackground.position = CGPoint(x: 0, y: 0)
        sceneBackground.zPosition = -1
        self.addChild(sceneBackground)
        
        let border = SKPhysicsBody(edgeLoopFrom: sceneBackground.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
       
        
        addBoy()

        door.name = "door"
        door.position = CGPoint(x: (size.width / 2), y: (((-1) * size.height) + 10))
        addChild(door)
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
    
    func addBoy() {
        
        boy.name = "boy"
        boy.size = CGSize(width: 30, height: 30)
        addChild(boy)
        boy.position = CGPoint(x: boy.size.width, y: (-1) * boy.size.height + 10)
        boy.physicsBody = SKPhysicsBody(circleOfRadius: boy.size.width / 2)
        boy.physicsBody?.applyImpulse(CGVector(dx: 10 , dy: 0))

        boy.physicsBody?.isDynamic = true
        boy.physicsBody?.friction = 0
        boy.physicsBody?.restitution = 1
        boy.physicsBody?.linearDamping = 0

    }

    func addItem() {

        var fallingItem = SKSpriteNode()

        fallingItem = SKSpriteNode(imageNamed: "zombie")
        fallingItem.name = "zombie"
        let sizeOfItem = CGFloat(arc4random_uniform(91) + 10)
        fallingItem.size = CGSize(width: sizeOfItem, height: sizeOfItem)
        fallingItem.physicsBody = SKPhysicsBody(rectangleOf: fallingItem.size)
        fallingItem.physicsBody?.isDynamic = false
        
        sceneBackground.addChild(fallingItem)
        
        fallingItem.position = startingPoint(node: fallingItem)
    }
    
    func startingPoint(node: SKSpriteNode) -> CGPoint {
        var startingPoint = CGPoint(x: 0, y: 0)
        let randomValue = arc4random_uniform(UInt32(self.size.width))
        
        if randomValue < UInt32(node.frame.width) {
            startingPoint = CGPoint(x: node.frame.width / 2, y: 0)
        } else if randomValue + UInt32(node.frame.width) > UInt32(size.width) {
            startingPoint = CGPoint(x: size.width - (node.frame.width / 2), y: 0)
        } else {
            startingPoint = CGPoint(x: Int(randomValue), y: 0)
        }
        return startingPoint
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

                if zombie.frame.intersects(self.boy.frame) {

                    print("You hit a boy")
                }

        }
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
        let maxNode = nodes.reduce(nodes[0]) { $0.frame.width > $1.frame.width ? $0 : $1 }
        
        gamePointsDelegate?.gamePoints(value: Int(maxNode.frame.size.width))
        maxNode.removeFromParent()
    }
}
