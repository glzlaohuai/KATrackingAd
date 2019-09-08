# Integration Guideline
   
### Required libs and frameworks
Please add the following libs and frameworks to your projects

* SystemConfiguration.framework
* CoreTelephony.framework
* QuartzCore.framework
* GLKit.framework
* AdSupport.framework
* UIKit.framework
* StoreKit.framework
* CoreLocation.framework（optional）
* CFNetwork.framework
* CoreMotion.framework
* AVFoundation.framework
* CoreData.framework
* CoreText.framework
* WebKit.framework
* JavaScriptCore.framework
* libsqlite3.0.tbd
* libxml2.2.tbd
* libz.tbd
* libc++.tbd

### URLScheme whitelist
Please add the following URLSchemes to info.plist

```XML
	<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>dianping</string>
		<string>imeituan</string>
		<string>com.suning.SuningEBuy</string>
		<string>openapp.jdmobile</string>
		<string>vipshop</string>
		<string>snssdk141</string>
		<string>ctrip</string>
		<string>suning</string>
		<string>qunariphone</string>
		<string>QunarAlipay</string>
		<string>qunaraphone</string>
		<string>yohobuy</string>
		<string>kaola</string>
		<string>agoda</string>
		<string>openapp.xzdz</string>
		<string>beibeiapp</string>
		<string>taobao</string>
		<string>tmall</string>
		<string>openjd</string>
		<string>jhs</string>
		<string>yhd</string>
		<string>wireless1688</string>
		<string>GomeEShop</string>
		<string>wbmain</string>
		<string>xhsdiscover</string>
		<string>douyin</string>
		<string>pinduoduo</string>
		<string>jdmobile</string>
		<string>tbopen</string>
		<string>pddopen</string>
		<string>mogujie</string>
		<string>koubei</string>
		<string>eleme</string>
	</array>
```


### Minimum deployment target: iOS 8.0
![deployment target](https://github.com/KATracking/KATrackingAd/blob/master/AppicAd_IQZone/ios_deployment_target.png)

### Add linker flag: -ObjC
![linker flag](https://github.com/KATracking/KATrackingAd/blob/master/AppicAd_IQZone/linker_flag.png)

### Setup ATS
![linker flag](https://github.com/KATracking/KATrackingAd/blob/master/AppicAd_IQZone/ats.png)

## Let's code!

### SDK initialization
Please initialize SDK as early into app lifecycle as possible, as once SDK initilized it will automatically pre-cashe ads.

`AppDelegate`

```Objective-c
#import "KASDK.h"
```
`AppDelegate : application:didFinishLaunchingWithOptions:`

```Objective-c
[[KATracking sharedInstance] initWithAppId:@"<AppId>" channel:@"<AppChannel>"];
```
Provided to each App integration

* **AppId** - Application ID
* **AppChannel** - Application distribution channel

# Native ad - NativeExpress

### Instantiation of ad
Create an instance of a NativeExpress
`APIQZoneAdNativeExpress`

```Objective-c
APIQZoneAdNativeExpress *ad = [[APIQZoneAdNativeExpress alloc] initWithSlot:<AdSlot> delegate:<Delegate>];
```
* **AdSlot** - Slot ID to request ad with, provided per placement
* **Delegate** - id<APIQZoneAdNativeExpressDelegate> object to receive delegate calls

### Load NativeExpress
Once created instance of NativeExpress, call load to request ad, delegates will inform the success or fail events

`APIQZoneAdNativeExpress `

```Objective-c
[ad load];
```

### Properties of NativeExpress
Each native ad also have the following properties 

* **ka_slot** - SlotId of the ad slot
* **ka_adTitle** - Ad title text
* **ka_adDescription** - Ad text description
* **ka_adIcon** - UIImageView containing the icon image of Ad
* **ka_adScreenShots** - UIImageView containing the big picture of Ad

### Register impression view
All UIViews used to show NativeExpress ads must be registered with this method to properly report click event to ad server.

`APIQZoneAdNativeExpress`

```Objective-c
- (BOOL)registerContainer:(__kindof UIView *)containerView
```
* **containerView** - The container view of the native ad that serves the impression

### Delegates of NativeExpress
Use these delegates to receive events of NativeExpress

`APIQZoneAdNativeExpressDelegate`

```Objective-c
// Request has completed with nativeAd
- (void) nativeExpressAdRequestCompletedWithAd:(nonnull APIQZoneAdNativeExpress *)nativeAd;

// Request has failed
- (void) nativeExpressAdRequestFailedWithAd:(nonnull APIQZoneAdNativeExpress *)nativeAd
                                 withStatus:(nonnull NSError *)nativeAdStatus;

@optional

Notifies the delegate that the native ad has been clicked
- (void) nativeExpressAdDidClick:(nonnull APIQZoneAdNativeExpress *)nativeAd;

Notifies the delegate that the native ad has presented a full screen content
- (void) nativeExpressAdDidPresentScreen:(nonnull APIQZoneAdNativeExpress *)nativeAd;

Notifies the delegate that the native ad has dismissed the presented full screen content
- (void) nativeExpressAdDidDismissScreen:(nonnull APIQZoneAdNativeExpress *)nativeAd;
```

# Interstitial Ad

### Instantiation of an Interstitial Ad
To create a Interstitial ad instance

`APIQZoneAdInterstitial`

```Objective-c
APIQZoneAdInterstitial *interstitial = [[APIQZoneAdInterstitial alloc] initWithSlotId:<AdSlot> withDelegate:<Delegate>];
```
* **AdSlot** - Slot ID to request ad with, provided per placement
* **Delegate** - id<APIQZoneAdInterstitialDelegate> object to receive delegate calls

To load an interstitial Ad
`APIQZoneAdInterstitial`

```Objective-c
[interstitial load];
```

Test if an Interstitial ad is available
`APIQZoneAdInterstitial`

```Objective-c
BOOL ready = [interstitial isReady];
```

### Present an Interstitial Ad
Present interstitial ad from a designated ViewController
`APIQZoneAdInterstitial`

```Objective-c
[interstitial presentFromRootViewController:<Controller>];
```
* **Controller** - UIViewController for which the Interstitial is presented from

### Delegates of Interstitial Ad
Use these delegates to receive events of Interstitial Ad

`APIQZoneAdInterstitialDelegate`

```Objective-c
// Interstitial Ad load success
- (void) interstitialAdLoadDidSuccess:(nonnull APIQZoneAdInterstitial *) interstitialAd;

// Interstitial Ad load fail
- (void) interstitialAdLoadDidFailed:(nonnull APIQZoneAdInterstitial *) interstitialAd withError:(nonnull NSError *) interstitialAdStatus;

// Interstitial Ad presented successful
- (void) interstitialAdDidPresent:(nonnull APIQZoneAdInterstitial *) interstitial;

// Notifies the delegate that the interstitial has been clicked.
- (void) interstitialAdDidClick:(nonnull APIQZoneAdInterstitial *) interstitial;

// Notifies the delegate that the interstitial has been dismissed.
- (void) interstitialAdDidDismiss:(nonnull APIQZoneAdInterstitial *) interstitial;

// Interstitial Ad has been clicked
- (void) interstitialAdDidDismiss:(nonnull APIQZoneAdInterstitial *) interstitial;

// Interstitial Ad present fail
- (void) interstitialAdPresentFailed:(nonnull APIQZoneAdInterstitial *) interstitial withError:(nonnull NSError *) interstitialAdStatus

```

# Incentivized Video Ad

### How does it work
Incentive video ads are singletoned in the SDK, there's no need to create instances, you can use the class method to display ads directly, and the video ads start to load automatically as soon as the SDK is successfully initialized.

Test if incentivized video ad is available
`APIQZoneAdIncentivized`

```Objective-c
BOOL ready = [APIQZoneAdIncentivized isReady];
```

### Present a Incentivized Video Ad
Present incentivized video ad from a designated ViewController

`APIQZoneAdIncentivized`

```Objective-c
[APIQZoneAdIncentivized presentFromRootViewController:<Controller>];
```
* **Controller** - UIViewController for which the Incentivized video Ad is presented from

### Delegates of Incentivized Video Ad
To set a delegate to receive events

`APIQZoneAdIncentivized `

```Objective-c
[APIQZoneAdIncentivized setDelegate:<Delegate>];
```
* **Delegate** - The id<APIQZoneAdIncentivizedDelegate> object
Use these delegates to receive events of Incentivized video Ad

### Delegates of Incentivzed Video Ad
Use these delegates to receive events of Incentivzed Video Ad

`APIQZoneAdIncentivizedDelegate`

```Objective-c
// Incentvized video Ad has failed to present
- (void) incentivizedAdPresentDidFailWithError:(NSError * _Nonnull)error;

// Incentivized video Ad has presented successful
- (void) incentivizedAdPresentDidSuccess;

// Incentivized video Ad has been clicked
- (void) incentivizedAdDidClick;

// Incentivized video Ad has complete without skip 
- (void) incentivizedAdPresentDidComplete;

// Incentivized video Ad has complete with skip 
- (void) incentivizedAdPresentDidSkip;
```

# Banner Ad

### Instantiation of Banner Ad
Create an instance of a banner, banner ad is a sub class of UIView

`APIQZoneAdBanner`

```Objective-c
APIQZoneAdBanner * banner = [[APIQZoneAdBanner alloc] initWithSlot:<adSlot> withSize:<size> delegate:<delegate> currentController:<controller>];
[self.view addSubview:banner];
```
* **adSlot** - Slot ID to request ad with
* **Size** - <APIQZoneAdBannerSize> banner size
* **Delegate** - id<APIQZoneAdBannerDelegate> object to receive delegate calls
* **controller** - UIViewController for displaying landing page when clicked banner ad

load Ad

`APIQZoneAdBanner`

```Objective-c
[banner load];
```

Setting Ad Positon

`APIQZoneAdBanner`
```Objective-c
[banner setPosition:<point>];
```

* **point** - setting ad center point

### Delegates of Banner Ad
Use these delegates to receive events of Banner Ad

`APIQZoneAdBannerDelegate`

```Objective-c
// Notifies the delegate that the banner has finished loading
- (void) bannerAdCompleteLoadingWithAd:(nonnull APIQZoneAdBanner *)bannerAd;

// Notifies the delegate that the banner has failed to load with some error.
- (void) bannerAdFailedLoadingForSlot:(nonnull NSString *)adSlot
                           withStatus:(nonnull NSError *)nativeAdStatus
                            andBanner:(nonnull APIQZoneAdBanner *)bannerAd;
                            
// Notifies the delegate that the banner has been clicked                            
- (void) bannerDidClick:(nonnull APIQZoneAdBanner *)bannerAd;

// Notifies the delegate that the banner has finished presenting screen.
- (void) bannerDidPresentScreen:(nonnull APIQZoneAdBanner *)bannerAd;

// Notifies the delegate that the banner has dismissed the presented screen.
- (void) bannerDidDismissScreen:(nonnull APIQZoneAdBanner *)bannerAd;
```

# Splash Ad

### Instantiation of Splash Ad
Create an instance of a splash

`APIQZoneAdSplash`

```Objective-c
APIQZoneAdSplash *splash = [[APIQZoneAdSplash alloc] initWithSlot:<AdSlot> delegate:<Delegate>];
```
* **AdSlot** - Slot ID to request ad with
* **Delegate** - id<APIQZoneAdSplashDelegate> object to receive delegate calls

### Display duration
Use the following method to set duration of how long the splash ad will be displayed for

```Objective-c
[splash setShowInterval:<NSInteger>];
```

### Load
Load a Splash Ad

`APIQZoneAdSplash`

```Objective-c
[splash load];
```

### Present Splash
Present Splash Ad once received loadSuccess

`APIQZoneAdSplash`

```Objective-c
[splash presentWithViewController:<Controller>];
```

* **Controller** - the UIViewController which splash ad will be diplayed from

### Present with branding view
Sometime that the asset served in ad is not big enough to cover the entire screen, the next alternative method allow you to specify a UIView to fill up the remaining space, this is usually filled with a logo or branding images of the hosting app. If you do not wish to add this view, use the presentresentWithViewController method instead.

`APIQZoneAdSplash`

```Objective-c
[splash presentWithViewController:<Controller> andBackgroundColor:<Color> andBottomView:<View> andBottomViewAutoFitDisplay:<Auto>];
```

* **Controller** - the UIViewController which splash ad will be diplayed from
* **Color** - background color of the branding view
* **View** - the UIView to fill the branding area
* **Auto** - set to YES if you wish SDK to decide when to display branding view depands on the size of ad asset, set to NO to show it constantly

### Size of branding view
For ease of use, call the following method for max possible CGSize of branding area

`APIQZoneAdSplash`

```Objective-c
CGSize size = [APIQZoneAdSplash getBottomViewSize];
```


### Suspend splash
Use this method to suspend splash from showing when you decide that the ad has been taking too long to load, and it is no longer suitable to show. Only use this after loadAndPresentWithViewControll has been called.

`APIQZoneAdSplash`

```Objective-c
[splash suspend];
```

### Delegates of Splash Ad
Use these delegates to receive events of Splash Ad

`APIQZoneAdSplashDelegate`

```Objective-c
// Ad is loaded successfully
- (void) splashAdLoadSuccess:(APIQZoneAdSplash *)splashAd;

// Ad has failed to load
- (void) splashAdLoadFail:(APIQZoneAdSplash *)splashAd withError:(nonnull NSError *)error;

// Ad is successfully presented
- (void) splashAdPresentDidSuccess:(nonnull APIQZoneAdSplash *)splashAd;

// Ad present has failed
- (void) splashAdPresentDidFail:(nonnull APIQZoneAdSplash *)splashAdSlot
withError:(nonnull NSError *)error;

// Ad has been clicked
- (void) splashAdDidClick:(nonnull APIQZoneAdSplash *)splashAd;

// Ad view has been dismissed from screen
- (void) splashAdDidDismiss:(nonnull APIQZoneAdSplash *)splashAd;

// Splash ad will dismissed
- (void) splashAdWillDismiss:(nonnull APIQZoneAdSplash *)splashAd;

### SDK Error Code

```Objective-c
    APIQZoneAdStatusCodeMissingResourceBundle        = 51001,    // Resource bundle is not present
    APIQZoneAdStatusCodeNoFill                       = 51002,    // Ad is not filled at this time
    APIQZoneAdStatusCodeDuplicateRequest             = 51003,    // Instance of ad is already served, usually caused duplicated request on same instance of ad
    APIQZoneAdStatusCodeSDKNotInitialized            = 51004,
    APIQZoneAdStatusCodeMediationRequestFailed       = 51101,     // General mediation platform failed to receive ad in time or returned mediation error
    APIQZoneAdStatusCodeMediationInvalidRequest      = 51102,     // Mediation platform return invalid request error
    APIQZoneAdStatusCodeMediationInvalidConfig       = 51103,
    APIQZoneAdStatusCodeFailToPresent                = 51104,
    APIQZoneAdStatusCodeAdSwitchClose                = 51105,     // Ad closed
    APIQZoneAdStatusCodeInvalidRequestPath           = 59994,        // Incorrect server address
    APIQZoneAdStatusCodeNetworkUnavailable           = 59995,        // Network is currently not available
    APIQZoneAdStatusCodeNetworkTimeout               = 59996,         // Network request timeout
    APIQZoneAdStatusCodeInternalError                = 59997,         // SDK internal process error
    APIQZoneAdStatusCodeServerError                  = 59998,        // Server has return an error
    APIQZoneAdStatusCodeUnknown                      = 59999
```

### cocos2d-x present ad crash
Please check if there is the following code in `AppController`, please add it.
This is due older version of Cocod2d-x engine code missed to put window reference in AppController.

```Objective-c
@property(nonatomic, readonly) UIWindow* window;
```
