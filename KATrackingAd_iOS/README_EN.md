> [中文文档](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md)
# Current Ver.3.3
# Integration Guideline

## Preparation
### Download KASDK+Demo.zip [LINK](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/KASDK%2BDemo.zip)
In order to test all ad slots from mediated platforms, please download mediation.zip below, and unzip all frameworks to demo project at location: KATrackingAdDemo/SDK/Mediation/.
### Download Mediation.zip [LINK](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation.zip)

Please add all following framework to your projects
### KASDK framework
* KASDK+Demo.zip - 其中包含：
  * KASDK.framework
  * KAResources.bundle
### Mediation platform frameworks
* Mediation.zip
  * InMobi.framework
  * GoogleMobileAds.framework
  * CTSDK.framework
  * UnityAds.framework
  * VungleSDK.framework
  * GDT
    * libGDTMobSDK.a
  * TalkingData
    * libTalkingData.a

### Dependencies
* SystemConfiguration.framework
* CoreTelephony.framework
* QuartzCore.framework
* GLKit.framework
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
![deployment target](https://github.com/KATracking/KATrackingAd/blob/master/README_Res/ios_deployment_target.png)

### Add the -ObjC linker flag
![linker flag](https://github.com/KATracking/KATrackingAd/blob/master/README_Res/linker_flag.png)

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

### Load Native ad
Simple call this method to load an ad, then wait for delegates to be tricked for load succes or fail
`KAAdNative`
```Objective-c
[ad load];
```

### Properties of Native Ad
Once received request complete delegate call, the ad is ready to use, see following properties and their description

* **ka_slot** - The slot id used to request the Ad
* **ka_requestId** - An string uniquely identified this request of Ad
* **ka_adTitle** - Ad title text
* **ka_adDescription** - Ad text description
* **ka_adIcon** - UIImageView containing the icon image of Ad

### Acquire primary ad view
This method returns a UIView specified by size, which contains the main content of NativeAd.
`KAAdNative`
```Objective-c
UIView *primaryView = [ad primiaryViewOfSize:<size>];
```
* **size** - size of main ad content

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
* **touchPoint** - CGPoint of click coordinates within UIView containing ad content

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

`KAAdIncentivized`
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

`KAAdIncentivizedDelegate`
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

