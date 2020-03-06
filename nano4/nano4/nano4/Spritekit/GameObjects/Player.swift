//
//  Player.swift
//  SpriteKitWshop
//
//  Created by Kevin Ribeiro on 05/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
import SpriteKit

class Player: GameObject{

//    override func update(_ deltaTime: CGFloat) {
//        
//        let dX = deltaTime * 100
//        
//        self.node.position.x += dX
//    }
    
    override func configurePhysics() {
        
        if let body = self.node.physicsBody {
            
            body.categoryBitMask = UInt32(ContactMask.player.rawValue)
            body.contactTestBitMask = UInt32(ContactMask.block.rawValue)
            body.collisionBitMask = 0
        }
    }
}
