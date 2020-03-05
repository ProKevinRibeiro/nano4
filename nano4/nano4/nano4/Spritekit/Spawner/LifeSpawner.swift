//
//  lifeSpawner.swift
//  SpriteKitWshop
//
//  Created by Kevin Ribeiro on 05/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
import SpriteKit

class lifeSpawner: Spawner {
    
    var spawnCountdown: TimeInterval = TimeInterval(0)
    var scene: GameScene!
    var blocks: [Block]! = []
    
    init(_ gameScene: GameScene) {
        self.scene = gameScene
    }
    
    override func update(_ deltaTime: CGFloat) {
        
        self.spawnCountdown -= TimeInterval(deltaTime)
        
        if spawnCountdown <= 0 {
            self.spawn()
            self.spawnCountdown = TimeInterval(Int.random(in: 2...4))
        }
        
        self.blocks.forEach { ($0.update(deltaTime)) }
        
        self.clearBlocks()
    }
    
    func spawn() {
        let newBlock = self.getNewBlock()
        
        self.blocks.append(newBlock)
        self.scene.addChild(newBlock.node)
    }
    
    func getNewBlock() -> Block {
        let blockNode = self.scene.childNode(withName: "block")!.copy() as! SKNode
        
            let spawnPoint: [CGPoint] = [CGPoint(x: (self.scene.size.width/5)/2, y: self.scene.size.height),
                                         CGPoint(x: 2*(self.scene.size.width/5)/2, y: self.scene.size.height),
                                         CGPoint(x: 3*(self.scene.size.width/5)/2, y: self.scene.size.height),
                                         CGPoint(x: 4*(self.scene.size.width/5)/2, y: self.scene.size.height),
                                         CGPoint(x: 5*(self.scene.size.width/5)/2, y: self.scene.size.height)]
        
        blockNode.position = spawnPoint.randomElement()!
        
        return Block(scene: self.scene, node: blockNode)
    }
    
    func clearBlocks() {
        for (n, block) in self.blocks.enumerated() {
            if block.node.position.y < -self.scene.size.height/2 {
                block.node.removeFromParent()
                self.blocks.remove(at: n)
            }
        }
    }
    
}
