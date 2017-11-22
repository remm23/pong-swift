//
//  GameScene.swift
//  Pong
//
//  Created by Remi Tobias on 22/11/2017.
//  Copyright © 2017 Remi Tobias. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var ai = SKSpriteNode()
    var player = SKSpriteNode()
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        ai = self.childNode(withName: "ai") as! SKSpriteNode
        player = self.childNode(withName: "player") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 50,dy: 50))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
    }
    
    func startGame() {
        score = [0,0]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        ai.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
    }
}
