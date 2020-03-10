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
    
    static let shared = Model()
    
    private init() {
        scene = GameScene(fileNamed: "GameScene.sks")!
    }
    
    var scene:GameScene
}
