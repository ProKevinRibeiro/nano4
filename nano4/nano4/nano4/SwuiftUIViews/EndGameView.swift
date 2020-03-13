//
//  EndGameView.swift
//  nano4
//
//  Created by Mariana Lech on 06/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import SwiftUI

struct EndGameView: View {
    
     private var green_tone = Color.init(red: 0.63, green: 0.77, blue: 0.23)
    
    var body: some View {
        GeometryReader { geometry in
               if(geometry.size.width < geometry.size.height) {
               
                   VStack {
                       ZStack {
                           Rectangle()
                               .foregroundColor(Color.black)
                               .opacity(0.8)
                                .edgesIgnoringSafeArea(.all)
                           VStack {
                            
                            HStack {
                            Spacer()
                            //Image("config_icon_clear")
                               // .frame(alignment:.trailing)
                                //.padding(.trailing)
                            }
                            
                               Spacer()
                            
                                Text("Você perdeu!")
                                .fontWeight(.black)
                                .foregroundColor(self.green_tone)
                                .font(Font.system(size: 30, design: Font.Design.monospaced))
                                .padding(.bottom)
                                
                                //Spacer()
                            
                            HStack {
                                
                                
                                //reviver button
                                ZStack{
                                    
                                    Rectangle()
                                        .foregroundColor(self.green_tone)
                                        .frame(width: geometry.size.height/5, height: geometry.size.height/5, alignment: .center)
                                        .cornerRadius(12.0)
                                
                                    VStack  {
                                     Image("play_video_icon")
                                        
                                    Text("Reviver")
                                    .fontWeight(.black)
                                        .foregroundColor(Color.black)
                                    .font(Font.system(size: 16, design: Font.Design.monospaced))
                                        //.padding()
                                    Text("Veja um vídeo")
                                    .fontWeight(.black)
                                        .foregroundColor(Color.black)
                                    .font(Font.system(size: 12, design: Font.Design.monospaced))
                                       
                                    }
                                }
                                
                                
                        
                            }
                            
                            
                               
                               Spacer()
                                   
                               NavigationLink(destination: ContentView()) {
                                   Text("< Toque para continuar >")
                                       .fontWeight(.black)
                                   .foregroundColor(self.green_tone)
                                   .font(Font.system(size: 20, design: Font.Design.monospaced))
                                   .padding(.bottom)
                               }
                           }
                               
                                      CellphoneView(onClickLeft: {
                                                Model.shared.scene.moveToLeft()
                                                             
                                            }, onClickRight: {
                                                Model.shared.scene.moveToRight()
                                    })
                       }
                       
                   }
               }
           }
    }
}

struct EndGameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        EndGameView()
        
        EndGameView()
         .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
        }
    }
}
