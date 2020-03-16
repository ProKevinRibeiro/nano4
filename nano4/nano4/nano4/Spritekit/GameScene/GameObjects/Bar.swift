//
//  Lifes.swift
//  SpriteKitWshop
//
//  Created by Kevin Ribeiro on 05/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
import SpriteKit

class Bar: GameObject {
    
    override func update(_ deltaTime: CGFloat) {
        
    let dY = deltaTime * 200
        
    self.node.position.y -= dY
    }
    
    override func configurePhysics() {
        
        if let body = self.node.physicsBody {
            
            //body.categoryBitMask = UInt32(ContactMask.bar.rawValue)
            //body.contactTestBitMask = UInt32(ContactMask.player.rawValue)
            body.collisionBitMask = 0
        }
    }
}
