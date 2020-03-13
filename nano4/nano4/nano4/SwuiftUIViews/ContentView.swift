//
//  ContentView.swift
//  nano4
//
//  Created by Kevin Ribeiro on 03/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    var body: some View {
        
        
        ZStack {
            
            NavigationLink(destination: EndGameView().navigationBarBackButtonHidden(true), isActive: self.$isActive) {
                EmptyView()
                
            }
            
            GameViewAdapter()
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                CellphoneView(onClickLeft: {
                    Model.shared.scene.moveToLeft()
 
                }, onClickRight: {
                    
                    Model.shared.scene.moveToRight()
                })
            }
            
            
            
        }.onAppear(){
            Model.shared.scene.onGameOver = {
                print("jogo acabou")
                self.isActive = true
                
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
