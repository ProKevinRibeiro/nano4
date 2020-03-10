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
                Image("fundo").resizable()
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    Spacer()
                    
                    HStack {
                        
                        Button(action: {
                            print("botao apertado")
                            Model.shared.scene.moveToLeft()
                        }) {
                            Image("botao_esquerda")
                        }.buttonStyle(PlainButtonStyle())
                        
                        Image("charme")
                        
                        
                        Button(action: {
                            print("botao apertado")
                            Model.shared.scene.moveToRight()
                        }) {
                            Image("botao_direita")
                        }.buttonStyle(PlainButtonStyle())
                        
                    }
                }
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
