//
//  KAAdobeSplashDelegate.m
//  KATrackingAdobeLib
//
//  Created by glzlaohuai on 2018/4/26.
//  Copyright © 2018年 glzlaohuai. All rights reserved.
//

#import "KAAdobeSplashDelegate.h"
#import "KAAdobeConstants.h"
#import "KATrackingAdobeLib.h"

#import <UIKit/UIViewController.h>
#import <UIKit/UIKit.h>

#import "KAAdSplash.h"


@implementation KAAdobeSplashDelegate

- (void)splashAdDidClick:(KAAdSplash *)splashAd{
    adobeLog(@"splashAdDidClick...");
    dispatchADEvent(AD_SPLASH, EVENT_AD_CLICK, splashAd.ka_slot, @"");
}

- (void)splashAdDidDismiss:(KAAdSplash *)splashAd{
    adobeLog(@"splashAdDidDismiss...");
    dispatchADEvent(AD_SPLASH, EVENT_AD_DISMISS, splashAd.ka_slot, @"");
}

- (void)splashAdPresentDidSuccess:(KAAdSplash *)splashAd{
    adobeLog(@"splashAdPresentDidSuccess...");
    dispatchADEvent(AD_SPLASH, EVENT_PRESENT, splashAd.ka_slot, @"");
}

- (void)splashAdPresentDidFail:(NSString *)splashAdSlot withError:(NSError *)error{
    adobeLog(@"splashAdPresentDidFail...");
    dispatchADEvent(AD_SPLASH, EVENT_LOAD_FAILED, splashAdSlot, [error localizedDescription]);
}

@end
