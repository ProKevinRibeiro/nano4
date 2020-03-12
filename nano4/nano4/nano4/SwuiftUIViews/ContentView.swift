//
//  ContentView.swift
//  nano4
//
//  Created by Kevin Ribeiro on 03/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            GameViewAdapter()
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                CellphoneView(onClickLeft: {
                    Model.shared.scene.moveToLeft()
 
                }, onClickRight: {
                    
                    Model.shared.scene.moveToRight()
                })
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ContentView()
            
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            
        }
    }
}
