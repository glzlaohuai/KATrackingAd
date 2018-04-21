//
//  NativeAdController.h
//  AffiliateSDKSample_NativeAd
//
//  Created by Jason Y Liu on 16/08/2017.
//  Copyright © 2017 Jason Y Liu. All rights reserved.
//

@interface NativeAdController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong) KAAdNative *ad;
@property (nonatomic, strong) UIView *forecover;
@property (nonatomic, strong) NSString *slot, *adtype;
@property (nonatomic, assign) CGPoint touchPoint;

- (void) presentWithAd:(KAAdNative *)ad;

@end
