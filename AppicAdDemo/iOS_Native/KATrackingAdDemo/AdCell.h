//
//  KAAffiliateSDKTestViewCell.h
//  AffiliateSDKSample
//
//  Created by KA on 10/18/16.
//  Copyright © 2016 KA. All rights reserved.
//
#import "NativeAdController.h"

@interface AdCell : UITableViewCell<KAAdNativeDelegate, KAAdInterstitialDelegate, KAAdSplashDelegate, KAAdIncentivizedDelegate>

@property (nonatomic, strong) NSString *slot, *name;
@property (nonatomic, strong) IBOutlet UIButton *button;
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) KAAdNative *native;
@property (nonatomic, strong) KAAdInterstitial *interstitial;
@property (nonatomic, strong) KAAdSplash *splash;
@property (nonatomic, strong) NativeAdController *controller;
@property (nonatomic, assign) BOOL loadingNative, loadingInterstitial, loadingSplash;

- (void) setupWithSlot:(NSString *)slot
               andName:(NSString *)name;

- (void) requestAd;

@end
