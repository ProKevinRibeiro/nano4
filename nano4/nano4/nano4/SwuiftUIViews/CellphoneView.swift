//
//  cellphoneView.swift
//  nano4
//
//  Created by Mariana Lech on 12/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    func onTouchDownGesture(callback: @escaping () -> Void) -> some View {
        modifier(OnTouchDownGestureModifier(callback: callback))
    }
}

private struct OnTouchDownGestureModifier: ViewModifier {
    @State private var tapped = false
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !self.tapped {
                        self.tapped = true
                        self.callback()
                    }
                }
                .onEnded { _ in
                    self.tapped = false
                })
    }
}

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
                    
//                    Button(action: {
//
//                        self.onClickLeft()
//                    }) {
//                        Image("botao_esquerda")
//                            .padding(.top)
//                    }.buttonStyle(PlainButtonStyle())
                    
                    Image("botao_esquerda")
                        .padding(.top)
                        .onTouchDownGesture {
                            self.onClickLeft()
                        }
                    
                    Image("botao_direita")
                    .padding(.top)
                    .onTouchDownGesture {
                        self.onClickRight()
                    }
                    
                    
//                    Button(action: {
//
//                        self.onClickRight()
//                    }) {
//                        Image("botao_direita")
//                            .padding(.top)
//                    }.buttonStyle(PlainButtonStyle())
                    
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
