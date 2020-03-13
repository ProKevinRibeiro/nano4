//
//  BlockSpawner.swift
//  SpriteKitWshop
//
//  Created by Kevin Ribeiro on 05/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
import SpriteKit

class BarSpawner: Spawner {
    
    var spawnCountdown: TimeInterval = TimeInterval(0)
    var scene: GameScene!
    var bars: [Bar]! = []
    let barNode: SKNode!
    
    init(_ gameScene: GameScene) {
        self.scene = gameScene
        barNode = (scene.childNode(withName: "bar")!.copy() as! SKNode)
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
        
        self.bars.forEach { ($0.update(deltaTime)) }
        
        self.clearBars()
    }
    
    func spawn() {
        
        for _ in 0..<Int.random(in: 1...2) {
            let newBar = self.getNewBar()
            
            for block in self.scene.blockSpawner.blocks {
                
                let screenWidht = self.scene.size.width
                
                let barPosY = newBar.node.position.y
                let blockPosY = block.node.position.y
                let barBeta = barPosY + newBar.node.frame.size.width/2
                let blockBeta = blockPosY - block.node.frame.size.height/2
                
                if barBeta > blockBeta {
                    
                    if (barPosY - newBar.node.frame.size.width/2) < (blockPosY + block.node.frame.size.height/2) {
                        
                        if newBar.node.position.x - screenWidht/10 - 10 < block.node.position.x{
                            
                            return
                        }
                    }
                }
            }
            
            self.bars.append(newBar)
            self.scene.addChild(newBar.node)
        }
    }
    
    func getNewBar() -> Bar {
        
        let barNode = (self.scene.childNode(withName: "bar")!.copy() as! SKNode)
        
        let barNodeHalfHeight = barNode.frame.size.height/2
        
        let spawnPoint: [CGPoint] = [CGPoint(x: (-2*self.scene.size.width/5 + barNodeHalfHeight), y: self.scene.size.height/2 + barNodeHalfHeight),
                                     CGPoint(x: (-self.scene.size.width/5 + barNodeHalfHeight), y: self.scene.size.height/2 + barNodeHalfHeight),
                                     CGPoint(x: (self.scene.size.width/5 - barNodeHalfHeight), y: self.scene.size.height/2 + barNodeHalfHeight),
                                     CGPoint(x: (2*self.scene.size.width/5 - barNodeHalfHeight), y: self.scene.size.height/2 + barNodeHalfHeight)]
        
        barNode.position = spawnPoint.randomElement()!
        
        return Bar(scene: self.scene, node: barNode)
    }
    
    func clearBars() {
        for ( bar) in self.bars {
            if bar.node.position.y < -self.scene.size.height/2 - bar.node.frame.size.height {
                bar.node.removeFromParent()
            }
        }
        
        self.bars = self.bars.filter { $0.node.parent != nil }
    }
    
}
