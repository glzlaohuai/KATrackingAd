//
//  KAAdNative.h
//  Copyright (c) 2015 KA. All rights reserved.
//
@class KAAdNative;

@protocol KAAdNativeDelegate <NSObject>
/**
 * Native ad request is complete with a Native Ad
 */
- (void) nativeAdRequestCompletedWithAd:(nonnull KAAdNative *)nativeAd;

/**
 * Native ad request failed with slot and error describing the reason
 */
- (void) nativeAdRequestFailedForSlot:(nonnull NSString *)nativeAdSlot
                           withStatus:(nonnull NSError *)nativeAdStatus;

@optional

- (void) nativeAdLandingPageDidOpen;

- (void) nativeAdLandingPageDidDismiss;

@end

@interface KAAdNative : NSObject

@property (nonatomic, weak, nullable) id <KAAdNativeDelegate> delegate;
/**
 * The slot ID used to request the native ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ka_slot;
/**
 * The slot ID used to request the native ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ka_requestId;
/**
 * The title of the native ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ka_adTitle;
/**
 * The description of the native ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ka_adDescription;
/**
 * The icon UIImageView.
 */
@property (nonatomic, strong, readonly, nullable) UIImageView *ka_adIconImageView;
/**
 * The image UIImageView.
 */
@property (nonatomic, strong, readonly, nullable) UIImageView *ka_adImageView;

/**
 * Initialize a Native ad with the given SlotId
 * @param nativeSlot The slotId for loading the native ad
 * @param delegate The delegate to receive callbacks from KAAdNative
 */
- (nonnull instancetype) initWithSlot:(nonnull NSString *)nativeSlot
                     delegate:(nonnull id<KAAdNativeDelegate>)delegate;

/**
 * Loads a Native ad
 */
- (void) load;

/**
 * Check if ad is ready to show
 */
- (BOOL) isReady;

/**
 * Report when Native ad is displayed
 */
- (void) nativeAdRenderedWithView:(nonnull UIView *)nativeAdView;

/**
 * Report when Native ad is clicked, return landing page url
 */
- (nonnull NSString *) nativeAdLandingPageAtPoint:(CGPoint)nativeClickPoint;

/**
 * Report and open landing page when Native ad is clicked
 */
- (void) nativeAdClickedAtPointAndOpenLandingPage:(CGPoint)nativeClickPoint;

@end
