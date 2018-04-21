//
//  Test.m
//  KATrackingAd_Demo
//
//  Created by glzlaohuai on 2018/3/20.
//  Copyright © 2018年 Jason Y Liu. All rights reserved.
//

#import <KATracking/KATracking.h>
#import <KATracking/KAAdInterstitial.h>
#import "KAInterstitialDelegateImpl.h"
//#import "OpenWebViewController.h"

static NSString *nowLoadSlotID;
KAAdInterstitial *nowLoadInterstitial;
static KAInterstitialDelegateImpl *delegate = [[KAInterstitialDelegateImpl alloc]init];

extern "C"{
    void doInit(const char* appID,const char* appChannel){
        NSString* appIDStr = [[NSString alloc] initWithUTF8String: appID];
        NSString* appChannelStr = [[NSString alloc] initWithUTF8String: appChannel];
        [[KATracking sharedInstance] initWithAppId:appIDStr channel:appChannelStr];
    }
    
    void doLoadInterstitial(const char* slotID){
        nowLoadSlotID = [[NSString alloc] initWithUTF8String: slotID];
        nowLoadInterstitial = [[KAAdInterstitial alloc] initWithSlot:nowLoadSlotID delegate:delegate];
        [nowLoadInterstitial load];
    }
    
    void doShowInterstitial(const char* slotID){
        NSString *showedSlotID = [[NSString alloc] initWithUTF8String: slotID];
        if (showedSlotID == nowLoadSlotID && showedSlotID != nil && nowLoadInterstitial != nil && nowLoadInterstitial.isReady) {
            UIViewController *unityRootVC = UnityGetGLViewController();
            [nowLoadInterstitial presentFromRootViewController:unityRootVC];
        }
    }
    
    bool doCheckIsInterstitialAvaliable(const char* slotID){
        if(nowLoadInterstitial != nil){
            return nowLoadInterstitial.isReady;
        }else{
            return false;
        }
    }
}

