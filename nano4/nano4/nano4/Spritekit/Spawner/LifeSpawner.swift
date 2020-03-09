//
//  BlockSpawner.swift
//  SpriteKitWshop
//
//  Created by Kevin Ribeiro on 05/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
import SpriteKit

class LifeSpawner: Spawner {
    
    var spawnCountdown: TimeInterval = TimeInterval(0)
    var scene: GameScene!
    var lifes: [Lifes]! = []
    let lifeNode: SKNode!
    
    init(_ gameScene: GameScene) {
        self.scene = gameScene
        lifeNode = (scene.childNode(withName: "life")!.copy() as! SKNode)
    }
    
    override func update(_ deltaTime: CGFloat) {
        
        self.spawnCountdown -= TimeInterval(deltaTime)
        
        if spawnCountdown <= 0 {
            
            
            self.spawn()
            
            let  possibleSpawnIntervals: [CGFloat] = [self.lifeNode.frame.size.height/200,
                                                      2*self.lifeNode.frame.size.height/200,
                                                      3*self.lifeNode.frame.size.height/200]
            
            self.spawnCountdown += TimeInterval(possibleSpawnIntervals.randomElement()!)
        }
        
        self.lifes.forEach { ($0.update(deltaTime)) }
        
        self.clearLifes()
    }
    
    func spawn() {
        let newLife = self.getNewLife()
        
        self.lifes.append(newLife)
        self.scene.addChild(newLife.node)
    }
    
    func getNewLife() -> Lifes {
        
        let lifeNode = (self.scene.childNode(withName: "life")!.copy() as! SKNode)
        
        let lifeNodeHalfHeight = lifeNode.frame.size.height/2
        
        let spawnPoint: [CGPoint] = [CGPoint(x: (-2*self.scene.size.width/5), y: self.scene.size.height/2 + lifeNodeHalfHeight),
                                     CGPoint(x: (-self.scene.size.width/5), y: self.scene.size.height/2 + lifeNodeHalfHeight),
                                     CGPoint(x: 0, y: self.scene.size.height/2 + lifeNodeHalfHeight),
                                     CGPoint(x: (self.scene.size.width/5), y: self.scene.size.height/2 + lifeNodeHalfHeight),
                                     CGPoint(x: (2*self.scene.size.width/5), y: self.scene.size.height/2 + lifeNodeHalfHeight)]
        
        lifeNode.position = spawnPoint.randomElement()!
        
        return Lifes(scene: self.scene, node: lifeNode)
    }
    
    func clearLifes() {
        for (n, life) in self.lifes.enumerated() {
            if life.node.position.y < -self.scene.size.height/2-life.node.frame.size.height {
                life.node.removeFromParent()
                self.lifes.remove(at: n)
            }
        }
    }
    
}
