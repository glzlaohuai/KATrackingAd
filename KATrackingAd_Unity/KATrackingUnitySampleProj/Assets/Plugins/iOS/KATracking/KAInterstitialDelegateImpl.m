//
//  ABC.m
//  KATrackingAd_Demo
//
//  Created by glzlaohuai on 2018/3/21.
//  Copyright © 2018年 Jason Y Liu. All rights reserved.
//

#import "KAInterstitialDelegateImpl.h"
#include "UnityInterface.h"
#import "KATrackingUnityConstants.h"

@implementation KAInterstitialDelegateImpl

-(void)interstitialAdLoadDidFailForSlot:(NSString *)interstitialAdSlot withError:(NSError *)interstitialAdStatus{
    NSString *msg = [[interstitialAdSlot stringByAppendingString: @"#"] stringByAppendingString:[interstitialAdStatus localizedDescription]];
    UnitySendMessage(GAME_OBJ_NAME, "csInterstitialAdLoadDidFailForSlot",[msg UTF8String]);
}

- (void)interstitialAdLoadDidSuccess:(KAAdInterstitial *)interstitialAd{
    UnitySendMessage(GAME_OBJ_NAME, "csInterstitialAdLoadDidSuccess", [[interstitialAd ka_slot] UTF8String]);
}

- (void)interstitialAdDidClick:(KAAdInterstitial *)splashAd{
    UnitySendMessage(GAME_OBJ_NAME, "csInterstitialAdDidClick", [[splashAd ka_slot] UTF8String]);
}

- (void)interstitialAdDidDismiss:(KAAdInterstitial *)interstitial{
    UnitySendMessage(GAME_OBJ_NAME, "csInterstitialADDismiss", [[interstitial ka_slot] UTF8String]);
}

- (void)interstitialAdDidPresent:(KAAdInterstitial *)interstitial{
    UnitySendMessage(GAME_OBJ_NAME, "csInterstitialAdDidPresent", [[interstitial ka_slot]UTF8String]);
}

@end

