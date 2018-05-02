//
//  KASplashDelegateimpl.m
//  DOTest
//
//  Created by glzlaohuai on 2018/4/28.
//  Copyright © 2018年 glzlaohuai. All rights reserved.
//

#import "KASplashDelegateimpl.h"
#import "UnityInterface.h"
#import "KATrackingUnityConstants.h"

@implementation KASplashDelegateimpl

- (void)splashAdDidClick:(KAAdSplash *)splashAd{
    UnitySendMessage(GAME_OBJ_NAME, "csSplashAdDidClick", [[splashAd ka_slot]UTF8String]);
}

- (void)splashAdDidDismiss:(KAAdSplash *)splashAd{
    UnitySendMessage(GAME_OBJ_NAME, "csSplashAdDidDismiss", [[splashAd ka_slot]UTF8String]);
}

- (void)splashAdPresentDidSuccess:(KAAdSplash *)splashAd{
    UnitySendMessage(GAME_OBJ_NAME, "csSplashAdPresentDidSuccess", [[splashAd ka_slot]UTF8String]);
}

- (void)splashAdPresentDidFail:(NSString *)splashAdSlot withError:(NSError *)error{
    NSString *msg = [splashAdSlot stringByAppendingString:[error localizedDescription]];
    UnitySendMessage(GAME_OBJ_NAME, "csSplashAdPresentDidFail", [msg UTF8String]);
}


@end


