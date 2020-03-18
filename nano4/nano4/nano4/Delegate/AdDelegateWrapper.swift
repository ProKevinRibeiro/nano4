//
//  AdDelegateWrapper.swift
//  nano4
//
//  Created by Mariana Lech on 17/03/20.
//  Copyright © 2020 Kevin Ribeiro. All rights reserved.
//

import Foundation
import GoogleMobileAds

class AdDelegateWrapper: NSObject, GADRewardedAdDelegate, GADRewardBasedVideoAdDelegate {
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        
       // self.contentView.mission.isAdComplete = true
        self.contentView.isDirty.toggle()
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("recvd?")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error) {
        print("failed")
    }
    
    
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        print("Show display ad: \(self.contentView.shouldDisplayAd)")
        self.contentView.shouldDisplayAd = false
        self.contentView.shouldDisplayEndGame = true
        
        self.contentView.isDirty.toggle()
    }
    
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        //self.endGameView.mission.isAdComplete = true
        self.contentView.isDirty.toggle()
    }
    
    var contentView: ContentView!
    
    init(contentView: ContentView) {
        self.contentView = contentView
    }
}
