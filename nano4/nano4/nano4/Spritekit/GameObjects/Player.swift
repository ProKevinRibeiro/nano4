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
    
    override func configurePhysics() {
        
        if let body = self.node.physicsBody {
            
            body.categoryBitMask = UInt32(ContactMask.player.rawValue)
            body.contactTestBitMask = UInt32(ContactMask.block.rawValue)
            body.collisionBitMask = 0
        }
    }
    
    
    func moveToLeft() {
        let screenWidht = self.scene.frame.size.width
        
        let comparableSize = (-1*(screenWidht/2) + screenWidht/10)
        
        if (self.node.position.x + 0.1 > comparableSize) && (self.node.position.x - 0.1 < comparableSize) {
            
            self.node.position.x = screenWidht/2 - screenWidht/10
        }
        else {
            
            let pos = self.scene.frame.size.width/5.0
            
            self.node.position.x =  self.node.position.x - pos
        }
    }
    
    func moveToRight() {
        let screenWidht = self.scene.frame.size.width
        
        let comparableSize = ((screenWidht/2) - screenWidht/10)
        
        if (self.node.position.x + 0.1 > comparableSize) && (self.node.position.x - 0.1 < comparableSize) {
            
            self.node.position.x = -1*(screenWidht/2) + screenWidht/10
        }
        else {
            
            let pos = self.scene.frame.size.width/5.0
            
            self.node.position.x =  self.node.position.x + pos
        }
    }
}
