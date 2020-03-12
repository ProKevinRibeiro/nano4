//
//  Block.swift
//  SpriteKitWshop
//
//  Created by Kevin Ribeiro on 05/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
import SpriteKit

class Block: GameObject {
    
    var lastContactTimer = TimeInterval(0)
    var minContactTimer = TimeInterval(0.2)
    
    override func update(_ deltaTime: CGFloat) {
        self.lastContactTimer += TimeInterval(deltaTime)
        
        let dY = deltaTime * 200
        
        self.node.position.y -= dY

    }
    
    
    override func configurePhysics() {
        
        if let body = self.node.physicsBody {
            
            body.categoryBitMask = UInt32(ContactMask.block.rawValue)
            body.contactTestBitMask = UInt32(ContactMask.player.rawValue) | UInt32(ContactMask.life.rawValue)
            body.collisionBitMask = 0
        }
    }
    
    func getLifeCount() -> Int {
        guard let text = self.getLifeLabel().text else {
            return -1
        }
        
        return Int(text)!
    }
    
    func onCollision() {
        if self.lastContactTimer > self.minContactTimer {
            self.onLifeTaken()
            self.scene.player.onLifeTaken()
            self.lastContactTimer = TimeInterval(0)
        }
    }
    
    func lifeDiscount() {
        var newLife = self.getLifeCount()
        newLife = newLife - 1
        
        self.getLifeLabel().text = (String(newLife))
    }
    
    func onLifeTaken() {
        var action = [SKAction]()
        for n in 1...self.getLifeCount() {
            
            action.append(SKAction.run(self.lifeDiscount))
            action.append(SKAction.run(self.scene.player.onLifeTaken))
            action.append(SKAction.wait(forDuration: (0.2/Double(n)) + 0.03))
            
        }
        
        self.node.run(SKAction.sequence(action)){
            if self.getLifeCount() <= 0{
                self.node.removeFromParent()
                self.scene.stopPositionUpdating(stop: false)
            }
        }
        
    }
    
    func getLifeLabel() -> SKLabelNode {
        self.node.childNode(withName: "blockLabel") as! SKLabelNode
    }
}
