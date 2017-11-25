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
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
    let ballSpeed = 50
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        ai = self.childNode(withName: "ai") as! SKSpriteNode
        player = self.childNode(withName: "player") as! SKSpriteNode
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode

        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
        ai.position.y = (self.frame.height / 2) - 50
        player.position.y = (-self.frame.height / 2) + 50
        
        if view.bounds.size.width > 375.0 && view.bounds.size.height > 667.0 {
            // applied if device is an ipad
            player.size.width = 150;
            ai.size.width = 150
        }
        
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: ballSpeed,dy: ballSpeed))
    }
    
    func addScore(winner: SKSpriteNode) {
        // reset ball and impluse
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if winner == player {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -ballSpeed,dy: -ballSpeed))
        }else if winner == ai {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: ballSpeed,dy: ballSpeed))
        }
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if currentGameType == .twoPlayer {
                if location.y > 0 {
                    ai.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    player.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                player.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if currentGameType == .twoPlayer {
                if location.y > 0 {
                    ai.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    player.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                player.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        switch currentGameType {
        case .easy:
            ai.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
            break
        case .medium:
            ai.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
        case .hard:
            ai.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        case .twoPlayer:
            break
        }
        if ball.position.y <= player.position.y - 30 {
            addScore(winner: ai)
        } else if ball.position.y >= ai.position.y + 30 {
            addScore(winner: player)
        }
        
    }
}
