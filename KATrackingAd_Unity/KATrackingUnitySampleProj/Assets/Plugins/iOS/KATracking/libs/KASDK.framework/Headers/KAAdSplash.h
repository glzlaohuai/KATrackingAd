//
//  KAAdSplash.h
//  Copyright (c) 2015 Appic. All rights reserved.
//
@class KAAdSplash;

@protocol KAAdSplashDelegate <NSObject>

@optional
/**
 * Splash ad request is complete with a Splash Ad
 */
- (void) splashAdPresentDidSuccess:(nonnull KAAdSplash *)splashAd;

/**
 * Splash ad request failed with slot and error describing the reason
 */
- (void) splashAdPresentDidFail:(nonnull NSString *)splashAdSlot
                      withError:(nonnull NSError *)error;

/**
 * Splash ad has been clicked
 */
- (void) splashAdDidClick:(KAAdSplash *)splashAd;

/**
 * Splash ad has been dismissed
 */
- (void) splashAdDidDismiss:(KAAdSplash *)splashAd;

@end

@interface KAAdSplash : NSObject

/**
 * The delegate to receive callbacks
 */
@property (nonatomic, weak, nullable) id<KAAdSplashDelegate> delegate;

/**
 * The slot ID used to request the Splash ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ka_slot;

/**
 * Initialize a Splash ad with the given SlotId
 * @param splashAdSlot The slotId for loading the Splash ad
 * @param delegate The delegate to receive callbacks from KAAdSplash
 */
- (nonnull instancetype) initWithSlot:(nonnull NSString *)splashAdSlot
                             delegate:(nonnull id<KAAdSplashDelegate>)delegate;

/**
 * Load and Show a Splash ad，background color default black color
 */
- (void) loadAndPresentWithViewController:(UIViewController *) controller;

/**
 * Load and Show a Splash ad
 */
- (void) loadAndPresentWithViewController:(UIViewController *) controller
                       andBackgroundColor:(UIColor *)color
                            andBottomView:(UIView *)bottomView
              andBottomViewAutoFitDisplay:(BOOL)isAutoFitDisplay;

+ (CGSize)getBottomViewSize;

@end
