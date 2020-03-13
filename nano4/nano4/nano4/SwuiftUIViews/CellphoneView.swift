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
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        
                        self.onClickLeft()
                    }) {
                        Image("botao_esquerda")
                    }.buttonStyle(PlainButtonStyle())
                    
                    Image("charme")
                    
                    
                    Button(action: {
                        
                        self.onClickRight()
                    }) {
                        Image("botao_direita")
                    }.buttonStyle(PlainButtonStyle())
                    
                }
            }
        }
    }
}

/*struct CellphoneView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        CellphoneView()
        
            CellphoneView(onClickLeft:)
         .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
        }
    }
}*/
