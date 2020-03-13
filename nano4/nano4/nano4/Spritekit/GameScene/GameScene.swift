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
    
    var points: SKLabelNode!
    
    
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
    
        points = (self.childNode(withName: "points") as! SKLabelNode)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if selfTime == 0 {
            selfTime = currentTime
            return
        }
        
        let deltaTime = currentTime - selfTime
        
        selfTime = currentTime
        
        guard deltaTime < 0.1 else  { return } // Nao atualiza se o deltaTime for grande
        
        
        
        self.player.update(CGFloat(deltaTime))
        
        if !self.stopPositionUpdating {
            updatePosition(deltaTime: CGFloat(deltaTime))
        }
        
    }
    
    func updatePosition(deltaTime: CGFloat) {
        self.blockSpawner.update(deltaTime)
        self.lifeSpawner.update(deltaTime)
        self.barSpawner.update(deltaTime)
    }
    
    // MARK: - ContactDelegate
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        guard nodeA.name == "player" || nodeB.name == "player" else { return }
        
        if nodeA.name == "player" {
            stopPositionUpdating(stop: true)
            self.playerCollisionStarted(playerNode: nodeA, other: nodeB)
        } else if nodeB.name == "player" {
            stopPositionUpdating(stop: true)
            self.playerCollisionStarted(playerNode: nodeB, other: nodeA)
        }
        else {
            stopPositionUpdating(stop: false)
        }
        
    }
    
    
    
    func playerCollisionStarted(playerNode: SKNode, other: SKNode) {
        
        if other.name!.contains("block")  {
            if let block = self.blockSpawner.blocks.filter({ (b) -> Bool in
                b.node == other
            }).first {
                block.onCollision()
            }
        } else if other.name!.contains("life")  {
            
            if let life = self.lifeSpawner.lifes.filter({ (b) -> Bool in
                b.node == other
            }).first {
                let lifes = life.getLifeCount()
                self.lifeSpawner.removeLife(life)
                stopPositionUpdating(stop: false)
                self.player.onLifeAdded(lifes)
            }
        }
        
    }
    func didEnd(_ contact: SKPhysicsContact) {
        
        for n in 0..<self.blockSpawner.blocks.count {
            self.blockSpawner.blocks[n].node.removeAllActions()
        }
        stopPositionUpdating(stop: false)
        
    }
    
    func stopPositionUpdating(stop: Bool){
        self.stopPositionUpdating = stop
        return
    }
    
    func endGame() {
    //chamar a tela de endgame
        self.points.text = "0"
        self.player.lifes = 10
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
