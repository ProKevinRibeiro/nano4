//
//  Lifes.swift
//  SpriteKitWshop
//
//  Created by Kevin Ribeiro on 05/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
import SpriteKit

class Lifes: GameObject {
    
    let lifeCount: Int = Int.random(in: 1...5)
    
    override func update(_ deltaTime: CGFloat) {
        
    let dY = deltaTime * 200
        
    self.node.position.y -= dY
    }
    
    override func configurePhysics() {
        
        if let body = self.node.physicsBody {
            
            body.categoryBitMask = UInt32(ContactMask.life.rawValue)
            body.contactTestBitMask = UInt32(ContactMask.player.rawValue) | UInt32(ContactMask.block.rawValue)
            body.collisionBitMask = 0
        }
    }
}
