//
//  Scene.swift
//  BombSquash
//
//  Created by Jason Villegas on 10/16/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import Foundation

import SpriteKit
import CoreMotion

protocol ScoredPointsDelegate {
    func gamePoints(value: Int, healthPadHit: Bool)
}

class StayAlive: SKScene, SKPhysicsContactDelegate {
    
    var gamePointsDelegate: ScoredPointsDelegate?
    
    var sceneBackground: SKSpriteNode!
    var lastUpdateTime: TimeInterval = 0

    var gameSpeed: CGFloat = 10.0
    var zombieCounter = 0
    
    let boy = SKSpriteNode(imageNamed: "boy")
    let boyMovePtsPerSec: CGFloat = 450.0
    var velociyOfBoy = CGPoint.zero
    
    let healthPad = SKSpriteNode(color: UIColor.red, size: CGSize(width: 80, height: 10))

    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
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

        physicsWorld.contactDelegate = self
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
       
        setupAccelerometerSpeed()
        
        addBoy()
        addHealthPad()
        
    }

    override func update(_ currentTime: CFTimeInterval) {

        if lastUpdateTime > 0 {
            if currentTime - lastUpdateTime > 1 {
                addZombie()
                lastUpdateTime = currentTime
            }
        } else {
            lastUpdateTime = currentTime
        }

        dropZombie()
        removeZombie()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //TODO: Need to deal with health loss when boy and zombie collide
        
        var firstBody: SKPhysicsBody
        
        if (contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2) || (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1) {
            //This is the HealthPad and Boy make contact
            gamePointsDelegate?.gamePoints(value: 10, healthPadHit: true)

        } else if (contact.bodyA.categoryBitMask == 5 && contact.bodyB.categoryBitMask == 2) || (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 5) {
            //This is the zombie and boy make contact
            firstBody = (contact.bodyA.node?.name == "zombie") ? contact.bodyA : contact.bodyB
            
            guard let zombieFrame = firstBody.node else { return }
            gamePointsDelegate?.gamePoints(value: Int(zombieFrame.frame.size.width), healthPadHit: false)

        }

    }
    
    
    //Need to tweak this to work better with the acceleromter
    override func didSimulatePhysics() {
        healthPad.position.x += xAcceleration * 30
        
        if healthPad.position.x < (self.size.width - 10) {
            healthPad.position = CGPoint(x: healthPad.position.x + 10, y: healthPad.position.y)
        } else if healthPad.position.x > (self.size.width + 10) {
            healthPad.position = CGPoint(x: healthPad.position.x - 10, y: healthPad.position.y)
        }
    }
    
    func setupAccelerometerSpeed() {
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data: CMAccelerometerData?, error: Error?) in
            if let accelerometerData = data {
                
                let acceleration = accelerometerData.acceleration
                print("Accel: " , acceleration.x)
                self.xAcceleration = CGFloat(acceleration.x) * 0.5 + self.xAcceleration * 0.4
            }
        }
    }
    
    func addHealthPad() {
        
        healthPad.name = "healthPad"
        healthPad.position = CGPoint(x: (size.width / 2), y: (((-1) * size.height) + 10))
        healthPad.physicsBody = SKPhysicsBody(rectangleOf: healthPad.size)
        addChild(healthPad)
        healthPad.physicsBody?.isDynamic = false
        healthPad.physicsBody?.friction = 0
        healthPad.physicsBody?.restitution = 1

        healthPad.physicsBody?.categoryBitMask = 1
        healthPad.physicsBody?.collisionBitMask = 2
        healthPad.physicsBody?.contactTestBitMask = 2
    }
    
    func addBoy() {
        
        boy.name = "boy"
        boy.size = CGSize(width: 30, height: 30)
        boy.position = CGPoint(x: boy.size.width, y: (-1) * boy.size.height + 10)
        boy.physicsBody = SKPhysicsBody(circleOfRadius: boy.size.width / 2)
        addChild(boy)
        
        boy.physicsBody?.applyImpulse(CGVector(dx: 3 , dy: -3))
        boy.physicsBody?.isDynamic = true
        boy.physicsBody?.friction = 0
        boy.physicsBody?.restitution = 1
        boy.physicsBody?.linearDamping = 0
        
        boy.physicsBody?.categoryBitMask = 2
        boy.physicsBody?.collisionBitMask = 1
        boy.physicsBody?.contactTestBitMask = 1

    }

    func addZombie() {

        var zombie = SKSpriteNode()

        zombie = SKSpriteNode(imageNamed: "zombie")
        zombie.name = "zombie"
        let sizeOfItem = CGFloat(arc4random_uniform(91) + 20)
        zombie.size = CGSize(width: sizeOfItem, height: sizeOfItem)
        zombie.physicsBody = SKPhysicsBody(rectangleOf: zombie.size)
        zombie.physicsBody?.isDynamic = false
        zombie.physicsBody?.friction = 0
        zombie.physicsBody?.restitution = 0
        
        zombie.physicsBody?.categoryBitMask = 5
        zombie.physicsBody?.collisionBitMask = 2
        zombie.physicsBody?.contactTestBitMask = 2
        
        sceneBackground.addChild(zombie)
        
        zombie.position = zombieStartingPoint(node: zombie)
    }
    
    func zombieStartingPoint(node: SKSpriteNode) -> CGPoint {
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
    
    func dropZombie() {
        for child in sceneBackground.children {
            let xOffset: CGFloat = 0
            let yOffset: CGFloat = gameSpeed
            let newLocation = CGPoint(x: child.position.x + xOffset, y: child.position.y - yOffset)
            let moveAction = SKAction.move(to: newLocation, duration: 1)
            child.run(moveAction)
        }
    }
    
    func removeZombie() {
        for child in sceneBackground.children {
            if child.position.y < (-1)*size.height {
                child.removeFromParent()
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
        maxNode.removeFromParent()
    }
}
