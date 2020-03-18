//
//  AdUiViewController.swift
//  nano4
//
//  Created by Mariana Lech on 17/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import Foundation
import SwiftUI
import GoogleMobileAds
import UIKit

final class Interstitial:NSObject, GADInterstitialDelegate{
    //var interstitial:GADInterstitial = GADInterstitial(adUnitID: interstitialID)
    let id = "ca-app-pub-2288763971904962/2217520253"
    let testeId = "ca-app-pub-3940256099942544/4411468910"
    let newAd = GADInterstitial(adUnitID: testeId)
    
    override init() {
        super.init()
        LoadInterstitial()
    }
    
     func interstitialDidDismissScreen(_ ad: GADInterstitial) {
           self.loadInternAd()
    }
       
    func loadInternAd() {
          
           
           newAd.delegate = self
           newAd.load(GADRequest())
           self.interAd = newAd
           
    }
       
    func presentInterAd() {
           guard self.interAd.isReady else { return }
           self.interAd.present(fromRootViewController: self)
           
    }
    
    
}

struct ContentView:View{
    var interstitial:Interstitial
    
    init(){
        self.interstitial = Interstitial()
    }
    
    var body : some View{
      Button(action: {self.interstitial.showAd()}){
        Text("My Button")
      }
    }
}

