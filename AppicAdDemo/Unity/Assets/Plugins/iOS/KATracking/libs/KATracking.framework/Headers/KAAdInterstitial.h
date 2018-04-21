//
//  KAAdInterstitial.h
//  Copyright (c) 2015 Appic. All rights reserved.
//

@class KAAdInterstitial;

@protocol KAAdInterstitialDelegate <NSObject>
@optional
/**
 * Notifies the delegate that the interstitial has finished loading and can be shown instantly.
 * @param interstitialAd The interstitial ad
 */
-(void) interstitialDidFinishLoading:(nonnull KAAdInterstitial*)interstitialAd;
/**
 * Notifies the delegate that the interstitial has failed to load with some error.
 * @param interstitialAdSlot The placementId for which ad has return error
 * @param interstitialAdStatus NSError of describing reason of failure
 */
-(void) interstitialDidFailLoadingForSlot:(nonnull NSString *)interstitialAdSlot
                                WithError:(nonnull NSError *)interstitialAdStatus;
/**
 * Notifies the delegate that the interstitial has been dismissed.
 */
-(void) interstitialDidDismiss:(nonnull KAAdInterstitial*)interstitial;
@end

@interface KAAdInterstitial : NSObject
/**
 * The delegate to receive callbacks
 */
@property (nonatomic, weak, nullable) id<KAAdInterstitialDelegate> delegate;

/**
 * The slot ID used to request the native ad.
 */
@property (nonatomic, strong, readonly, nonnull) NSString *ka_slot;

/**
 * Initialize an Interstitial with the given PlacementId
 * @param interstitialAdSlot The placementId for loading the interstitial
 * @param delegate The delegate to receive callbacks
 */
-(nonnull instancetype)initWithSlot:(nonnull NSString *)interstitialAdSlot
                           delegate:(nonnull id<KAAdInterstitialDelegate>)delegate;
/**
 * Loads an Interstitial
 */
-(void) load;
/**
 * To query if the interstitial is ready to be shown
 */
-(BOOL) isReady;
/**
 * Displays the interstitial on the screen
 * @param viewController this view controller will be used to present interestitial.
 */
-(void) presentFromRootViewController:(nonnull UIViewController *)viewController;

@end

