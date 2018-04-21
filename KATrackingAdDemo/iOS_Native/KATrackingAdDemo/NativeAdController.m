//
//  NativeAdController.m
//  AffiliateSDKSample_NativeAd
//
//  Created by Jason Y Liu on 16/08/2017.
//  Copyright © 2017 Jason Y Liu. All rights reserved.
//
#import "NativeAdController.h"

@implementation NativeAdController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) presentWithAd:(KAAdNative *)ad{
    self.ad = ad;
    
    UIScreen *screen = [UIScreen mainScreen];
    
    self.view = [[UIView alloc] initWithFrame:screen.bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *backcover = [[UIView alloc] initWithFrame:screen.bounds];
    backcover.userInteractionEnabled = NO;
    backcover.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backcover];
    if(self.ad.ka_adImageView){
        self.ad.ka_adImageView.frame = screen.bounds;
        
        [self.view addSubview:self.ad.ka_adImageView];
    }else if(self.ad.ka_adIconImageView){
        [self.view addSubview:self.ad.ka_adIconImageView];
        self.ad.ka_adIconImageView.center = self.view.center;
    }
    
    self.forecover = [[UIView alloc] initWithFrame:screen.bounds];
    self.forecover.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.forecover];
    
    UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nativeAdTapped:)];
    [self.forecover addGestureRecognizer:tapRecog];
    
    NSURL *bundle_url = [[NSBundle mainBundle] URLForResource:@"KAResources" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundle_url];
    
    UIImage *button_img = [UIImage imageNamed:@"Button_AD_Close.png"
                                     inBundle:bundle
                compatibleWithTraitCollection:nil];
    
    CGRect screen_rect = [[UIScreen mainScreen] bounds];
    
    CGRect button_rect = CGRectMake(self.forecover.frame.size.width - 40, 20, 30, 30);
    
    if(screen_rect.size.width == 375 && screen_rect.size.height == 812){
        button_rect = CGRectMake(self.forecover.frame.size.width - 40, 44, 30, 30);
    }
    
    
    
    UIButton *close_button = [[UIButton alloc] initWithFrame:button_rect];
    [close_button setImage:button_img forState:UIControlStateNormal];
    [close_button addTarget:self action:@selector(nativeAdClosed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.forecover addSubview:close_button];
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.view.center = window.center;
    [window.rootViewController presentViewController:self animated:NO completion:^(){
        NSLog(@"KAAdNative: controller did show");
        [self.ad nativeAdRenderedWithView:self.view];
    }];
}

- (void) nativeAdClosed{
    NSLog(@"KAAdNative: Ad closing");
    [self dismissViewControllerAnimated:NO completion:^(){
        NSLog(@"KAAdNative: Ad closed");
    }];
}

- (void) nativeAdTapped:(UITapGestureRecognizer *)recognizer{
    NSLog(@"KAAdNative: Ad tapped");
    self.touchPoint = [recognizer locationInView:self.view];
//    self.touchPoint = [recognizer locationInView:self.view];
    [self dismissViewControllerAnimated:NO completion:^(){
        [self.ad nativeAdClickedAtPointAndOpenLandingPage:self.touchPoint];
    }];
}
@end
