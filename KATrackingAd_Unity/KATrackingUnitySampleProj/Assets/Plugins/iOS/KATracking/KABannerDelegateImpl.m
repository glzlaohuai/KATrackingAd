//
//  KABannerDelegateImpl.m
//  Unity-iPhone
//
//  Created by 刘立峰 on 2018/9/5.
//

#import "KABannerDelegateImpl.h"

@implementation KABannerDelegateImpl


- (void)bannerDidDismissScreen:(KAAdBanner *)bannerAd{
    
    NSString *slotID = [bannerAd ka_slot];
    UnitySendMessage(GAME_OBJ_NAME, "csBannerDidDismissScreen",[slotID UTF8String]);
}


- (void)bannerDidPresentScreen:(KAAdBanner *)bannerAd{
    
    NSString *slotID = [bannerAd ka_slot];
    UnitySendMessage(GAME_OBJ_NAME, "csBannerDidPresentScreen",[slotID UTF8String]);
    
}

- (void)bannerAdCompleteLoadingWithAd:(KAAdBanner *)bannerAd{
    
    NSString *slotID = [bannerAd ka_slot];
    UnitySendMessage(GAME_OBJ_NAME, "csBannerAdCompleteLoadingWithAd",[slotID UTF8String]);
}

- (void)bannerAdFailedLoadingForSlot:(NSString *)adSlot withStatus:(NSError *)nativeAdStatus andBanner:(KAAdBanner *)bannerAd{
    
    NSString *msg = [[adSlot stringByAppendingString: @"#"] stringByAppendingString:[nativeAdStatus localizedDescription]];
    UnitySendMessage(GAME_OBJ_NAME, "csBannerAdFailedLoadingForSlot",[msg UTF8String]);
    
}

@end
