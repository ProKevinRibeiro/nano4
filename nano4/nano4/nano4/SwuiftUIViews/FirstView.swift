//
//  MenuView.swift
//  nano4
//
//  Created by Kevin Ribeiro on 04/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import SwiftUI

struct FirstView: View {
    
    @State private var isActive = false
    //@State var selection: Int? = nil
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private var green_tone = Color.init(red: 0.63, green: 0.77, blue: 0.23)
    
    var body: some View {
        NavigationView {
        GeometryReader { geometry in
            if(geometry.size.width < geometry.size.height) {
            
                VStack {
                        
                     ZStack {
                        
                        //chama a content
                       
                        
                        Rectangle()
                            .foregroundColor(Color.black)
                            .opacity(0.8)
                        VStack {
                            //Spacer()
                            Image("snake_menu")
                            
                            //Spacer()
                                
                            //NavigationLink(destination: PauseView()) {
                                Text("< Toque nas teclas para começar >")
                                    .fontWeight(.black)
                                .foregroundColor(self.green_tone)
                                .font(Font.system(size: 18, design: Font.Design.monospaced))
                                .padding(.bottom)
                            //}
                            
                            
                        }
                        
                        NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true),
                                                              isActive: self.$isActive) {
                                               EmptyView()
                                                    
                        }
                        
                       
                            
                            
                    }
                    
                } .edgesIgnoringSafeArea(.all)
                
                
                
                
                //celular
                CellphoneView(onClickLeft: {
                   self.isActive = true
                                       
                }, onClickRight: {
                    self.isActive = true
                })
                
            }
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
