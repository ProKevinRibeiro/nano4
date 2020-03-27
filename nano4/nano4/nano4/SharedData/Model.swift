//
//  Model.swift
//  nano4
//
//  Created by Mariana Lech on 10/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import Foundation
import SpriteKit

class Model{
    
    static var shared = Model()
    
    var scene: GameScene!
    var gameVc: GameViewController!

    private init() {
        //load()
    }
    
    func load() {
        if scene != nil {
            scene = nil
        }
        
        scene = GameScene(fileNamed: "GameScene.sks")!
        
        scene.scaleMode = .aspectFill
        
        if gameVc != nil {
            gameVc.load()
        }
    }

    deinit {

    }
}
