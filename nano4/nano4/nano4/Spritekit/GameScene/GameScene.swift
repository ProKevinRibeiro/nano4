//
//  GameScene.swift
//  SpriteKitWshop
//
//  Created by Bruno Pastre on 05/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: Player!
    var blockSpawner: BlockSpawner!
    var lifeSpawner: LifeSpawner!
    var barSpawner: BarSpawner!
    
    var stopPositionUpdating: Bool = false
    
    var selfTime: TimeInterval = TimeInterval(0)
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
    }
    
    override func sceneDidLoad() {
        let playerNode = self.childNode(withName: "player") as! SKSpriteNode
        
        self.player = Player(scene: self, node: playerNode)
        
        self.blockSpawner = BlockSpawner(self)
        
        self.lifeSpawner = LifeSpawner(self)
        
        self.barSpawner = BarSpawner(self)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if selfTime == 0 {
            selfTime = currentTime
            return
        }
        
        let deltaTime = currentTime - selfTime
        
        selfTime = currentTime
        
        self.player.update(CGFloat(deltaTime))
        
        if !self.stopPositionUpdating {
            updatePosition(deltaTime: CGFloat(deltaTime))
        }
        
    }
    
    func updatePosition(deltaTime: CGFloat) {
        self.lifeSpawner.update(deltaTime)
        self.blockSpawner.update(deltaTime)
        self.barSpawner.update(deltaTime)
    }
    
    // MARK: - ContactDelegate
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "player" || contact.bodyB.node?.name == "player" {
           
            stopPositionUpdating(stop: true)
        
        }
        else {
            
            stopPositionUpdating(stop: false)
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
        stopPositionUpdating(stop: false)
    }
    
    func stopPositionUpdating(stop: Bool){
        self.stopPositionUpdating = stop
        return
    }
    
    
    // MARK: - Touch methods
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    func moveToLeft() {
        
        if self.stopPositionUpdating {
            return
        }
        
        for bar in barSpawner.bars {
            
            if player.node.position.x > bar.node.position.x {
                
                let screenWidht = self.scene!.size.width
                
                if player.node.position.y + player.node.frame.size.width/2 > bar.node.position.y - bar.node.frame.size.height/2 && player.node.position.y - player.node.frame.size.width/2 < bar.node.position.y + bar.node.frame.size.height/2 {
                    
                    if player.node.position.x - screenWidht/10 - 10 < bar.node.position.x{
                        
                        return
                    }
                }
            }
        }
        
        player.moveToLeft()
        
    }
    
    func moveToRight() {
        
        if self.stopPositionUpdating {
            return
        }
        
        for bar in barSpawner.bars {
            
            if player.node.position.x < bar.node.position.x {
                
                let screenWidht = self.scene!.size.width
                
                if player.node.position.y + player.node.frame.size.width/2 > bar.node.position.y - bar.node.frame.size.height/2 && player.node.position.y - player.node.frame.size.width/2 < bar.node.position.y + bar.node.frame.size.height/2 {
                    
                    if player.node.position.x + screenWidht/10 + 10 > bar.node.position.x{
                        
                        return
                    }
                }
            }
        }
        
        player.moveToRight()
    }
    
}
