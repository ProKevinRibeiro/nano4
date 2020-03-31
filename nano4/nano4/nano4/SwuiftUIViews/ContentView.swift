//
//  ContentView.swift
//  nano4
//
//  Created by Kevin Ribeiro on 03/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    //passando a variavel pontos para o swiftUI
    
    @State var points: Int = 0
    
    @State var adDelegateWrapper: AdDelegateWrapper?
    @State var rewardedAd: GADRewardedAd?
    //função do ads
    
     @State var isDirty = false
    @State var yPosition = 0.0
    @State var shouldDisplayEndGame: Bool = false
    @State var shouldDisplayAd = false
    
    
    var body: some View {
        
        GeometryReader { geometry in
            // yPosition = Double(geometry.size.height/2)
            ZStack {

             
                
                
                GameViewAdapter()
                    .edgesIgnoringSafeArea(.all)
                
                
                
                //ZStack {
                    
                    //VStack {
                       
                        VStack {
                            VStack {
                            HStack {
                                
                                Spacer()
                                Image("trofeu")
                                
                                Text("0\(self.points)")
                                    
                                    .font(Font.system(size: 25, design: Font.Design.monospaced))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                    

                                Spacer()
                                
                                
                                }
                            .frame(width: (geometry.size.width/2), height: (geometry.size.height/10))
                            .background(Color.black.opacity(0.3))
                            .padding(.top)
                            }.padding(.top)
                           Spacer()
                            
                        }.padding(.top)
                        .edgesIgnoringSafeArea(.all)
                           // .offset(y: -(geometry.size.width/2))
                        
                        /*VStack {
                            Spacer()
                            //Spacer()
                        }*/
                        //Spacer()
                    //}
                    
                    
                   
                   CellphoneView(onClickLeft: {
                        Model.shared.scene!.moveToLeft()
                        
                    }, onClickRight: {
                        
                        Model.shared.scene!.moveToRight()
                    })
                    
                
                NavigationLink(
                                 destination: EndGameView(isActive: self.$shouldDisplayEndGame, points: self.points).navigationBarBackButtonHidden(true),
                                 isActive: self.$shouldDisplayEndGame)
                             {
                                 EmptyView()

                             }
                   
                //}
                
                
                
            }.onAppear(){
                self.loadAd()
                print("Show display ad: \(self.shouldDisplayAd)")
                //                if self.shouldDisplayAd {
                //                    self.showAd()
                //                }
                Model.shared.scene.onGameOver = {
                    print("jogo acabou")
                    self.showAd()
                    //self.shouldDisplayAd = false
                    // self.shouldDisplayAd.toggle()
                    print("Show display ad model: \(self.shouldDisplayAd)")
                    //self.isDirty.toggle()
                    
                }
                
                //chamando a variavel da scene e atualizando o valor
                Model.shared.scene.onChangePoint = { points in
                    self.points = points
                }
            }
        }
        .statusBar(hidden: true)
    }
    
    func showAd() {
        
        print("Vou mostrar o ad")
        guard let ad = self.rewardedAd, ad.isReady else { return }
        guard let vc = UIApplication.shared.windows.first?.rootViewController else { return }
        self.adDelegateWrapper = AdDelegateWrapper(contentView: self)
        
        ad.present(fromRootViewController: vc, delegate: self.adDelegateWrapper!)
    }
    
    func loadAd() {
        rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-6710438178084678/8537635578")
        //        rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313") // sets debug
        
        print("Loading ad")
        self.rewardedAd?.load(GADRequest()) { error in
            if let error = error {
                
            } else {
                print("Loaded ad")
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
