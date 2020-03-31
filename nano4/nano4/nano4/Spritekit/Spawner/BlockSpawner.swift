//
//  BlockSpawner.swift
//  SpriteKitWshop
//
//  Created by Kevin Ribeiro on 05/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
import SpriteKit

class BlockSpawner: Spawner {
    
    var spawnCountdown: TimeInterval = TimeInterval(0)
    var scene: GameScene!
    var blocks: [Block]! = []
    let blockNode: SKNode!
    var lineSpawnCount: Int = 0
    
    init(_ gameScene: GameScene) {
        self.scene = gameScene
        blockNode = (scene.childNode(withName: "block")!.copy() as! SKNode)
    }
    
    override func update(_ deltaTime: CGFloat) {
        
        var kindOfSpawn: String
        
        self.lineSpawnCount += 1
        
        if lineSpawnCount < 5 {
            kindOfSpawn = "oneBlock"
        }
        else {
            kindOfSpawn = "lineOfBlocks"
            
            self.lineSpawnCount = 0
        }
        
        self.spawnCountdown -= TimeInterval(deltaTime)
        
        if spawnCountdown <= 0 {
            
            self.spawn(kindOfSpawn: kindOfSpawn)
            
            let screenWidth = self.scene.size.height
            
            let  possibleSpawnIntervals: [CGFloat] = [(screenWidth/10)/200,
                                                      2*(screenWidth/10)/200,
                                                      3*(screenWidth/10)/200]
            
            self.spawnCountdown += TimeInterval(possibleSpawnIntervals.randomElement()!)
        }
        
        self.blocks.forEach { ($0.update(deltaTime)) }
        
        self.clearBlocks()
    }
    
    func setAlpha(count: Int) -> CGFloat{
        
        if count <= 50 {
            if count <= 40 {
                if count <= 30 {
                    if count <= 20 {
                        if count <= 10 {
                            return 0.2
                        }
                        else {
                            return 0.4
                        }
                    }
                    else {
                        return 0.6
                    }
                }
                else {
                   return 0.8
                }
            }
            else {
               return 1.0
            }
        }
        else {
            return 1.0
        }
        
    }
    
    func spawn(kindOfSpawn: String) {
        
        if kindOfSpawn == "oneBlock" {
            
            let newBlock = self.getNewBlock()
            
            newBlock.node.alpha = setAlpha(count: newBlock.getLifeCount())
            
            self.blocks.append(newBlock)
            self.scene.addChild(newBlock.node)
        }
        else if kindOfSpawn == "lineOfBlocks"{
            
            let newBlock = self.getNewLineOfBlocks()
            
            for n in 0..<5 {
                
                newBlock[n].node.alpha = setAlpha(count: newBlock[n].getLifeCount())
                
                self.blocks.append(newBlock[n])
                self.scene.addChild(newBlock[n].node)
            }
        }
    }
    
    func getNewBlock() -> Block {
        
        let blockNode = (self.scene.childNode(withName: "block")!.copy() as! SKNode)
        
        
        for child in blockNode.children {
            guard let childNode = child as? SKLabelNode else { continue }
            
            if childNode.text == "block" {
                childNode.text = String(Int.random(in: 1...50))
            }
        }
        
        let blockNodeHalfHeight = blockNode.frame.size.height/2
        
        let spawnPoint: [CGPoint] = [CGPoint(x: (-2*self.scene.size.width/5), y: self.scene.size.height/2 + blockNodeHalfHeight),
                                     CGPoint(x: (-self.scene.size.width/5), y: self.scene.size.height/2 + blockNodeHalfHeight),
                                     CGPoint(x: 0, y: self.scene.size.height/2 + blockNodeHalfHeight),
                                     CGPoint(x: (self.scene.size.width/5), y: self.scene.size.height/2 + blockNodeHalfHeight),
                                     CGPoint(x: (2*self.scene.size.width/5), y: self.scene.size.height/2 + blockNodeHalfHeight)]
        
        blockNode.position = spawnPoint.randomElement()!
        
        return Block(scene: self.scene, node: blockNode)
    }
    
    func getNewLineOfBlocks() -> [Block] {
        
        var blockNode = [(self.scene.childNode(withName: "block")!.copy() as! SKNode),
                         (self.scene.childNode(withName: "block")!.copy() as! SKNode),
                         (self.scene.childNode(withName: "block")!.copy() as! SKNode),
                         (self.scene.childNode(withName: "block")!.copy() as! SKNode),
                         (self.scene.childNode(withName: "block")!.copy() as! SKNode)]
        
        for node in blockNode {
            
            for child in node.children {
                guard let childNode = child as? SKLabelNode else { continue }
                
                if childNode.text == "block" {
                    childNode.text = String(Int.random(in: 1...50))
                }
                if node == blockNode[0] {
                    childNode.text = String(Int.random(in: 1...5))
                }
            }
            
        }
        
        blockNode.shuffle()
        
        let blockNodeHalfHeight = blockNode[0].frame.size.height/2
        
        let spawnPoint: [CGPoint] = [CGPoint(x: (-2*self.scene.size.width/5), y: self.scene.size.height/2 + blockNodeHalfHeight),
                                     CGPoint(x: (-self.scene.size.width/5), y: self.scene.size.height/2 + blockNodeHalfHeight),
                                     CGPoint(x: 0, y: self.scene.size.height/2 + blockNodeHalfHeight),
                                     CGPoint(x: (self.scene.size.width/5), y: self.scene.size.height/2 + blockNodeHalfHeight),
                                     CGPoint(x: (2*self.scene.size.width/5), y: self.scene.size.height/2 + blockNodeHalfHeight)]
        
        for n in 0..<5 {
            blockNode[n].position = spawnPoint[n]
        }
        
        return [Block(scene: self.scene, node: blockNode[0]),
                Block(scene: self.scene, node: blockNode[1]),
                Block(scene: self.scene, node: blockNode[2]),
                Block(scene: self.scene, node: blockNode[3]),
                Block(scene: self.scene, node: blockNode[4])]
    }
    
    func clearBlocks() {
        self.blocks = self.blocks.filter { block in
            block.node.position.y > -(self.scene.size.height/2)-(block.node.frame.size.height)
            
        }
        
    }
    
}
