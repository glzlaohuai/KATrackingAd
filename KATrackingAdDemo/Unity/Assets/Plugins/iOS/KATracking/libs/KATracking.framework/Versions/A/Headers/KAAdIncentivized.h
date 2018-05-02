//
//  KAAdIncentivizedDelegate.h
//  KATracking
//
//  Created by KA on 03/07/2017.
//  Copyright © KA. All rights reserved.
//

@class KAAdIncentivized;

@protocol KAAdIncentivizedDelegate <NSObject>
@optional

- (void) incentivizedAdPresentDidFailWithError:(NSError *)error;

- (void) incentivizedAdPresentDidSuccess;

- (void) incentivizedAdPresentDidComplete;

- (void) incentivizedAdPresentDidSkip;

@end



@interface KAAdIncentivized : NSObject
/**
 * The delegate to receive callbacks
 */

+ (void) setDelegate:(id<KAAdIncentivizedDelegate>) delegate;

+ (BOOL) isReady;

+ (void) presentFromRootViewController:(nonnull UIViewController *) controller;

@end
