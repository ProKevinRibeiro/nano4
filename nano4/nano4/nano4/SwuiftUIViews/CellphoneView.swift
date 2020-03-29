//
//  cellphoneView.swift
//  nano4
//
//  Created by Mariana Lech on 12/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import Foundation
import SwiftUI


struct CellphoneView: View {
    
    var onClickLeft: () -> Void
    var onClickRight: () -> Void
    
    var body: some View {
        
        
        ZStack {
            Image("fundo").resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                Spacer()
                }
                HStack {
                    
                    Button(action: {
                        
                        self.onClickLeft()
                    }) {
                        Image("botao_esquerda")
                            .padding(.top)
                    }.buttonStyle(PlainButtonStyle())
                    
                    //Image("charme")
                    
                    
                    Button(action: {
                        
                        self.onClickRight()
                    }) {
                        Image("botao_direita")
                            .padding(.top)
                    }.buttonStyle(PlainButtonStyle())
                    
                }.edgesIgnoringSafeArea(.bottom)
            }
        }
        .statusBar(hidden: true)
    }
}

/*struct CellphoneView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        CellphoneView()
        
           // CellphoneView(onClickLeft:)
         .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
        }
    }
}*/
