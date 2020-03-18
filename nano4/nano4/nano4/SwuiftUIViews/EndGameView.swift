//
//  EndGameView.swift
//  nano4
//
//  Created by Mariana Lech on 06/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import SwiftUI
import GoogleMobileAds

struct EndGameView: View {
    
     private var green_tone = Color.init(red: 0.63, green: 0.77, blue: 0.23)
     @State private var isActive = false

    
    
    var body: some View {
        
        //var interAd: GADInterstitial!
        //var rewardAd: GADRewardedAd!
        
 
        
        NavigationView {
        GeometryReader { geometry in
               if(geometry.size.width < geometry.size.height) {
                
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: self.$isActive) {
                EmptyView()
                                            
                }
               
                   VStack {
                       ZStack {
                        
                        
                           Rectangle()
                               .foregroundColor(Color.black)
                            .background(
                                Image("fundo-1"))
                               .opacity(0.8)
                                .edgesIgnoringSafeArea(.all)
                           VStack {
                            
                            
                            
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
                                        .frame(width: geometry.size.height/4, height: geometry.size.height/4, alignment: .center)
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
                            
                            Text("< Toque nas teclas para reiniciar >")
                                .fontWeight(.black)
                                .foregroundColor(self.green_tone)
                                .font(Font.system(size: 16, design: Font.Design.monospaced))
                                .padding(.bottom)
                            
                            
                               Spacer()
                                   
                        
                               
                           }
                               
                                      CellphoneView(onClickLeft: {
                                                self.isActive = true
                                                             
                                            }, onClickRight: {
                                               self.isActive = true
                                    })
                       }
                       
                   }
               }
        }.onAppear() {
            print("chamou o load do onAppear")
            //self.loadAd()
            
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

/*extension ViewController: GADInterstitialDelegate {
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.loadInternAd()
    }
    
    func loadInternAd() {
        let id = "ca-app-pub-2288763971904962/2217520253"
        let testeId = "ca-app-pub-3940256099942544/4411468910"
        let newAd = GADInterstitial(adUnitID: testeId)
        
        newAd.delegate = self
        newAd.load(GADRequest())
        self.interAd = newAd
        
    }
    
    func presentInterAd() {
        guard self.interAd.isReady else { return }
        self.interAd.present(fromRootViewController: self)
        
    }
}


//ReWard ads
extension ViewController: GADInterstitialDelegate {
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        self.loadReward()
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarnreward: GADAdReward) {
        print(reward.amount, reward.type)
    }
    
    func loadReward() {
        let id = "ca-app-pub-2288763971904962/4157287884"
        let testeId = "ca-app-pub-3940256099942544/1712485313"
        
        let newAd = GADRewardedAd(adUnitID: id)
        
        newAd.load(GADRequest()) { (error) in
            
            if let error = error {
                print("Vixi, deu ruim", error)
                return
            }
            
        }
        
        self.rewardAd = newAd
    }
    
    func presentReward() {
        self.rewardAd.present(fromRootViewController: self, delegate: self)
    }
}
*/
