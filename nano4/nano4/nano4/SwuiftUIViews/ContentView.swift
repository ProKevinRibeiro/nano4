//
//  ContentView.swift
//  nano4
//
//  Created by Kevin Ribeiro on 03/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //passando a variavel pontos para o swiftUI
       
       @State var points: Int = 0
    
    @State private var isActive = false
    var body: some View {
        
        GeometryReader { geometry in
                
            ZStack {
                
                NavigationLink(destination: EndGameView().navigationBarBackButtonHidden(true), isActive: self.$isActive) {
                    EmptyView()
                    
                }
                
                GameViewAdapter()
                    .edgesIgnoringSafeArea(.all)
                
                
                
                ZStack {
                    VStack {
                        HStack {
                            Text("\(self.points)")
    
                            .font(Font.system(size: 25, design: Font.Design.monospaced))
                            .padding(.top)

                            
                            /*Spacer()
                            
                            Image("config_icon")
                            .padding(.top)
                                .padding()*/
                    }
                    .frame(width: (geometry.size.width), height: (geometry.size.height/9))
                        .background(Color.black.opacity(0.3))
                        .edgesIgnoringSafeArea(.top)
                            
                        
                        
                        Spacer()
                        
                    }
                                               
                    
                    
                    CellphoneView(onClickLeft: {
                        Model.shared().scene.moveToLeft()
     
                    }, onClickRight: {
                        
                        Model.shared().scene.moveToRight()
                    })
                    
                   
                }
                
                
                
            }.onAppear(){
                Model.shared().scene.onGameOver = {
                    print("jogo acabou")
                    self.isActive = true
                    
                }
                
                //chamando a variavel da scene e atualizando o valor
                Model.shared().scene.onChangePoint = { points in
                    self.points = points
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
