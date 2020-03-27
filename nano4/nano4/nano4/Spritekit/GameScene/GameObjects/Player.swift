//
//  Player.swift
//  SpriteKitWshop
//
//  Created by Kevin Ribeiro on 05/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class Player: GameObject{
    
    var lifes: Int = 10 // Starting value for lifes
    var tails = [Tail]()
    var lifeSoundEffect: AVAudioPlayer?
    
    override init(scene: GameScene?, node: SKNode?) {
        super.init(scene: scene, node: node)
        
        self.configureTail()
    }
    
    func configureTail() {
        for _ in 1..<self.lifes {
            self.addTail()
        }
    }
    
    func onLifeAdded(_ amount: Int) {
        self.lifes += amount
        
        self.getLifesNode().text = "\(self.lifes)"
        
        for _ in 1...amount {
            self.addTail()
        }
        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator.impactOccurred()
        
        let path = Bundle.main.path(forResource: "vida1.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            lifeSoundEffect = try AVAudioPlayer(contentsOf: url)
            lifeSoundEffect?.play()
        } catch {
            // couldn't load file :(
        }
        
    }
    
    override func configurePhysics() {
        
        if let body = self.node.physicsBody {
            
            body.categoryBitMask = UInt32(ContactMask.player.rawValue)
            body.contactTestBitMask = UInt32(ContactMask.block.rawValue)
            body.collisionBitMask = 0
        }
    }
    
    
    
    override func update(_ deltaTime: CGFloat) {
        //self.getLifesNode().text = "\(self.lifes)"
        
        self.tails.forEach { $0.update(deltaTime) }
        
        if let firstTail = self.tails.first {
            if abs(self.node.position.x - firstTail.node.position.x) > 40 {
                
                let pos = CGPoint(x: self.node.position.x, y: firstTail.node.position.y)
                
                let animation = SKAction.move(to: pos, duration: 0.3)
                
                
                firstTail.node.run(animation)
            }
        }
    }
    
    func onLifeTaken() {
        if !self.scene.isGameOver {
            
            self.lifes -= 1
            
            let points = Int(self.scene.points.text!)! + 1
            self.scene.points.text = String(points)
            self.scene.onChangePoint(points)
            
            self.getLifesNode().text = "\(self.lifes)"
            
            if self.lifes == 0 {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                self.scene.player.node.removeFromParent()
                self.scene.endGame()
                print("chamou a ende game")
            }
            if self.tails.count <= 10 {
                if let lastTail = self.tails.last {
                    lastTail.node.removeFromParent()
                    self.tails.removeLast(1)
                }
            }
        }
        
    }
    
    func moveToLeft() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
        feedbackGenerator.impactOccurred()
        
        let screenWidht = self.scene.frame.size.width
        
        let comparableSize = (-1*(screenWidht/2) + screenWidht/10)
        
        if (self.node.position.x + 0.1 > comparableSize) && (self.node.position.x - 0.1 < comparableSize) {
            
            for block in self.scene.blockSpawner.blocks {
                
                if (self.node.position.y + self.node.frame.size.height/2) >
                    (block.node.position.y - block.node.frame.height/2)
                    && (self.node.position.y - self.node.frame.size.height/2) <
                    (block.node.position.y + block.node.frame.height/2)   {
                    
                    if (self.node.position.x + block.node.position.x <= 10
                        && self.node.position.x + block.node.position.x >= -10) {
                        return
                    }
                }
            }
            
            self.node.position.x = screenWidht/2 - screenWidht/10
        }
        else {
            
            for block in self.scene.blockSpawner.blocks {
                
                if (self.node.position.y + self.node.frame.size.height/2) >
                    (block.node.position.y - block.node.frame.height/2)
                    && (self.node.position.y - self.node.frame.size.height/2) <
                    (block.node.position.y + block.node.frame.height/2)   {
                    
                    if (self.node.position.x - block.node.position.x <= self.scene.frame.size.width/5 + 10
                        && self.node.position.x - block.node.position.x >= self.scene.frame.size.width/5 - 10) {
                        
                        if self.node.position.x < 0 {
                            return
                        }
                    }
                }
            }
            
            let pos = self.scene.frame.size.width/5.0
            
            self.node.position.x =  self.node.position.x - pos
        }
        
    }
    
    func moveToRight() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
        feedbackGenerator.impactOccurred()
        
        let screenWidht = self.scene.frame.size.width
        
        let comparableSize = ((screenWidht/2) - screenWidht/10)
        
        if (self.node.position.x + 0.1 > comparableSize) && (self.node.position.x - 0.1 < comparableSize) {
            
            for block in self.scene.blockSpawner.blocks {
                
                if (self.node.position.y + self.node.frame.size.height/2) >
                    (block.node.position.y - block.node.frame.height/2)
                    && (self.node.position.y - self.node.frame.size.height/2) <
                    (block.node.position.y + block.node.frame.height/2)   {
                    
                    if (self.node.position.x + block.node.position.x <= 10
                        && self.node.position.x + block.node.position.x >= -10) {
                        
                        if self.node.position.x > 0 {
                            return
                        }
                    }
                }
            }
            
            self.node.position.x = -1*(screenWidht/2) + screenWidht/10
        }
        else {
            
            for block in self.scene.blockSpawner.blocks {
                
                if (self.node.position.y + self.node.frame.size.height/2) >
                    (block.node.position.y - block.node.frame.height/2)
                    && (self.node.position.y - self.node.frame.size.height/2) <
                    (block.node.position.y + block.node.frame.height/2)   {
                    
                    if (self.node.position.x - block.node.position.x <= -(self.scene.frame.size.width/5 - 10)
                        && (self.node.position.x - block.node.position.x) >= -((self.scene.frame.size.width/CGFloat(5)) + CGFloat(10))) {
                        return
                    }
                }
            }
            
            let pos = self.scene.frame.size.width/5.0
            
            self.node.position.x =  self.node.position.x + pos
        }
    }
    
    func getLifesNode() -> SKLabelNode {
        return self.node.childNode(withName: "lifes") as! SKLabelNode
    }
    
    func addTail() {
        if self.tails.count <= 10 {
            
            let tailNode = self.getTailNode()
            let newTail = Tail(scene: self.scene, node: tailNode)
            
            let tailYOffset = tailNode.size.height * CGFloat(self.tails.count) + (self.node as! SKSpriteNode).size.height
            
            tailNode.position = CGPoint(x: self.node.position.x, y: self.node.position.y - tailYOffset)
            
            if let lastTail = self.tails.last {
                lastTail.nextTail = newTail
            }
            
            self.tails.append(newTail)
            self.scene.addChild(tailNode)
            
            
            tailNode.name = "\(self.tails.count)"
        }
    }
    
    func getTailNode() -> SKSpriteNode {
        let node = self.scene.childNode(withName: "tail")!.copy() as! SKSpriteNode
        
        node.removeFromParent()
        
        return node
        
    }
    
    
}
