//
//  GameViewAdapter.swift
//  nano4
//
//  Created by Kevin Ribeiro on 03/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//
import UIKit
import SpriteKit
import GameplayKit
import SwiftUI

struct GameViewAdapter: UIViewControllerRepresentable {
    
    var vc: GameViewController
    
    init() {
        vc = GameViewController()
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GameViewAdapter>) -> GameViewController {
        return self.vc
    }
    
    func updateUIViewController(_ uiViewController: GameViewController, context: UIViewControllerRepresentableContext<GameViewAdapter>) {
        print("updateUIViewController")
    }
    
    typealias UIViewControllerType = GameViewController
    
}
