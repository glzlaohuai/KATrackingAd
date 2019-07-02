//
//  KAUtilDelegateImpl.m
//  Unity-iPhone
//
//  Created by 刘立峰 on 2019/7/2.
//

#import "KAUtilDelegateImpl.h"
#import "UnityInterface.h"
#import "KATrackingUnityConstants.h"

@implementation KAUtilDelegateImpl

- (void)sdkInitiate:(BOOL)isInitiate currentCountry:(nonnull NSString *)country {
    NSString *initResult = isInitiate ? @"true" : @"false";
    NSString *msg = [[initResult stringByAppendingString:@"#"] stringByAppendingString:country];
    UnitySendMessage(GAME_OBJ_NAME, "csSDKInitiateResult", [msg UTF8String]);
}

@end
