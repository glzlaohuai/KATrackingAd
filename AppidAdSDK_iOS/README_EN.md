> [中文文档](https://github.com/AppicPlay/AppidAd/blob/master/AppidAdSDK_iOS/README.md)
# Download Links
1. iOS SDK: [Download Ver.3.2](https://github.com/AppicPlay/AppidAd/blob/master/AppidAdSDK_iOS/KATracking-v3.2.zip)
2. Mediation Platform SDK: [Mediation SDK download](https://github.com/AppicPlay/AppidAd/blob/master/AppidAdSDK_iOS/MediationSDK.zip)
3. iOS SDK integration Demo: [Demo Project](https://github.com/AppicPlay/AppidAd/tree/master/AppicAdDemo/iOS_Native)

# Integration Guide

## Before you start
### Adding KATracking
* KATracking.framework
* Resources.bundle

### Adding dependency Frameworks
* SystemConfiguration.framework
* CoreTelephony.framework
* QuartzCode.framework
* AdSupport.framework
* UIKit.framework
* StoreKit.framework
* CoreLocation.framework
* CFNetwork.framework
* CoreMotion.framework
* AVFoundation.framework
* CoreData.framework
* CoreText.framework
* WebKit.framework
* libsqlite3.0.tbd
* libxml2.2.tbd
* libz.tbd

### Setup deployment target to: iOS 8.0
![deployment target](https://github.com/AppicPlay/KATrackingAd/blob/master/README_Res/ios_deployment_target.png)

### Add the -ObjC linker flag
![linker flag](https://github.com/AppicPlay/KATrackingAd/blob/master/README_Res/linker_flag.png)

## Let's code!

### SDK initialization
Please initialize SDK as early into app lifecycle as possible, as once SDK initilized it will automatically pre-cashe ads.

`AppDelegate`
```Objective-c
#import <KATracking/KASDK.h>
```
`AppDelegate : application:didFinishLaunchingWithOptions:`
```Objective-c
[[KATracking sharedInstance] initWithAppId:@"<AppId>" channel:@"<AppChannel>"];
```
Provided by operator
* **AppId** - Application ID
* **AppChannel** - Application distribution channel

# Native Ad

### Create a Native Ad
To create a Native ad instance

`KAAdNative`
```Objective-c
KAAdNative *ad = [[KAAdNative alloc] initWithSlot:<AdSlot> delegate:<Delegate>];
```
* **AdSlot** - Slot ID to request ad with
* **Delegate** - id<KAAdNativeDelegate> object to receive delegate calls

To load the Ad

`KAAdNative`
```Objective-c
[ad load];
```

Test availability of the Ad

`KAAdNative`
```Objective-c
BOOL ready = [ad isReady];
```

### Report an impression
Once the ad has been displayed

`KAAdNative`
```Objective-c
[ad nativeAdRenderedWithView:adView];
```

* **adView** - the UIView containing ad content

### Report a click
Once user did click on Ad, use one of the following two methods to report click event

`KAAdNative`
```Objective-c
[ad nativeAdClickedAtPointAndOpenLandingPage:touchPoint];
```
This is <span style="color:red">HIGHLY RECOMMANDED</span> to let SDK handle showing landing page

**OR**

`KAAdNative`
```Objective-c
NSString *landingpage = [ad nativeAdClickedAtPoint:touchPoint];
```

* **touchPoint** - CGPoint of click coordinates within UIView containing ad content
* **landingPage** - URL string for showing ad landing page

### Properties of Native Ad
Once received request complete delegate call, the ad is ready to use, see following properties and their description

* **ka_slot** - The slot id used to request the Ad
* **ka_requestId** - An string uniquely identified this request of Ad
* **ka_adTitle** - Ad title text
* **ka_adDescription** - Ad text description
* **ka_adIconImageView** - UIImageView containing the icon image of Ad
* **ka_adImageView** - UIImageView containing the screenshot image of Ad

### Delegates of Native Ad
Use these delegates to receive events of request native ad complete or fail

`KAAdNativeDelegate`
```Objective-c
// Request has completed with nativeAd
- (void) nativeAdRequestCompletedWithAd:(nonnull KAAdNative *)nativeAd;

// Request has failed
- (void) nativeAdRequestFailedForSlot:(nonnull NSString *)nativeAdSlot
                           withStatus:(nonnull NSError *)nativeAdStatus;
```

# Splash Ad

### Create a Splash Ad
To create a Splash ad instance

`KAAdSplash`
```Objective-c
KAAdSplash *splash = [[KAAdSplash alloc] initWithSlot:<AdSlot> delegate:<Delegate>];
```
* **AdSlot** - Slot ID to request ad with
* **Delegate** - id<KAAdSplashDelegate> object to receive delegate calls

### Present a Splash Ad
To load and present Splash Ad

`KAAdSplash`
```Objective-c
[splash loadAndPresentWithViewController:<Controller>];
```

* **Controller** - UIViewController for which the splash is presented from

### Delegates of Splash Ad
Use these delegates to receive events of splash Ad

`KAAdSplashDelegate`
```Objective-c
// Ad is successfully presented
- (void) splashAdPresentDidSuccess:(nonnull KAAdSplash *)splashAd;

// Ad present has failed
- (void) splashAdPresentDidFail:(nonnull NSString *)splashAdSlot
                      withError:(nonnull NSError *)error;

// Ad has been clicked
- (void) splashAdDidClick:(KAAdSplash *)splashAd;

// Ad view has been dismissed from screen
- (void) splashAdDidDismiss:(KAAdSplash *)splashAd;
```

# Interstitial Ad

### Create a Interstitial Ad
To create a Interstitial ad instance

`KAAdInterstitial`
```Objective-c
KAAdInterstitial *interstitial = [[KAAdInterstitial alloc] initWithSlot:<AdSlot> delegate:<Delegate>];
```
* **AdSlot** - Slot ID to request ad with
* **Delegate** - id<KAAdInterstitialDelegate> object to receive delegate calls

To load an interstitial Ad

`KAAdInterstitial`
```Objective-c
[interstitial load];
```

Test availability of the Ad

`KAAdInterstitial`
```Objective-c
BOOL ready = [interstitial isReady];
```

### Present a Interstitial Ad
To load and present Interstitial Ad

`KAAdInterstitial`
```Objective-c
[interstitial presentFromRootViewController:<Controller>];
```

* **Controller** - UIViewController for which the Interstitial is presented from

### Delegates of Interstitial Ad
Use these delegates to receive events of Interstitial Ad

`KAAdInterstitialDelegate`
```Objective-c
// Interstitial Ad load success
- (void) interstitialAdLoadDidSuccess:(nonnull KAAdInterstitial *) interstitialAd;

// Interstitial Ad load fail
- (void) interstitialAdLoadDidFailForSlot:(nonnull NSString *) interstitialAdSlot
                                withError:(nonnull NSError *) interstitialAdStatus;

// Interstitial Ad presented successful
- (void) interstitialAdDidPresent:(nonnull KAAdInterstitial *) interstitial;


// Interstitial Ad has been clicked
- (void) interstitialAdDidClick:(nonnull KAAdInterstitial *) splashAd;

// Interstitial Ad has been dismissed from screen
```

# Incentivized Video Ad

### How does it work
Incentivized video ads are automatically fetched and preparing as soon as SDK is initialized, `KAAdIncentivized` is a singleton object, there is no need to create any instance of it.

Test availability of the Ad

`KAAdIncentivized`
```Objective-c
BOOL ready = [KAAdIncentivized isReady];
```

### Present a Incentivized video Ad

`KAAdInterstitial`
```Objective-c
[KAAdIncentivized presentFromRootViewController:<Controller>];
```

* **Controller** - UIViewController for which the Incentivized video Ad is presented from

### Delegates of Incentivized video Ad
To set a delegate to receive events

`KAAdIncentivized`
```Objective-c
[KAAdIncentivized setDelegate:<Delegate>];
```

* **Delegate** - The id<KAAdIncentivizedDelegate> object
Use these delegates to receive events of Incentivized video Ad
  
`KAAdSplashDelegate`
```Objective-c
// Incentvized video Ad has failed to present
- (void) incentivizedAdPresentDidFailWithError:(NSError *)error;

// Incentivized video Ad has presented successful
- (void) incentivizedAdPresentDidSuccess;

// Incentivized video Ad has complete without skip 
- (void) incentivizedAdPresentDidComplete;

// Incentivized video Ad has complete with skip 
- (void) incentivizedAdPresentDidSkip;
```
