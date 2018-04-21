//
//  KAAffiliateSDKTestViewCell.m
//  AffiliateSDKSample
//
//  Created by KA on 10/18/16.
//  Copyright © 2016 KA. All rights reserved.
//
#import "AdCell.h"

@implementation AdCell

- (void) setupWithSlot:(NSString *)slot
               andName:(NSString *)name{
    self.slot = slot;
    self.name = name;
    if([self.name isEqualToString:@"Incentivized"]){
        [NSTimer scheduledTimerWithTimeInterval:0.25f
                                         target:self
                                       selector:@selector(refresh)
                                       userInfo:nil
                                        repeats:YES];
        self.label.text = [NSString stringWithFormat:@"%@", name];
        [KAAdIncentivized setDelegate:self];
    }else{
        self.label.text = [NSString stringWithFormat:@"%@ - Request AD", name];
    }
}

- (void) setLoadingNative:(BOOL)loadingNative{
    _loadingNative = loadingNative;
}

- (IBAction) buttonClick:(id)sender{
    if([self.name isEqualToString:@"Native"]){
        if(!self.loadingNative){
            if(self.native){
                self.controller = [[NativeAdController alloc] init];
                [self.controller presentWithAd:self.native];
                self.native = nil;
                self.label.text = [NSString stringWithFormat:@"%@ - Request AD", self.name];
            }else{
                [self requestAd];
            }
        }
    }else if([self.name isEqualToString:@"Interstitial"]){
        if(!self.loadingInterstitial){
            if(self.interstitial){
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                [self.interstitial presentFromRootViewController:window.rootViewController];
            }else{
                [self requestAd];
            }
        }
    }else if([self.name isEqualToString:@"Splash"]){
        if(!self.loadingSplash){
            [self requestAd];
        }
    }else if([self.name isEqualToString:@"Incentivized"]){
        if([KAAdIncentivized isReady]){
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [KAAdIncentivized presentFromRootViewController:window.rootViewController];
        }
    }
}

- (void) refresh{
    if([KAAdIncentivized isReady]){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.label.text = [NSString stringWithFormat:@"%@ - Ready", self.name];
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.label.text = [NSString stringWithFormat:@"%@ - Loading", self.name];
        });
    }
}

- (void) requestAd{
    self.label.text = [NSString stringWithFormat:@"%@ - Loading", self.name];
    if([self.name isEqualToString:@"Native"]){
        self.loadingNative = YES;
        self.native = [[KAAdNative alloc] initWithSlot:self.slot delegate:self];
        [self.native load];
    }else if([self.name isEqualToString:@"Interstitial"]){
        self.loadingInterstitial = YES;
        self.interstitial = [[KAAdInterstitial alloc]  initWithSlot:self.slot delegate:self];
        [self.interstitial load];
    }else if([self.name isEqualToString:@"Splash"]){
        self.loadingSplash = YES;
        self.splash = [[KAAdSplash alloc] initWithSlot:self.slot delegate:self];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [self.splash loadAndPresentWithViewController:window.rootViewController];
    }
}

#pragma Incentivized

- (void) incentivizedAdPresentDidFailWithError:(NSError *)error{
    NSLog(@"Incentvized Ad present fail with error = %@", error);
}

- (void) incentivizedAdPresentDidSuccess{
    NSLog(@"Incentivized Ad present sucess");
}

- (void) incentivizedAdPresentDidComplete{
    NSLog(@"Incentivized Ad present Complete");
}

- (void) incentivizedAdPresentDidSkip{
    NSLog(@"Incentivized Ad present Skip");
}

#pragma Interstitial

-(void) interstitialAdLoadDidSuccess:(nonnull KAAdInterstitial*)interstitialAd{
    NSLog(@"Interstitial Ad received");
    self.interstitial = interstitialAd;
    self.label.text = [NSString stringWithFormat:@"%@ - Success, Show AD", self.name];
    self.loadingInterstitial = NO;
}

- (void) interstitialAdLoadDidFailForSlot:(nonnull NSString *) interstitialAdSlot
                                withError:(nonnull NSError *) interstitialAdStatus{
    NSLog(@"Interstitial Ad failed to receive, error = %@", interstitialAdStatus);
    self.interstitial = nil;
    self.label.text = [NSString stringWithFormat:@"%@ - Fail，Request AD", self.name];
    self.loadingInterstitial = NO;
}

-(void) interstitialAdDidPresent:(nonnull KAAdInterstitial *)interstitial{
    NSLog(@"Interstitial Ad did present");
}

- (void) interstitialAdDidClick:(nonnull KAAdInterstitial *)splashAd{
    NSLog(@"Interstitial Ad did click");
}

-(void) interstitialAdDidDismiss:(nonnull KAAdInterstitial*)interstitial{
    NSLog(@"Interstitial Ad did dismiss");
    self.interstitial = nil;
    self.label.text = [NSString stringWithFormat:@"%@ - Request AD", self.name];
}

#pragma Native

- (void) nativeAdRequestCompletedWithAd:(nonnull KAAdNative *)nativeAd{
    NSLog(@"Native Ad received");
    self.native = nativeAd;
    self.label.text = [NSString stringWithFormat:@"%@ - Success, Show AD", self.name];
    self.loadingNative = NO;
}

- (void) nativeAdRequestFailedForSlot:(nonnull NSString *)nativeAdSlot
                           withStatus:(nonnull NSError *)nativeAdStatus{
    NSLog(@"Native Ad failed to receive, error = %@", nativeAdStatus);
    self.native = nil;
    self.label.text = [NSString stringWithFormat:@"%@ - Fail，Request AD", self.name];
    self.loadingNative = NO;
}

- (void) nativeAdLandingPageDidOpen{
    NSLog(@"Native Ad landing page did open");
}

- (void) nativeAdLandingPageDidDismiss{
    NSLog(@"Native Ad landing page did dismiss");
}

#pragma Splash

- (void) splashAdPresentDidSuccess:(nonnull KAAdSplash *)splashAd{
    self.loadingSplash = NO;
    NSLog(@"Splash present success");
}

/**
 * Splash ad request failed with slot and error describing the reason
 */
- (void) splashAdPresentDidFail:(nonnull NSString *)splashAdSlot
                      withError:(nonnull NSError *)error{
    self.splash = nil;
    self.label.text = [NSString stringWithFormat:@"%@ - Fail，Request AD", self.name];
    self.loadingSplash = NO;
    NSLog(@"Splash present fail, error = %@", error);
}

/**
 * Splash ad has been clicked
 */
- (void) splashAdDidClick:(KAAdSplash *)splashAd{
    NSLog(@"Splash clicked");
}

/**
 * Splash ad has been dismissed
 */
- (void) splashAdDidDismiss:(KAAdSplash *)splashAd;{
    NSLog(@"Splash dismissed");
    self.splash = nil;
    self.label.text = [NSString stringWithFormat:@"%@ - Request AD", self.name];
}

@end
