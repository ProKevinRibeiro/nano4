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
    
    private static var privateShared : Model?
    
    var scene: GameScene
    
    class func shared() -> Model {
        guard let unShared = privateShared else {
            privateShared = Model()
            return privateShared!
        }
        return unShared
    }

    class func destroy() {
        privateShared = nil
    }

    private init() {
        scene = GameScene(fileNamed: "GameScene.sks")!
    }

    deinit {

    }
}
