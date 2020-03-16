//
//  TailNode.swift
//  nano4
//
//  Created by Mariana Lech on 11/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import SpriteKit

class Tail: GameObject {
    
    var nextTail: Tail?
    
    override func update(_ deltaTime: CGFloat) {
        
        if let nextTail = self.nextTail, let myNode = self.node as? SKSpriteNode {
            
            let myNodePos = myNode.position
            let nextNodePos = nextTail.node.position
            
            
            if abs(myNodePos.x - nextNodePos.x) > myNode.size.width / 2 {

                let pos = CGPoint(x: myNodePos.x, y: nextNodePos.y)
                
                let animation = SKAction.move(to: pos, duration: 0.3)
            
               
                nextTail.node.run(animation)
            }
        }
    }
    
}


extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let x2 = (point.x - x) * (point.x - x)
        let y2 = (point.y - y) * (point.y - y)
        return sqrt( x2 + y2)
    }
}
