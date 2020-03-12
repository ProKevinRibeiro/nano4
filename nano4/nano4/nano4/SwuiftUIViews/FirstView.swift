//
//  MenuView.swift
//  nano4
//
//  Created by Kevin Ribeiro on 04/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import SwiftUI

struct FirstView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private var green_tone = Color.init(red: 0.63, green: 0.77, blue: 0.23)
    
    var body: some View {
        GeometryReader { geometry in
            if(geometry.size.width < geometry.size.height) {
            
                VStack {
                        
                     ZStack {
                        
                        Rectangle()
                            .foregroundColor(Color.black)
                            .opacity(0.8)
                        VStack {
                            Spacer()
                            Image("snake_menu")
                            
                            Spacer()
                                
                            NavigationLink(destination: PauseView()) {
                                Text("< Toque para começar >")
                                    .fontWeight(.black)
                                .foregroundColor(self.green_tone)
                                .font(Font.system(size: 20, design: Font.Design.monospaced))
                                .padding(.bottom)
                            }
                            
                            
                        }
                        
                       
                            
                            
                    }
                    
                } .edgesIgnoringSafeArea(.all)
                
                //celular
                CellphoneView(onClickLeft: {
                    
                    //colocar o endereço de onde vai quando clica
                        Model.shared.scene.moveToLeft()
                                       
                }, onClickRight: {
                    //endereço de onde vai quando clica
                        Model.shared.scene.moveToRight()
                })
                
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FirstView()
            
            FirstView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
        }
    }
}
