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
            
            let screenWidth = self.scene.size.height
            
            let  possibleSpawnIntervals: [CGFloat] = [(screenWidth/10)/200,
                                                      2*(screenWidth/10)/200,
                                                      3*(screenWidth/10)/200]
            
            self.spawnCountdown += TimeInterval(possibleSpawnIntervals.randomElement()!)
        }
        
        self.lifes.forEach { ($0.update(deltaTime)) }
        
        self.clearLifes()
    }
    
    func spawn() {
        let newLife = self.getNewLife()
        
        for block in self.scene.blockSpawner.blocks {
            
            if newLife.node.position.x <= block.node.position.x + block.node.frame.size.width/2 {
                
                if newLife.node.position.x >= block.node.position.x - block.node.frame.size.width/2 {
                    
                    if newLife.node.position.y <= block.node.position.y + block.node.frame.size.height/2 {
                        
                        if newLife.node.position.y >= block.node.position.y - block.node.frame.size.height/2 {
                            
                            return
                        }
                    }
                }
            }
            
        }
        
        
        self.lifes.append(newLife)
        self.scene.addChild(newLife.node)
    }
    
    func getNewLife() -> Lifes {
        
        let lifeNode = (self.scene.childNode(withName: "life")!.copy() as! SKNode)
        
        for child in lifeNode.children {
            guard let childNode = child as? SKLabelNode else { continue }
            if childNode.name == "lifeLabel" {
                childNode.text = String(Int.random(in: 1...5))
            }
        }
        
        let screenWidth = self.scene.size.width
        
        let spawnPoint: [CGPoint] = [CGPoint(x: (-2*self.scene.size.width/5), y: self.scene.size.height/2 + screenWidth/11.5),
                                     CGPoint(x: (-self.scene.size.width/5), y: self.scene.size.height/2 + screenWidth/11.5),
                                     CGPoint(x: 0, y: self.scene.size.height/2 + screenWidth/11.5),
                                     CGPoint(x: (self.scene.size.width/5), y: self.scene.size.height/2 + screenWidth/11.5),
                                     CGPoint(x: (2*self.scene.size.width/5), y: self.scene.size.height/2 + screenWidth/11.5)]
        
        lifeNode.position = spawnPoint.randomElement()!
        
        return Lifes(scene: self.scene, node: lifeNode)
    }
    
    func clearLifes() {
        for (life) in self.lifes {
            if life.node.position.y < -self.scene.size.height/2-life.node.frame.size.height {
                life.node.removeFromParent()
                
            }
        }
        
        self.lifes = self.lifes.filter { $0.node.parent != nil }
        
        
    }
    
    func removeLife(_ life: Lifes) {
        
        life.node.removeFromParent()
        self.lifes = self.lifes.filter { $0.node.parent != nil }    }
    
}
