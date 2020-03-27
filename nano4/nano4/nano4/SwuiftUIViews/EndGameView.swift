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
    
    var green_tone = Color.init(red: 0.63, green: 0.77, blue: 0.23)
    @Binding  var isActive: Bool
    @State var points: Int
    
    var body: some View {
        
        NavigationView {
        GeometryReader { geometry in
               if(geometry.size.width < geometry.size.height) {
                
               
                   VStack {
                       ZStack {
                        
                        
                           Rectangle()
                            .foregroundColor(Color.black.opacity(0.2))
                            .background(
                                Image("background01"))
                            .opacity(1.0)
                                .edgesIgnoringSafeArea(.all)
                           
                        
                       Spacer()
                        VStack {
                        
                            //Spacer()
                            
                            VStack {
                                Image("trofeu")
                                
                                Text("You made")
                                .fontWeight(.black)
                                .foregroundColor(self.green_tone)
                                .font(Font.system(size: 30, design: Font.Design.monospaced))
                                .fontWeight(.bold)
                                .padding(.all)
                                
                                Text("\(self.points)")
                                //Text(String(format: "%03d", self.points))
                                .fontWeight(.black)
                                .foregroundColor(self.green_tone)
                                .font(Font.system(size: 130, design: Font.Design.monospaced))
                                .fontWeight(.bold)
                                .padding(.all)
                                
                                Text("points")
                                .fontWeight(.black)
                                .foregroundColor(self.green_tone)
                                .font(Font.system(size: 30, design: Font.Design.monospaced))
                                .fontWeight(.bold)
                                .padding(.all)
                            }
                            
                            Spacer()
                            
                            Text("Press any button to play again")
                                .fontWeight(.regular)
                                .foregroundColor(self.green_tone.opacity(0.5))
                                .font(Font.system(size: 16, design: Font.Design.monospaced))
                                .multilineTextAlignment(.center)
                                .padding(.bottom)
                                .frame(width: geometry.size.width - (geometry.size.width/5), alignment: .center)
                            
                            
                            Spacer() 
                           }
                        
                        Spacer()
                               
                                      CellphoneView(onClickLeft: {
                                        Model.shared.load()
                                                self.isActive = false
                                                             
                                            }, onClickRight: {
                                                Model.shared.load()
                                               self.isActive = false
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




/*struct EndGameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        //EndGameView(isActive: true)

            //EndGameView(isActive: true)
            EndGameView(isActive: true)
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
 
 */
