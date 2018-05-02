//
//  KAInterstitialDelegate.m
//  KATrackingAdobeLib
//
//  Created by glzlaohuai on 2018/4/26.
//  Copyright © 2018年 glzlaohuai. All rights reserved.
//

#import "KATrackingAdobeLib.h"
#import "KAAdobeInterstitialDelegate.h"
#import "KAAdobeConstants.h"

@implementation KAAdobeInterstitialDelegate

- (void)interstitialAdDidClick:(KAAdInterstitial *)splashAd{
    adobeLog(@"interstitialAdDidClick...");
    dispatchADEvent(AD_INTERSTITIAL, EVENT_AD_CLICK, splashAd.ka_slot, @"");
}

- (void)interstitialAdDidDismiss:(KAAdInterstitial *)interstitial{
    adobeLog(@"interstitialAdDidDismiss...");
    dispatchADEvent(AD_INTERSTITIAL, EVENT_AD_DISMISS, interstitial.ka_slot, @"");
}

- (void)interstitialAdDidPresent:(KAAdInterstitial *)interstitial{
    adobeLog(@"interstitialAdDidPresent...");
    dispatchADEvent(AD_INTERSTITIAL, EVENT_PRESENT, interstitial.ka_slot, @"");
}

- (void)interstitialAdLoadDidSuccess:(KAAdInterstitial *)interstitialAd{
    adobeLog(@"interstitialAdLoadDidSuccess...");
    dispatchADEvent(AD_INTERSTITIAL, EVENT_LOAD_SUCCESS, interstitialAd.ka_slot, @"");
}

- (void)interstitialAdLoadDidFailForSlot:(NSString *)interstitialAdSlot withError:(NSError *)interstitialAdStatus{
    adobeLog(@"interstitialAdLoadDidFailForSlot...");
    dispatchADEvent(AD_INTERSTITIAL, EVENT_LOAD_FAILED, interstitialAdSlot, [interstitialAdStatus localizedDescription]);
}

@end
