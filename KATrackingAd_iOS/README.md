> [English Doc](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README_EN.md)
# 当前版本 Ver.3.6.2 [ReleaseNote](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/ReleaseNote.md)
# 接入说明

## 准备工作
### 获取KASDK+Demo.zip [下载链接](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/KASDK%2BDemo.zip)
请将Mediation.zip中所有广告平台依赖库添加到Demo测试工程中，位置：KATrackingAdDemo/SDK/Mediation/，从而在Demo中测试所有广告位
### 获取广告平台依赖库-1 [下载链接](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_1.zip)
### 获取广告平台依赖库-2 [下载链接](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_2.zip)
### 获取广告平台依赖库-3 [下载链接](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_3.zip)

请将以下依赖库全部添加到接入工程中
### 广告SDK依赖库
* KASDK+Demo.zip - 其中包含：
  * KASDK.framework
  * KAResources.bundle
### 广告平台依赖库
* Mediation.zip
  * InMobi.framework
  * GoogleMobileAds.framework
  * UnityAds.framework
  * VungleSDK.framework
  * AppLovinSDK.framework
  * IronSource.framework
  * Toutiao
    * WMAdSDK.framework
    * WMAdSDK.bundle
  * GDT
    * libGDTMobSDK.a
  * TalkingData (选加，如果需要KASDK对接TD作为统计框架）
    * libTalkingData.a
  * UM (选加，如果需要KASDK对接UM作为统计框架）   
    * UMAnalytics.framework
    * UMCommon.framework
  * AppsFlyer (选加，如果需要KASDK对接AppsFlyer作为统计框架)
  * FBAudienceNetwork.framework

### 加入其它依赖库
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
* JavaScriptCore.framework
* libsqlite3.0.tbd
* libxml2.2.tbd
* libz.tbd
* libc++.tbd

### info.plist设置白名单
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
	</array>
```


### 设置Deployment Target : iOS 8.0
![deployment target](https://github.com/KATracking/KATrackingAd/blob/master/README_Res/ios_deployment_target.png)

### 添加 -ObjC linker flag
![linker flag](https://github.com/KATracking/KATrackingAd/blob/master/README_Res/linker_flag.png)

### 设置 ATS
![linker flag](https://github.com/KATracking/KATrackingAd/blob/master/README_Res/ats.png)

## 开始接入

### SDK 初始化
请在应用生命周期尽可能早的步骤中启动SDK初始化，这样SDK可以尽快开始预加载广告。

`AppDelegate`

```Objective-c
#import <KASDK/KASDK.h>
```
`AppDelegate : application:didFinishLaunchingWithOptions:`

```Objective-c
[[KATracking sharedInstance] initWithAppId:@"<AppId>" channel:@"<AppChannel>"];
```
请向运营人员索取

* **AppId** - 应用标识
* **AppChannel** - 应用渠道号

# 原生广告 - Native

### 构建广告
创建一个原生广告的实例
`KAAdNative`

```Objective-c
KAAdNative *ad = [[KAAdNative alloc] initWithSlot:<AdSlot> delegate:<Delegate>];
```
* **AdSlot** - 广告位SlotId，用于请求广告
* **Delegate** - id<KAAdNativeDelegate> 实例，用于接收请求广告的回调

### 加载广告
调用load方法来获取广告，并通过回调来判断广告是否请求成功
`KAAdNative`

```Objective-c
[ad load];
```

### 获取广告大图素材
通过调用以下方法，获取包含原生广告大图素材的UIView，返回值有可能为空，为空时请使用adIcon作为素材展示图文广告
`KAAdNative`

```Objective-c
UIView *primaryView = [ad primiaryViewOfSize:<size>];
```
* **size** - 广告素材指定尺寸

### 广告素材信息
下列参数包含了其他广告相关的素材信息

* **ka_slot** - 广告为的SlotId
* **ka_requestId** - 请求ID
* **ka_adTitle** - 广告文字标题
* **ka_adDescription** - 广告文字说明
* **ka_adIcon** - 广告图标图片的UIImage


### 上报广告展示
当广告被展示后，调用此方法上报展示事件
`KAAdNative`

```Objective-c
[ad nativeAdRenderedWithView:adView];
```
* **adView** - 装载广告素材的容器UIView

### 上报广告点击
当用户点击了广告，调用此方法上报点击事件
`KAAdNative`

```Objective-c
[ad nativeAdClickedAtPointAndOpenLandingPage:touchPoint];
```
* **touchPoint** - 点击在容器UIView中的CGPoint

### 回收素材
当广告素材被从展示界面中移除后，请调用以下方法来回收素材
`KAAdNative`

```Objective-c
[ad recyclePrimaryView];
```

### 广告回调
使用以下回调接收加载广告成功和失败的事件
`KAAdNativeDelegate`

```Objective-c

广告请求成功
- (void) nativeAdRequestCompletedWithAd:(nonnull KAAdNative *)nativeAd;

广告请求失败
- (void) nativeAdRequestFailedForSlot:(nonnull NSString *)nativeAdSlot
                           withStatus:(nonnull NSError *)nativeAdStatus;

@optional
- (void) nativeAdRequestFailedWithAd:(nonnull KAAdNative *)nativeAd
                          withStatus:(nonnull NSError *)nativeAdStatus;
```

# 开屏广告 - Splash

### 构建广告
创建一个开屏广告的实例
`KAAdSplash`

```Objective-c
KAAdSplash *splash = [[KAAdSplash alloc] initWithSlot:<AdSlot> delegate:<Delegate>];
```
* **AdSlot** - 广告位SlotId，用于请求广告
* **Delegate** - id<KAAdSplashDelegate> 实例，用于接收广告事件回调

### 展示广告
调用下面方法加载并展示开屏广告
`KAAdSplash`

```Objective-c
[splash loadAndPresentWithViewController:<Controller>];
```
* **Controller** - 用于展示开屏广告的UIViewController

### 展示广告并添加产品标识
调用下面方法加载并展示开屏广告，同时可以添加产品自定的标识View，用于填充当由于素材尺寸不足填充全屏情况下的空白位置
`KAAdSplash`

```Objective-c
[splash loadAndPresentWithViewController:<Controller> andBackgroundColor:<Color> andBottomView:<View> andBottomViewAutoFitDisplay:<Auto>];
```

* **Controller** - 用于展示开屏广告的UIViewController
* **Color** - 标识填充区的背景颜色
* **View** - 用于展示在标识填充区的UIView
* **Auto** - 当希望SDK自动根据尺寸适应是否展示标识View的时候传入Yes, 否则传入No将始终显示标识View

### 标识区可用尺寸
调用下面方法来根据不同设备计算可以用于标识区的View大小
`KAAdSplash`

```Objective-c
CGSize size = [KAAdSplash getBottomViewSize];
```

### 广告回调
使用以下回调接收加载广告的事件

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

# 插屏广告 - Interstitial

### 构建广告
创建一个插屏广告的实例
`KAAdInterstitial`

```Objective-c
KAAdInterstitial *interstitial = [[KAAdInterstitial alloc] initWithSlot:<AdSlot> delegate:<Delegate>];
```
* **AdSlot** - 广告位SlotId，用于请求广告
* **Delegate** - id<KAAdInterstitialDelegate> 实例，用于接收广告事件回调

请求并加载广告
`KAAdInterstitial`

```Objective-c
[interstitial load];
```

检测广告是否已经可以使用
`KAAdInterstitial`

```Objective-c
BOOL ready = [interstitial isReady];
```

### 展示广告
调用下面方法加载并展示开屏广告
`KAAdInterstitial`

```Objective-c
[interstitial presentFromRootViewController:<Controller>];
```
* **Controller** - 用于展示插屏广告的UIViewController

### 广告回调
使用以下回调接收加载广告的事件

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

# 激励视频广告 - Incentivized

### 如何使用
激励视频广告在SDK中为单例，因此无需在创建新的实例，可以直接使用类方法展示广告，视频广告在SDK初始化成功后立即开始自动加载。

检测广告是否已经可以使用
`KAAdIncentivized`

```Objective-c
BOOL ready = [KAAdIncentivized isReady:<isShowSkipButton>];
```

### 展示广告
调用下面方法加载并展示极力视频广告
`KAAdIncentivized`

```Objective-c
[KAAdIncentivized presentFromRootViewController:<Controller> andSkipButton:<isShowSkipButton>];
```
* **Controller** - 用于展示激励视频广告的UIViewController
* **isShowSkipButton** - 传入YES播放视频过程中显示跳过按钮，NO则不显示

### 广告回调
设置一个激励视频的回调实例
`KAAdIncentivized`

```Objective-c
[KAAdIncentivized setDelegate:<Delegate>];
```
* **Delegate** - id<KAAdIncentivizedDelegate> 实例，用于接收广告事件回调

### 广告回调
使用以下回调接收加载广告的事件

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

# 横幅广告 - Banner

### 构建广告
创建一个横幅广告的实例并将广告加到视图上
`KAAdBanner`

```Objective-c
KAAdBanner * banner = [[KAAdBanner alloc] initWithSlot:<adSlot> withSize:<size> delegate:<delegate> currentController:<controller>];
[self.view addSubview:banner];
```
* **adSlot** - 广告位SlotId，用于请求广告
* **Size** - 广告尺寸<KAAdBannerSize>枚举
* **Delegate** - id<KAAdBannerDelegate> 实例，用于接受广告事件回调
* **controller** - 用于点击横幅广告后展示广告页的UIViewController

请求并加载广告
`KAAdBanner`

```Objective-c
[banner load];
```

设置广告的位置
`KAAdBanner`
```Objective-c
[banner setPosition:<point>];
```

* **point** - 设置广告的中心点坐标

### 广告回调
使用以下回调接收加载广告的事件

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

### SDK错误码

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

### cocos2d-x播放广告崩溃问题
请检查`AppController`中是否有如下代码，没有请加上试试
```Objective-c
@property(nonatomic, readonly) UIWindow* window;
```
