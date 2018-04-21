//
//  ABC.m
//  KATrackingAd_Demo
//
//  Created by glzlaohuai on 2018/3/21.
//  Copyright © 2018年 Jason Y Liu. All rights reserved.
//

#import "KAInterstitialDelegateImpl.h"
#include "UnityInterface.h"

@implementation KAInterstitialDelegateImpl

-(void) interstitialDidFinishLoading:(nonnull KAAdInterstitial*)interstitialAd{
    NSLog(@"interstitialDidFinishLoading...");
    UnitySendMessage("KATrackingADServiceDelegate", "csInterstitialLoadSuccess","");
}
-(void) interstitialDidFailLoadingForSlot:(nonnull NSString *)interstitialAdSlot
                                WithError:(nonnull NSError *)interstitialAdStatus{
    NSLog(@"interstitialDidFailLoadingForSlot...");
    UnitySendMessage("KATrackingADServiceDelegate", "csInterstitialLoadFailed", [interstitialAdStatus.description UTF8String]);
    
}
-(void) interstitialDidDismiss:(nonnull KAAdInterstitial*)interstitial{
    UnitySendMessage("KATrackingADServiceDelegate", "csInterstitialDismissed", "");
}

@end

