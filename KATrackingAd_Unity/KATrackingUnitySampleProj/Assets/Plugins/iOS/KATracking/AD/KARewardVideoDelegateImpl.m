//
//  KARewardVideoDelegateImpl.m
//  DOTest
//
//  Created by glzlaohuai on 2018/4/28.
//  Copyright © 2018年 glzlaohuai. All rights reserved.
//

#import "KARewardVideoDelegateImpl.h"
#import "UnityInterface.h"
#import "KATrackingUnityConstants.h"

@implementation KARewardVideoDelegateImpl

-(void)incentivizedAdPresentDidSkip{
    NSLog(@"oc端incentivizedAdPresentDidSkip...");
    UnitySendMessage(GAME_OBJ_NAME, "csIncentivizedAdPresentDidSkip","");

}

- (void)incentivizedAdPresentDidSuccess{
    NSLog(@"oc端incentivizedAdPresentDidSuccess...");
    UnitySendMessage(GAME_OBJ_NAME, "csIncentivizedAdPresentDidSuccess","");
}

- (void)incentivizedAdPresentDidComplete{
    NSLog(@"oc端incentivizedAdPresentDidComplete...");
    UnitySendMessage(GAME_OBJ_NAME, "csIncentivizedAdPresentDidComplete","");
}

- (void)incentivizedAdPresentDidFailWithError:(NSError *)error{
    NSLog(@"oc端incentivizedAdPresentDidFailWithError...");
    UnitySendMessage(GAME_OBJ_NAME, "csIncentivizedAdPresentDidFailWithError", [[error localizedDescription]UTF8String]);
}
@end
