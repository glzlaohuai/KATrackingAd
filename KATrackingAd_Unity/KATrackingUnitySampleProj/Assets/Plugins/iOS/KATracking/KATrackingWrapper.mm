//
//  Test.m
//  KATrackingAd_Demo
//
//  Created by glzlaohuai on 2018/3/20.
//  Copyright © 2018年 Jason Y Liu. All rights reserved.
//

#import <KASDK/KASDK.h>
#import "KABannerDelegateImpl.h"
#import "KAInterstitialDelegateImpl.h"
#import <UIKit/UIKit.h>
#import "UnityInterface.h"
#import "KASplashDelegateimpl.h"
#import "KARewardVideoDelegateImpl.h"

static NSMutableDictionary *interstitialAdDict = [NSMutableDictionary dictionary];
static NSMutableDictionary *interstitialDelegateDict = [NSMutableDictionary dictionary];

static NSMutableDictionary *bannerAdDict = [NSMutableDictionary dictionary];
static NSMutableDictionary *bannerDelegateDict = [NSMutableDictionary dictionary];

static KARewardVideoDelegateImpl *rewardDelegate;

extern "C"{
    
    void doInit(const char* appID,const char* appChannel){
        NSString* appIDStr = [[NSString alloc] initWithUTF8String: appID];
        NSString* appChannelStr = [[NSString alloc] initWithUTF8String: appChannel];
        [[KATracking sharedInstance] initWithAppId:appIDStr channel:appChannelStr];
    }
    
    void doLoadInterstitial(const char* slotIDChar){
        NSString *slotID = [[NSString alloc] initWithUTF8String: slotIDChar];
        
        id originalAD = [interstitialAdDict valueForKey:slotID];
        if ([originalAD isKindOfClass:[KAAdInterstitial class]]) {
            ((KAAdInterstitial *)originalAD).delegate = nil;
        }
        
        [interstitialAdDict setValue:nil forKey:slotID];
        [interstitialDelegateDict setValue:nil forKey:slotID];
        
        KAInterstitialDelegateImpl *adDelegate = [[KAInterstitialDelegateImpl alloc]init];
        
        [interstitialDelegateDict setValue:adDelegate forKey:slotID];
        
        KAAdInterstitial *interstitial = [[KAAdInterstitial alloc]initWithSlot:slotID delegate:adDelegate];
        [interstitialAdDict setValue:interstitial forKey:slotID];
        [interstitial load];
    }
    
    
    void doShowInterstitial(const char* slotIDChar){
         NSString *slotID = [[NSString alloc] initWithUTF8String: slotIDChar];
        id adInstance = [interstitialAdDict valueForKey:slotID];
        
        if (adInstance != nil && [adInstance isKindOfClass:[KAAdInterstitial class]] && [adInstance isReady]) {
            [((KAAdInterstitial *)adInstance) presentFromRootViewController: UnityGetGLViewController()];
        }
    }
    
    bool doCheckIsInterstitialAvaliable(const char* slotIDChar){
        NSString *slotID = [[NSString alloc] initWithUTF8String: slotIDChar];
        id adInstance = [interstitialAdDict valueForKey:slotID];
        return (adInstance != nil)&&([adInstance isKindOfClass:[KAAdInterstitial class]])&&[adInstance isReady];
    }
    
    void doShowSplash(const char* slotIDChar){
        NSString *slotID = [[NSString alloc] initWithUTF8String: slotIDChar];
        
        [interstitialAdDict setValue:nil forKey:slotID];
        [interstitialDelegateDict setValue:nil forKey:slotID];

        KASplashDelegateimpl *delegate = [[KASplashDelegateimpl alloc]init];
        [interstitialDelegateDict setValue:delegate forKey:slotID];
        
        KAAdSplash *splash = [[KAAdSplash alloc]initWithSlot:slotID delegate: delegate];
        [interstitialAdDict setValue:splash forKey:slotID];
        [splash loadAndPresentWithViewController: UnityGetGLViewController()];
    }
    
    void doLoadRewardVideo(){
        if (rewardDelegate == nil) {
            rewardDelegate = [[KARewardVideoDelegateImpl alloc]init];
            [KAAdIncentivized setDelegate:rewardDelegate];
        }
        [KAAdIncentivized load];
    }
    
    void doShowRewardVideo(){
        if (rewardDelegate == nil) {
            rewardDelegate = [[KARewardVideoDelegateImpl alloc]init];
            [KAAdIncentivized setDelegate:rewardDelegate];
        }
        
        if ([KAAdIncentivized isReady:NO]) {
            [KAAdIncentivized presentFromRootViewController: UnityGetGLViewController() andSkipButton:NO];
        }else{
        }
    }
    
    bool doCheckIsRewardVideoAvaliable(){
        bool isOK = [KAAdIncentivized isReady:NO];
        return isOK;
    }
    
    void doShowBanner(const char *slotIDChar){
        
        NSString *slotID = [[NSString alloc] initWithUTF8String: slotIDChar];
        id originalAD = [bannerAdDict valueForKey:slotID];
        if (originalAD != nil && [originalAD isKindOfClass:[KAAdBanner class]]) {
            if ([((KAAdBanner *)originalAD) superview] == nil) {
                [UnityGetGLView() addSubview:originalAD];
            }else{
                [originalAD setHidden:NO];
            }
        }
    }
    
    
    void doLoadBanner(const char *slotIDChar,const char *bannerSizeChar){
        
        NSString *slotID = [[NSString alloc] initWithUTF8String: slotIDChar];
        NSString *bannerSizeStr = [[NSString alloc] initWithUTF8String: bannerSizeChar];
        
        KAAdBannerSize bannerSize = KAAdBannerSize728x90;
        
        if ([bannerSizeStr isEqualToString:@"BANNER_SIZE_320_50"]) {
            bannerSize = KAAdBannerSize320x50;
        }else if ([bannerSizeStr isEqualToString:@"BANNER_SIZE_468_60"]){
            bannerSize = KAAdBannerSize468x60;
        }else{
            bannerSize = KAAdBannerSize728x90;
        }
        
        id originalAD = [bannerAdDict valueForKey:slotID];
        if (originalAD != nil && [originalAD isKindOfClass:[KAAdBanner class]]) {
            ((KAAdBanner *)originalAD).delegate = nil;
            if ([originalAD superview] != nil) {
                [((KAAdBanner *)originalAD) removeFromSuperview];
            }
        }
        
        [bannerAdDict setValue:nil forKey:slotID];
        [bannerDelegateDict setValue:nil forKey:slotID];
        
        KABannerDelegateImpl *adDelegate = [[KABannerDelegateImpl alloc]init];
        [bannerDelegateDict setValue:adDelegate forKey:slotID];
        
        KAAdBanner *banner = [[KAAdBanner alloc] initWithSlot:slotID withSize:bannerSize delegate:adDelegate currentController:UnityGetGLViewController()];
        [bannerAdDict setValue:banner forKey:slotID];
        [banner load];
    }
    
    void doHideBanner(const char *slotIDChar){
        NSString *slotID = [[NSString alloc] initWithUTF8String: slotIDChar];
        id originalAD = [bannerAdDict valueForKey:slotID];
        if (originalAD != nil && [originalAD isKindOfClass:[KAAdBanner class]]) {
            if ([((KAAdBanner *)originalAD) superview] != nil) {
                [originalAD setHidden:YES];
            }
        }
    }
    
    void doSetBannerPosition(const char *slotIDChar,int x,int y){
        NSString *slotID = [[NSString alloc] initWithUTF8String: slotIDChar];
        id originalAD = [bannerAdDict valueForKey:slotID];
        if (originalAD != nil && [originalAD isKindOfClass:[KAAdBanner class]]) {
            [((KAAdBanner *)originalAD) setPosition: CGPointMake(x, y)];
        }
    }
    
    void doRemoveAndDestroyBanner(const char *slotIDChar){
        NSString *slotID = [[NSString alloc] initWithUTF8String: slotIDChar];
        id originalAD = [bannerAdDict valueForKey:slotID];
        if (originalAD != nil && [originalAD isKindOfClass:[KAAdBanner class]]) {
            if ([((KAAdBanner *)originalAD) superview] != nil) {
                [originalAD removeFromSuperview];
            }
        }
    }
    
    char * doGetScreenSize(){
        UIScreen *screen = [UIScreen mainScreen];
        int width = screen.bounds.size.width;
        int height = screen.bounds.size.height;
        NSString *resultString = [NSString stringWithFormat:@"%d#%d",width,height];
        const char * _output = [resultString UTF8String];
        char* resultChar = (char*)malloc(strlen(_output)+1);
        strcpy(resultChar, _output);
        return resultChar;
    }
    
    
}

