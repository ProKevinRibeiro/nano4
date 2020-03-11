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
            
            let  possibleSpawnIntervals: [CGFloat] = [self.barNode.frame.size.height/200,
                                                      2*self.barNode.frame.size.height/200,
                                                      3*self.barNode.frame.size.height/200]
            
            self.spawnCountdown += TimeInterval(possibleSpawnIntervals.randomElement()!)
        }
        
        self.bars.forEach { ($0.update(deltaTime)) }
        
        self.clearBars()
    }
    
    func spawn() {
        
        for _ in 0..<Int.random(in: 1...2) {
            let newBar = self.getNewBar()
        
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
