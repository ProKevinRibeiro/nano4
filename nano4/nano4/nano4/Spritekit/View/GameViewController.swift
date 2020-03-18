//
//  GameViewController.swift
//  nano4
//
//  Created by Kevin Ribeiro on 03/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import SwiftUI

class GameViewController: UIViewController {
    
    let gameView = SKView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // if let scene = SKScene(fileNamed: "GameScene.sks") {
        
//        Model.shared.scene.scaleMode = .aspectFit
        //view.presentScene(Model.shared.scene)
        Model.shared.gameVc = self
        
        //load()
        
//        gameView.ignoresSiblingOrder = true
//        gameView.showsFPS = true
//        gameView.showsNodeCount = true
//
//        self.view = gameView
       // }
        
        Model.shared.load()
        
        gameView.ignoresSiblingOrder = true
            
        self.view = gameView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("ViewDidAppear")
    }
    
    func load() {
        gameView.presentScene(Model.shared.scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
