//
//  GameScene.swift
//  nano4
//
//  Created by Kevin Ribeiro on 03/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player = [SKSpriteNode]()
    
    var loopCount: Int = 0
    
    override func didMove(to view: SKView) {
        
//        self.scaleMode = .resizeFill
        
        createPlayer()
        createBlocks()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func createPlayer() {
        
        
        let playerHeadTexture = SKTexture(imageNamed: "snakeHead")
        let action = SKAction.setTexture(playerHeadTexture, resize: true)
        
        player.append(SKSpriteNode(texture: playerHeadTexture))
        
        //
        player[0].size = CGSize(width: 30, height: 30)
        //
        
        player[0].run(action)
        
        player[0].zPosition = 10
        player[0].position = CGPoint(x: frame.width / 2, y: frame.height / 3)
        
        player[0].anchorPoint = CGPoint(x: 0.5, y: 1)
        
        addChild(player[0])
        
    }
    
    func createBlocks() {
        
        if loopCount != 10 {
            
            loopCount += 1
            
            let numberOfBlocks = Int.random(in: 0 ..< 5)
            
            let blocksXPositions = [frame.width/5,(2*frame.width)/5,(3*frame.width)/5,(4*frame.width)/5,frame.width]
            
            var blocks = [SKSpriteNode]()
            
            for _ in 0..<5 {
                blocks.append(SKSpriteNode(texture: SKTexture(imageNamed: "blockTexture")))
            }
            
            let blocksMinDistance = blocks[0].size.height
            
            for n in 0..<numberOfBlocks {
                
                //
                blocks[n].size = CGSize(width: 30, height: 30)
                //
                
                blocks[n].texture = SKTexture(imageNamed: "blockTexture")
                
                var blockXPosition = blocksXPositions.randomElement()!
                
                while (blockXPosition == blocks[0].position.x ||
                    blockXPosition == blocks[1].position.x ||
                    blockXPosition == blocks[2].position.x ||
                    blockXPosition == blocks[3].position.x) {
                        
                        blockXPosition = blocksXPositions.randomElement()!
                }
                
                blocks[n].position = CGPoint(x: blockXPosition, y: frame.height + blocksMinDistance)
                
                addChild(blocks[n])
                

                let moveAction = SKAction.move(to: CGPoint(x: blockXPosition, y: CGFloat(0)), duration: 6.0)
                let moveSequence = SKAction.sequence([moveAction, SKAction.removeFromParent()])
                blocks[n].run(moveSequence)
            }
        }
        else{
            
            createLineOfBlocks()
            
            loopCount = 0
        }
        
    }
    
    func createLineOfBlocks() {
        
        let blocksXPositions = [frame.width/5,(2*frame.width)/5,(3*frame.width)/5,(4*frame.width)/5,frame.width]
        
        var blocks = [SKSpriteNode]()
        
        for _ in 0..<5 {
            blocks.append(SKSpriteNode(texture: SKTexture(imageNamed: "blockTexture")))
        }
        
        let blocksMinDistance = blocks[0].size.height
        
        for n in 0..<5 {
            
            //
            blocks[n].size = CGSize(width: 30, height: 30)
            //
            
            blocks[n].texture = SKTexture(imageNamed: "blockTexture")
            
            let blockXPosition = blocksXPositions[n]
            
            blocks[n].position = CGPoint(x: blockXPosition, y: frame.width + blocksMinDistance)
            
            addChild(blocks[n])
            
                            let moveAction = SKAction.move(to: CGPoint(x: blockXPosition, y: CGFloat(0)), duration: 6.0)
            let moveSequence = SKAction.sequence([moveAction, SKAction.removeFromParent()])
            blocks[n].run(moveSequence)
        }
    }
}
