//
//  VolumeController.m
//  VolumeController
//
//  Created by glzlaohuai on 2018/4/24.
//  Copyright © 2018年 glzlaohuai. All rights reserved.
//

#import "KATrackingAdobeLib.h"
#import "KAAdobeConstants.h"

#import "KAAdobeInterstitialDelegate.h"
#import "KAAdobeSplashDelegate.h"
#import "KAAdobeRewardVideoDelegate.h"

static NSMutableDictionary *adDictionary;
static NSMutableDictionary *delegateDictionary;

static KAAdobeRewardVideoDelegate *rewardDelegate;

static FREContext eventContext;

NSString * getStringFromFREObject(FREObject obj) {
    uint32_t length;
    const uint8_t *value;
    FREGetObjectAsUTF8(obj, &length, &value);
    return [NSString stringWithUTF8String:(const char *)value];
}

FREObject createFREBool(BOOL value)
{
    FREObject freObject;
    FRENewObjectFromBool(value, &freObject);
    return freObject;
}


void dispatchADEvent(NSString *adType,NSString *adEvent,NSString *slotID,NSString *msg){
    if (eventContext != NULL) {
        
        NSString *levelString = [[[[adEvent stringByAppendingString:@"#"] stringByAppendingString:slotID]stringByAppendingString:@"#"] stringByAppendingString:msg];
        
        const uint8_t* code = (const uint8_t*) [adType UTF8String];
        const uint8_t* level = (const uint8_t*) [levelString UTF8String];
        
        FREDispatchStatusEventAsync(eventContext, code, level);
    }
}

void adobeLog(NSString *msg) {
    if (eventContext == NULL) {
        return;
    }
    NSString *eventName = @"LogPrint";
    const uint8_t* logMsg = (const uint8_t*) [msg UTF8String];
    const uint8_t* eventCode = (const uint8_t*) [eventName UTF8String];
    FREDispatchStatusEventAsync(eventContext, eventCode, logMsg);
}


id makeADInstanceWithADType(NSString *adType, NSString *slotID){
    
    if ([adType isEqualToString:AD_INTERSTITIAL]) {
        adobeLog(@"创建插屏实例...");
        if (delegateDictionary == nil) {
            delegateDictionary = [NSMutableDictionary dictionary];
        }
        KAAdobeInterstitialDelegate *delegate = [[KAAdobeInterstitialDelegate alloc]init];
        [delegateDictionary setValue:delegate forKey:slotID];
        KAAdInterstitial *interstitial = [[KAAdInterstitial alloc]initWithSlot:slotID delegate:delegate];
        return interstitial;
    }
    
    if ([adType isEqualToString:AD_SPLASH]) {
        adobeLog(@"创建开屏实例...");
        if (delegateDictionary == nil) {
            delegateDictionary = [NSMutableDictionary dictionary];
        }
        KAAdobeSplashDelegate *delegate = [[KAAdobeSplashDelegate alloc]init];
        [delegateDictionary setValue:delegate forKey:slotID];
        KAAdSplash *splash = [[KAAdSplash alloc]initWithSlot:slotID delegate:delegate];
        return splash;
    }
    return nil;
}

void mapSlotWithADInstance(NSString *adType, NSString *slotID){
    if (adDictionary == nil) {
        adDictionary = [NSMutableDictionary dictionary];
    }
    
    [adDictionary setValue:nil forKey:slotID];
    
    id adInstance = [adDictionary valueForKey:slotID];
    if (adInstance == nil) {
        adInstance = makeADInstanceWithADType(adType, slotID);
    }
    
    if (adInstance != nil) {
        [adDictionary setValue:adInstance forKey:slotID];
        
        if ([adInstance isKindOfClass:[KAAdInterstitial class]]) {
            [((KAAdInterstitial *)adInstance) load];
            adobeLog(@"插屏开始进行load...");
        }
        
        if ([adInstance isKindOfClass:[KAAdSplash class]]) {
            adobeLog(@"开屏开始进行load&展示...");
            [((KAAdSplash *)adInstance) loadAndPresentWithViewController:[[[UIApplication sharedApplication] keyWindow] rootViewController]];
        }
    }
}

FREObject init(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    eventContext = ctx;
    adobeLog(@"oc端执行init...");
    NSString *appID = getStringFromFREObject(argv[0]);
    NSString *channelID = getStringFromFREObject(argv[1]);
    [[KATracking sharedInstance]initWithAppId:appID channel:channelID];
    
    if (rewardDelegate == nil) {
        rewardDelegate = [[KAAdobeRewardVideoDelegate alloc]init];
        [KAAdIncentivized setDelegate:rewardDelegate];
    }
    
    return NULL;
}

FREObject loadInterstitial(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    eventContext = ctx;
    adobeLog(@"oc端执行loadInterstitial...");
    
    NSString *slotID = getStringFromFREObject(argv[0]);
    NSString *adType = AD_INTERSTITIAL;
    mapSlotWithADInstance(adType,slotID);
    
    return NULL;
}

FREObject presentSplash(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    eventContext = ctx;
    adobeLog(@"oc端执行presentSplash...");
    
    NSString *slotID = getStringFromFREObject(argv[0]);
    NSString *adType = AD_SPLASH;
    mapSlotWithADInstance(adType,slotID);
    
    return NULL;
}

FREObject loadRewardVideo(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    eventContext = ctx;
    adobeLog(@"sdk will auto load reward video for you, this method has no function yet.");
    
    return NULL;
}

FREObject isInterstitialReady(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    eventContext = ctx;
    adobeLog(@"oc端执行isInterstitialReady...");
    
    NSString *slotID = getStringFromFREObject(argv[0]);
    if (adDictionary == nil) {
        return createFREBool(NO);
    }
    id adInstance = [adDictionary valueForKey:slotID];
    
    if (adInstance == nil) {
        return createFREBool(NO);
    }else{
        if ([adInstance isKindOfClass:[KAAdInterstitial class]]) {
            return createFREBool([((KAAdInterstitial *)adInstance) isReady]);
        }
        
        return createFREBool(NO);
    }
    return createFREBool(NO);
}

FREObject isRewardVideoADReady(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    eventContext = ctx;
    adobeLog(@"oc端执行isRewardVideoADReady...");
    return createFREBool([KAAdIncentivized isReady]);
}

FREObject showInterstitial(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    eventContext = ctx;
    adobeLog(@"oc端执行showInterstitial...");
    
    NSString *slotID = getStringFromFREObject(argv[0]);
    if (adDictionary == nil) {
        return NULL;
    }
    
    id adInstance = [adDictionary valueForKey:slotID];
    if (adInstance != nil) {
        if ([adInstance isKindOfClass:[KAAdInterstitial class]]) {
            
            if ([((KAAdInterstitial *)adInstance) isReady]) {
                [((KAAdInterstitial *)adInstance) presentFromRootViewController: [[[UIApplication sharedApplication] keyWindow] rootViewController]];
                [adDictionary setValue:nil forKey:slotID];
            }
            
        }
    }
    return NULL;
}

FREObject showRewardVideo(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    eventContext = ctx;
    adobeLog(@"oc端执行showRewardVideo...");
    
    if ([KAAdIncentivized isReady]) {
        [KAAdIncentivized presentFromRootViewController: [[[UIApplication sharedApplication] keyWindow] rootViewController]];
    }else{
        adobeLog(@"激励视频广告未准备好...");
    }
    return NULL;
}


//在创建context之时将执行该方法
void KATrackingExtContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet){
    
    adobeLog(@"oc端执行context初始化方法：KATrackingExtContextInitializer...");
    
    *numFunctionsToTest = 8;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * *numFunctionsToTest);
    
    func[0].name = (const uint8_t*) "init";
    func[0].functionData = NULL;
    func[0].function = &init;
    
    func[1].name = (const uint8_t*) "loadInterstitial";
    func[1].functionData = NULL;
    func[1].function = &loadInterstitial;
    
    func[2].name = (const uint8_t*) "presentSplash";
    func[2].functionData = NULL;
    func[2].function = &presentSplash;
    
    func[3].name = (const uint8_t*) "loadRewardVideo";
    func[3].functionData = NULL;
    func[3].function = &loadRewardVideo;
    
    func[4].name = (const uint8_t*) "isInterstitialReady";
    func[4].functionData = NULL;
    func[4].function = &isInterstitialReady;
    
    func[5].name = (const uint8_t*) "isRewardVideoADReady";
    func[5].functionData = NULL;
    func[5].function = &isRewardVideoADReady;
    
    func[6].name = (const uint8_t*) "showInterstitial";
    func[6].functionData = NULL;
    func[6].function = &showInterstitial;
    
    func[7].name = (const uint8_t*) "showRewardVideo";
    func[7].functionData = NULL;
    func[7].function = &showRewardVideo;
    
    *functionsToSet = func;
}


void KATrackingExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet){
    
    adobeLog(@"oc端的入口方法(声明在xml中的方法)被调用...");
    
    *extDataToSet = NULL;
    *ctxInitializerToSet = &KATrackingExtContextInitializer;
}
