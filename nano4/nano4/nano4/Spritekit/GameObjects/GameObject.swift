//
//  GameObject.swift
//  SpriteKitWshop
//
//  Created by Kevin Ribeiro on 05/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
import SpriteKit

protocol Updateble {
    func update(_ deltaTime: CGFloat)
}

class GameObject: Updateble{
    
    var scene: GameScene!
    var node: SKNode!
    
    internal init(scene: GameScene?, node: SKNode?) {
        self.scene = scene
        self.node = node
        
        self.configurePhysics()
    }
    
    deinit {
        self.node.removeFromParent()
    }
    
    func update(_ deltaTime: CGFloat) {
        
    }
    
    func configurePhysics() {
        
    }
    
}
