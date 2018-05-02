//
//  Test.m
//  KATrackingAd_Demo
//
//  Created by glzlaohuai on 2018/3/20.
//  Copyright © 2018年 Jason Y Liu. All rights reserved.
//

#import <KATracking/KATracking.h>
#import "KAInterstitialDelegateImpl.h"
#import <UIKit/UIKit.h>
#import "UnityInterface.h"
#import <KATracking/KAAdSplash.h>
#import "KASplashDelegateimpl.h"
#import <KATracking/KAAdIncentivized.h>
#import "KARewardVideoDelegateImpl.h"

static NSMutableDictionary *adDict = [NSMutableDictionary dictionary];
static NSMutableDictionary *delegateDict = [NSMutableDictionary dictionary];
static KARewardVideoDelegateImpl *rewardDelegate;

extern "C"{
    
    void doInit(const char* appID,const char* appChannel){
        NSString* appIDStr = [[NSString alloc] initWithUTF8String: appID];
        NSString* appChannelStr = [[NSString alloc] initWithUTF8String: appChannel];
        [[KATracking sharedInstance] initWithAppId:appIDStr channel:appChannelStr];
    }
    
    void doLoadInterstitial(const char* slotIDChar){
        NSString *slotID = [[NSString alloc] initWithUTF8String: slotIDChar];
        
        [adDict setValue:nil forKey:slotID];
        [delegateDict setValue:nil forKey:slotID];
        
        KAInterstitialDelegateImpl *adDelegate = [[KAInterstitialDelegateImpl alloc]init];
        [delegateDict setValue:adDelegate forKey:slotID];
        
        KAAdInterstitial *interstitial = [[KAAdInterstitial alloc]initWithSlot:slotID delegate:adDelegate];
        [adDict setValue:interstitial forKey:slotID];
        [interstitial load];
    }
    
    void doShowInterstitial(const char* slotIDChar){
         NSString *slotID = [[NSString alloc] initWithUTF8String: slotIDChar];
        id adInstance = [adDict valueForKey:slotID];
        if (adInstance != nil && [adInstance isKindOfClass:[KAAdInterstitial class]] && [adInstance isReady]) {
            [((KAAdInterstitial *)adInstance) presentFromRootViewController: UnityGetGLViewController()];
        }
    }
    
    bool doCheckIsInterstitialAvaliable(const char* slotIDChar){
        NSString *slotID = [[NSString alloc] initWithUTF8String: slotIDChar];
        id adInstance = [adDict valueForKey:slotID];
        return (adInstance != nil)&&([adInstance isKindOfClass:[KAAdInterstitial class]])&&[adInstance isReady];
    }
    
    void doShowSplash(const char* slotIDChar){
        NSString *slotID = [[NSString alloc] initWithUTF8String: slotIDChar];
        
        [adDict setValue:nil forKey:slotID];
        [delegateDict setValue:nil forKey:slotID];

        KASplashDelegateimpl *delegate = [[KASplashDelegateimpl alloc]init];
        [delegateDict setValue:delegate forKey:slotID];
        
        KAAdSplash *splash = [[KAAdSplash alloc]initWithSlot:slotID delegate: delegate];
        [adDict setValue:splash forKey:slotID];
        [splash loadAndPresentWithViewController: UnityGetGLViewController()];
    }
    
    void doLoadRewardVideo(){
        NSLog(@"oc端doLoadRewardVideo");
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
        NSLog(@"oc端doShowRewardVideo...");
        if ([KAAdIncentivized isReady]) {
            [KAAdIncentivized presentFromRootViewController: UnityGetGLViewController()];
        }else{
            NSLog(@"没有加载完毕的video...");
        }
    }
    
    bool doCheckIsRewardVideoAvaliable(){
        bool isOK = [KAAdIncentivized isReady];
        NSLog(@"oc端检查视频广告是否可用,%d",isOK);
        return isOK;
    }
    
    
    
    
    
}

