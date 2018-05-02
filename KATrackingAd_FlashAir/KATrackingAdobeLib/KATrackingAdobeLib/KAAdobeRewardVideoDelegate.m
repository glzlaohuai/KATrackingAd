//
//  KAAdobeRewardVideoDelegate.m
//  KATrackingAdobeLib
//
//  Created by glzlaohuai on 2018/4/26.
//  Copyright © 2018年 glzlaohuai. All rights reserved.
//

#import "KAAdobeRewardVideoDelegate.h"
#import "KAAdobeConstants.h"
#import "KATrackingAdobeLib.h"

@implementation KAAdobeRewardVideoDelegate

- (void)incentivizedAdPresentDidSkip{
    adobeLog(@"incentivizedAdPresentDidSkip...");
    dispatchADEvent(AD_REWARDVIDEO, EVENT_AD_SKIP, @"", @"");
}

- (void)incentivizedAdPresentDidSuccess{
    adobeLog(@"incentivizedAdPresentDidSuccess...");
    dispatchADEvent(AD_REWARDVIDEO, EVENT_PRESENT, @"", @"");
}

- (void)incentivizedAdPresentDidComplete{
    adobeLog(@"incentivizedAdPresentDidComplete...");
    dispatchADEvent(AD_REWARDVIDEO, EVENT_AD_DISMISS, @"", @"");
}

- (void)incentivizedAdPresentDidFailWithError:(NSError *)error{
    adobeLog(@"incentivizedAdPresentDidFailWithError...");
    dispatchADEvent(AD_REWARDVIDEO, EVENT_LOAD_FAILED, @"", [error localizedDescription]);
}

@end
