> [中文文档](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS_new/README.md)
# Current Ver.3.8.3 [ReleaseNote](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS_new/ReleaseNote.md)
# Integration Guideline

SDK can be obtained in two ways as mentioned below.

* Get and integrate via CocoaPods
* Get and integrate by downloading the ZIP archive
* Note: We recommend to use CocoaPods for sdk management.  The following describes the basic usage of cocoapods. If you don't have relevant experience, please execute the following commands sequentially in the command line window.


## Preparation
If you have not installed CocoaPods, please follow the process below.

### CocoaPods installation
`sudo gem install -n /usr/local/bin cocoapods --pre`

### CocoaPods public warehouse installation
`pod setup`

## Integrated with CocoaPods
* Switch the current working path in the command line window to the directory where your Xcode project file is located. 

`cd projectPath`

* Create a Podfile

`pod init`

* Open the Podfile with a text compiler and add the sdk library which you need to depend on.

`  pod 'AppicSDK'`  
`  pod 'AppicAppLovinSDK'`  
`  pod 'AppicAppsFlyerLib'`  
`  pod 'AppicGDT'`  
`  pod 'AppicGoogleMobileAds'`  
`  pod 'AppicInMobiSDK'`  
`  pod 'AppicIronSource'`  
`  pod 'AppicTalkingData'`  
`  pod 'Appictoutiao'`  
`  pod 'AppicUM'`  
`  pod 'AppicFirebase'`   
`  pod 'AppicUnityAds'`  
`  pod 'AppicVungleSDK'`  
`  pod 'AppicFBAudienceNetwork'`  
`  pod 'AppicAdjustSdk'` 

* Execute the CocoaPods install command in the command line window.  

`pod install`

* Use Xcode to open the project with the newly generated xcworkspace, compile and test. At this point sdk has been integrated.

### Update SDK version
* When updating the SDK version, you first need to update the cocoapods code repository in the command line window.  

`pod repo update`

* Switch the current working path in the command line window to the directory where your Xcode project file is located. 

`cd projectPath`

* Execute the following instructions in the command line window to update。

`pod update`

### Get the SDK docking demo [Download Path](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS_new/Demo.zip)
A reference to all third-party sdk dependent libraries has been configured in Demo. Please follow the steps above to install cocoapods, and execute the `pod install` command on the project path to install sdk. After installation, you can run it.

## Download the SDK zip package for integration
* If you use cocoapods to integrate, you don't have to manually download sdk.
* If integrate manually, please download the corresponding version of sdk via the link below.
  
#### Advertising SDK dependency library
* AppicSDK [download path](https://img.atomhike.com/sdk/Mediation/KASDK/KASDK.v3.8.3.zip)

#### Advertising platform dependency library
* AppicInMobiSDK [download path](https://img.atomhike.com/sdk/Mediation/InMobiSDK/InMobiSDK.v0.0.4.zip)
* AppicGoogleMobileAds [download path](https://img.atomhike.com/sdk/Mediation/GoogleMobileAds/GoogleMobileAds.v0.0.4.zip)
* AppicUnityAds [download path](https://img.atomhike.com/sdk/Mediation/UnityAds/UnityAds.v0.0.4.zip)
* AppicVungleSDK [download path](https://img.atomhike.com/sdk/Mediation/VungleSDK/VungleSDK.v0.0.4.zip)
* AppicAppLovinSDK [download path](https://img.atomhike.com/sdk/Mediation/AppLovinSDK/AppLovinSDK.v0.0.4.zip)
* AppicIronSource [download path](https://img.atomhike.com/sdk/Mediation/IronSource/IronSource.v0.0.4.zip)
* Appictoutiao [download path](https://img.atomhike.com/sdk/Mediation/toutiao/toutiao.v0.0.4.zip)
  * WMAdSDK.framework
  * WMAdSDK.bundle
* AppicGDT [download path](https://img.atomhike.com/sdk/Mediation/GDT/GDT.v0.0.4.zip)
  * libGDTMobSDK.a
* AppicTalkingData (Optional, if you need KASDK to dock TD as a statistical framework）[download path](https://img.atomhike.com/sdk/Mediation/TalkingData/TalkingData.v0.0.4.zip)
  * libTalkingData.a
* AppicUM (Optional, if you need KASDK to dock UM as a statistical framework）[download path](https://img.atomhike.com/sdk/Mediation/UM/UM.v0.0.4.zip)   
  * UMAnalytics.framework
  * UMCommon.framework
* AppicFirebase (Optional, if you need KASDK to dock AppicFirebase as a statistical framework）[download path](https://img.atomhike.com/sdk/Mediation/Firebase/Firebase.v5.18.0.zip)   
  * Crashlytics.framework
  * Fabric.framework
  * FIRAnalyticsConnector.framework
  * FirebaseAnalytics.framework
  * FirebaseCore.framework
  * FirebaseCoreDiagnostics.framework
  * FirebaseCrash.framework
  * FirebaseInstanceID.framework
  * GoogleAppMeasurement.framework
  * GoogleToolboxForMac.framework
  * GoogleUtilities.framework
  * nanopb.framework
  * Protobuf.framework
* AppicAppsFlyerLib (Optional, if you need KASDK to dock AppsFlyer as a statistical framework) [download path](https://img.atomhike.com/sdk/Mediation/AppsFlyerLib/AppsFlyerLib.v0.0.4.zip)

* AppicFBAudienceNetwork [download path](https://img.atomhike.com/sdk/Mediation/FBAudienceNetwork/FBAudienceNetwork.v0.0.4.zip)
* AppicAdjustSdk [download path](https://img.atomhike.com/sdk/Mediation/AdjustSdk/AdjustSdk.v4.17.1.zip)

   
### Join other dependency libraries
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

### info.plist Set whitelist
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


### Setup deployment target to: iOS 8.0
![deployment target](https://github.com/KATracking/KATrackingAd/blob/master/README_Res/ios_deployment_target.png)

### Add the -ObjC linker flag
![linker flag](https://github.com/KATracking/KATrackingAd/blob/master/README_Res/linker_flag.png)

### Setup ATS
![linker flag](https://github.com/KATracking/KATrackingAd/blob/master/README_Res/ats.png)

## Let's code!

### SDK initialization
Please initialize SDK as early into app lifecycle as possible, as once SDK initilized it will automatically pre-cashe ads.

`AppDelegate`

```Objective-c
#import <KASDK/KASDK.h>
```
`AppDelegate : application:didFinishLaunchingWithOptions:`

```Objective-c
[[KATracking sharedInstance] initWithAppId:@"<AppId>" channel:@"<AppChannel>"];
```
Provided by operator

* **AppId** - Application ID
* **AppChannel** - Application distribution channel

# Native template ad - NativeExpress

### Create an ad
Create an instance of a native template ad
`KAAdNativeExpress`

```Objective-c
KAAdNativeExpress *ad = [[KAAdNativeExpress alloc] initWithSlot:<AdSlot> delegate:<Delegate>];
```
* **AdSlot** - Slot ID to request ad with
* **Delegate** - id<KAAdNativeDelegate> object to receive delegate calls

### Load Native ad
Simple call this method to load an ad, then wait for delegates to be tricked for load succes or fail
`KAAdNativeExpress`

```Objective-c
[ad load];
```

### Properties of Native Ad
Each native ad also have the following properties 

* **ka_slot** - SlotId of the ad slot
* **ka_adTitle** - Ad title text
* **ka_adDescription** - Ad text description
* **ka_adIcon** - UIImageView containing the icon image of Ad
* **ka_adScreenShots** - UIImageView containing the big picture of Ad
* **ka_VideoAdView** - UIImageView containing the video of Ad

### rootviewController
`KAAdNativeExpress`

```Objective-c
[ad setRootViewController:<controller>]
```

* **controller** - Advertising display landing page redirects via rootviewController, which must pass parameters

### Register clickable view
`KAAdNativeExpress`

```Objective-c
- (BOOL)registerContainer:(__kindof UIView *)containerView
```
* **containerView** - Register the container view of the native ad, must pass parameters

### Recycling material
When the advertising materials are removed from the display interface, please call the following method to reclaim the material
`KAAdNativeExpress`

```Objective-c
[ad recyclePrimaryView];
```

### Delegates of Native Ad
Use these delegates to receive events of request native ad complete or fail
`KAAdNativeExpressDelegate`

```Objective-c
// Request has completed with nativeAd
- (void) nativeExpressAdRequestCompletedWithAd:(nonnull KAAdNativeExpress *)nativeAd;

// Request has failed
- (void) nativeExpressAdRequestFailedWithAd:(nonnull KAAdNativeExpress *)nativeAd
                                 withStatus:(nonnull NSError *)nativeAdStatus;

@optional

Ad click
- (void) nativeExpressAdDidClicked:(nonnull KAAdNativeExpress *)native;
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


### Show ads and add product IDs
Call the following method to load and display the open screen advertisement, and at the same time you can add the product custom logo view to fill the blank position when the full screen is filled due to insufficient material size.

`KAAdSplash`

```Objective-c
[splash loadAndPresentWithViewController:<Controller> andBackgroundColor:<Color> andBottomView:<View> andBottomViewAutoFitDisplay:<Auto>];
```

* **Controller** - UIViewController for which the Splash is presented from
* **Color** - Identifies the background color of the fill area
* **View** - Used to display the View in the fill area
* **Auto** - When you want the SDK to automatically adapt to the size according to whether the display is displayed, otherwise it will be displayed.

### Logo area available size
Call the following method to calculate the View size that can be used to identify the zone based on different devices.

`KAAdSplash`

```Objective-c
CGSize size = [KAAdSplash getBottomViewSize];
```

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
Incentive video ads are singletoned in the SDK, so there's no need to create new instances, you can use the class method to display ads directly, and the video ads start to load automatically as soon as the SDK is successfully initialized.

Check if the ad is ready for use
`KAAdIncentivized`

```Objective-c
BOOL ready = [KAAdIncentivized isReady:<isShowSkipButton>];
```

### Present a Incentivized video Ad
Call the following method to load and display the incentive video ad

`KAAdIncentivized`

```Objective-c
[KAAdIncentivized presentFromRootViewController:<Controller> andSkipButton:<isShowSkipButton>];
```
* **Controller** - UIViewController for which the Incentivized video Ad is presented from
* **isShowSkipButton** - YES or NO, Whether to display the skip button

### Delegates of Incentivized video Ad
To set a delegate to receive events

`KAAdIncentivized`

```Objective-c
[KAAdIncentivized setDelegate:<Delegate>];
```
* **Delegate** - The id<KAAdIncentivizedDelegate> object
Use these delegates to receive events of Incentivized video Ad

### Ad callback
Receive events that load ads using the following callbacks 

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

# Banner Ad

### Create a Banner Ad
Create an instance of a banner and add the ad to the view

`KAAdBanner`

```Objective-c
KAAdBanner * banner = [[KAAdBanner alloc] initWithSlot:<adSlot> withSize:<size> delegate:<delegate> currentController:<controller>];
[self.view addSubview:banner];
```
* **adSlot** - Slot ID to request ad with
* **Size** - <KAAdBannerSize> banner size
* **Delegate** - id<KAAdBannerDelegate> object to receive delegate calls
* **controller** - UIViewController for displaying ad pages after clicking on a banner ad

load Ad
`KAAdBanner`

```Objective-c
[banner load];
```

Setting Ad Positon
`KAAdBanner`
```Objective-c
[banner setPosition:<point>];
```

* **point** - setting ad center point

### Ad callback
Receive events that load ads using the following callbacks

`KAAdBannerDelegate`

```Objective-c
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
```

### Redemption code

Enter redemption code to redeem gifts

`KAPub`

```Objective-c
[KAPub redeemCode:<code> withDelegate:<Delegate>]
```
* **code** - Redemption code (contact the operator for the relevant configuration)
* **Delegate** - id<KAPubConfigManagerDelegate> instances，Used to receive redemption is successfull or not.

Receive redemption events using the following callbacks

`KAPubConfigManagerDelegate`

```Objective-c
/**
 * Return the successfully redeemed packet to the agent for processing and return the corresponding redemption code.
 */
- (void) redeemCodeSuccessWithData:(NSDictionary *)data withCode:(NSString *)code;
/**
 * Redemption failed, return error code and corresponding redemption code
 */
- (void) redeemCodeFailedWithError:(NSError *)error withCode:(NSString *)code;
```
### Payment
`KAPub`

Payment

```Objective-c
[KAPub payWithIAPId:<iapId> withOrderId:<orderId> withDelegate:<Delegate>]
```
Restore purchase

```Objective-c
[KAPub restoreCompletedTransactionsWithDelegate:<Delegate>]
```


* **iapId** - Platform billing point
* **orderId** - Order Id (please ensure that each incoming order Id is a unique Id)
* **Delegate** - id<KAPubConfigManagerDelegate>instance，Used to receive whether payment is successful

Receive payment events using the following callbacks

`KAPubConfigManagerDelegate `

```Objective-c
/**
 * The payment is successful and returns to the platform billing point id
 */
- (void)paymentSuccessWithIapId:(NSString *)iapId;
/**
 * Payment failure returns platform billing point id and error message
 */
- (void)paymentFailedIapId:(NSString *)iapId withErrorInfo:(NSError *)error;
/**
 * Restored purchase failed
 */
- (void)restorePaymentFailed;
/**
 * Restore purchase success and return Apple billing point id
 */
- (void)restorePaymentSuccessWithIdentifier:(NSString *)iapId;
```

### PUSH


`KAPub`

Get the deviceToken in the proxy method of `UIApplicationDelegate`

```Objective-c
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
	[KAPub setDeviceToken:deviceToken];
} 

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [KAPub handlePushMessage:userInfo];
}
```

### SDK Error Code

```Objective-c
    KAAdStatusCodeMissingResourceBundle        = 51001,    // Resource bundle is not present
    KAAdStatusCodeNoFill                       = 51002,    // Ad is not filled at this time
    KAAdStatusCodeDuplicateRequest             = 51003,    // Instance of ad is already served, usually caused duplicated request on same instance of ad
    KAAdStatusCodeSDKNotInitialized            = 51004,
    KAAdStatusCodeMediationRequestFailed       = 51101,    // General mediation platform failed to receive ad in time or returned mediation error
    KAAdStatusCodeMediationInvalidRequest      = 51102,    // Mediation platform return invalid request error
    KAAdStatusCodeMediationInvalidConfig       = 51103,     
    KAAdStatusCodeFailToPresent                = 51104,
    KAAdStatusCodeAdSwitchClose                = 51105,    // Ad closed
    KAAdStatusCodeInvalidRequestPath           = 59994,    // Incorrect server address
    KAAdStatusCodeNetworkUnavailable           = 59995,    // Network is currently not available
    KAAdStatusCodeNetworkTimeout               = 59996,    // Network request timeout
    KAAdStatusCodeInternalError                = 59997,    // SDK internal process error
    KAAdStatusCodeServerError                  = 59998,    // Server has return an error
    KAAdStatusCodeUnknown                      = 59999
```

### cocos2d-x present ad crash
Please check if there is the following code in `AppController`, please add it.

```Objective-c
@property(nonatomic, readonly) UIWindow* window;
```
