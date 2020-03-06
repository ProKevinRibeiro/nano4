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

    
    var selfTime: TimeInterval = TimeInterval(0)
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
    }
    
    override func sceneDidLoad() {
        let playerNode = self.childNode(withName: "player") as! SKSpriteNode
        
        self.player = Player(scene: self, node: playerNode)
        
        self.blockSpawner = BlockSpawner(self)
    
    }

     override func update(_ currentTime: TimeInterval) {
        if selfTime == 0 {
            selfTime = currentTime
            return
        }
        
        let deltaTime = currentTime - selfTime
        
        selfTime = currentTime
        
        updatePosition(deltaTime: CGFloat(deltaTime))

     }
    
    func updatePosition(deltaTime: CGFloat) {
        self.player.update(deltaTime)
        self.blockSpawner.update(deltaTime)
    }
    
    // MARK: - ContactDelegate
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
    
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
    
    }
