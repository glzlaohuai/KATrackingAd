//
//  KAAdNative.h
//  Copyright (c) 2015 KA. All rights reserved.
//
@class KAAdBanner;

typedef NS_ENUM(NSUInteger, KAAdBannerSize) {
    KAAdBannerSize320x50        = 1, // => 320 x 50 iPhone Portrait
    KAAdBannerSize468x60, // => 468 x 60 iPad Portrait
    KAAdBannerSize728x90 // = > 728 x 90 iPad Portrait
};

@protocol KAAdBannerDelegate <NSObject>
@optional
/**
 * Notifies the delegate that the banner has finished loading
 */
- (void) bannerAdCompleteLoadingWithAd:(nonnull KAAdBanner *)bannerAd;
/**
 * Notifies the delegate that the banner has failed to load with some error.
 */
- (void) bannerAdFailedLoadingForSlot:(nonnull NSString *)adSlot
                           withStatus:(nonnull NSError *)nativeAdStatus
                            andBanner:(nonnull KAAdBanner *)bannerAd;
/**
 * Notifies the delegate that the banner has finished presenting screen.
 */
- (void) bannerDidPresentScreen:(nonnull KAAdBanner *)bannerAd;

/**
 * Notifies the delegate that the banner has dismissed the presented screen.
 */
- (void) bannerDidDismissScreen:(nonnull KAAdBanner *)bannerAd;
@end


@interface KAAdBanner : UIView
/**
 * The slot ID used to request the native ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ka_slot;

@property (nonatomic, weak) id<KAAdBannerDelegate> delegate;

/**
 * Initializes an IMBanner instance with the specified placementId and delegate.
 * @param adSlot  the placement Id registered on the InMobi portal.
 * @param delegate The delegate to receive callbacks
 */
- (nonnull instancetype) initWithSlot:(nonnull NSString *)adSlot
                             withSize:(KAAdBannerSize)size
                             delegate:(id<KAAdBannerDelegate>)delegate
                    currentController:(nonnull UIViewController *)controller;
/**
 * @param position CGPoint for this view center.
 */
- (void)setPosition:(CGPoint)position;

/**
 * Loads a banner for specific slot.
 */
- (void) load;

/**
 * The transition animation to be performed between refreshes.
 */
- (void) displayBanner;

/**
 * Dismiss currently showing banner ad
 */
- (void) dismissBanner;

/**
 * banner Size
 */
- (CGSize)getSize;

@end
