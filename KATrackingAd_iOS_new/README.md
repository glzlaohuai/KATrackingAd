> [English Doc](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS_new/README_EN.md)
# 当前版本 Ver.3.7.7 [ReleaseNote](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS_new/ReleaseNote.md)
# 接入说明

SDK可以通过下文提到的两种方式获取

* 通过CocoaPods获取并集成
* 通过直接下载ZIP压缩包获取并集成
* 注意：我们推荐使用cocoapods进行sdk管理，以下将介绍cocoapods的基本用法，如果没有相关经验请在命令行窗口中顺序执行以下命令


## 准备工作
如果你尚未安装CocoaPods请根据下述流程安装

### CocoaPods安装
`sudo gem install -n /usr/local/bin cocoapods --pre`

### CocoaPods公有仓库安装
`pod setup`

## 通过CocoaPods集成
* 在命令行窗口中切换当前工作路径，到你的Xcode工程文件所在目录  

`cd projectPath`

* 创建Podfile文件

`pod init`

* 用文本编译器打开Podfile文件，添加需要依赖的sdk库

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

* 在命令行窗口执行cocoapods安装命令  

`pod install`

* 用Xcode通过新生成的xcworkspace打开项目，编译测试。此时sdk已经集成完毕

### 更新SDK版本
* 当SDK版本时，需要首先在命令行窗口中更新cocoapods代码仓库  

`pod repo update`

* 在命令行窗口中切换当前工作路径，到你的Xcode工程文件所在目录  

`cd projectPath`

* 在命令行窗口中执行以下指令进行更新  

`pod update`

### 获取SDK对接Demo [下载链接](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS_new/Demo.zip)
Demo中已经配置了对所有第三方sdk的依赖库的引用，请按照上面的步骤安装cocoapods，并在工程路径执行`pod install`命令进行sdk安装，安装之后即可运行。

## 下载SDK压缩包进行集成
* 如果使用cocoapods方式集成，则不用手动下载sdk。
* 如果使用手工集成，请通过以下链接下载对应版本的sdk
  
#### 广告SDK依赖库
* AppicSDK [下载链接](https://img.atomhike.com/sdk/Mediation/KASDK/KASDK.v3.7.7.zip)

#### 广告平台依赖库
* AppicInMobiSDK [下载链接](https://img.atomhike.com/sdk/Mediation/InMobiSDK/InMobiSDK.v0.0.4.zip)
* AppicGoogleMobileAds [下载链接](https://img.atomhike.com/sdk/Mediation/GoogleMobileAds/GoogleMobileAds.v0.0.4.zip)
* AppicUnityAds [下载链接](https://img.atomhike.com/sdk/Mediation/UnityAds/UnityAds.v0.0.4.zip)
* AppicVungleSDK [下载链接](https://img.atomhike.com/sdk/Mediation/VungleSDK/VungleSDK.v0.0.4.zip)
* AppicAppLovinSDK [下载链接](https://img.atomhike.com/sdk/Mediation/AppLovinSDK/AppLovinSDK.v0.0.4.zip)
* AppicIronSource [下载链接](https://img.atomhike.com/sdk/Mediation/IronSource/IronSource.v0.0.4.zip)
* Appictoutiao [下载链接](https://img.atomhike.com/sdk/Mediation/toutiao/toutiao.v0.0.4.zip)
  * BUAdSDK.framework
  * BUAdSDK.bundle
* AppicGDT [下载链接](https://img.atomhike.com/sdk/Mediation/GDT/GDT.v0.0.4.zip)
  * libGDTMobSDK.a
* AppicTalkingData (选加，如果需要KASDK对接TD作为统计框架）[下载链接](https://img.atomhike.com/sdk/Mediation/TalkingData/TalkingData.v0.0.4.zip)
  * libTalkingData.a
* AppicUM (选加，如果需要KASDK对接UM作为统计框架）[下载链接](https://img.atomhike.com/sdk/Mediation/UM/UM.v0.0.4.zip)   
  * UMAnalytics.framework
  * UMCommon.framework
* AppicFirebase (选加，如果需要KASDK对接Firebase作为统计框架））[download path](https://img.atomhike.com/sdk/Mediation/Firebase/Firebase.v5.18.0.zip)   
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
* AppicAppsFlyerLib (选加，如果需要KASDK对接AppsFlyer作为统计框架) [下载链接](https://img.atomhike.com/sdk/Mediation/AppsFlyerLib/AppsFlyerLib.v0.0.4.zip)
* AppicFBAudienceNetwork [下载链接](https://img.atomhike.com/sdk/Mediation/FBAudienceNetwork/FBAudienceNetwork.v0.0.4.zip)
* AppicAdjustSdk [下载链接](https://img.atomhike.com/sdk/Mediation/AdjustSdk/AdjustSdk.v4.17.1.zip)
   
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
* CoreMotion.framework（选加，加上的话需要声明NSLocationAlwaysUsageDescription权限）
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

# 原生模板广告 - NativeExpress

### 构建广告
创建一个原生模板广告的实例
`KAAdNativeExpress`

```Objective-c
KAAdNativeExpress *ad = [[KAAdNativeExpress alloc] initWithSlot:<AdSlot> delegate:<Delegate>];
```
* **AdSlot** - 广告位SlotId，用于请求广告
* **Delegate** - id<KAAdNativeDelegate> 实例，用于接收请求广告的回调

### 加载广告
调用load或loadWithoutCache方法来获取广告，并通过回调来判断广告是否请求成功
`KAAdNativeExpress`

```Objective-c
此方法需要ka_adIcon和ka_adScreenShots来获取图片素材
[ad load];

此方法需要ka_adIconUrl和ka_adScreenShotsUrl来获取素材的url
[ad loadWithoutCache];
```

### 广告素材信息
下列参数包含了其他广告相关的素材信息，请在load请求成功后再调用相应素材

* **ka_slot** - 广告为的SlotId
* **ka_adTitle** - 广告文字标题
* **ka_adDescription** - 广告文字说明
* **ka_adIcon** - 广告图标图片的UIImage
* **ka_adScreenShots** - 广告大图的UIView
* **ka_VideoAdView** - 广告视频的UIView
* **ka_adIconUrl** - 广告图标的url
* **ka_adScreenShotsUrl** - 广告大图的url

### rootviewController
`KAAdNativeExpress`

```Objective-c
[ad setRootViewController:<controller>]
```

* **controller** - 广告位展示落地页通过rootviewController进行跳转，必传参数

### 注册可点击视图
`KAAdNativeExpress`

```Objective-c
- (BOOL)registerContainer:(__kindof UIView *)containerView
```
* **containerView** - 注册原生广告的容器视图，必传参数

### 回收素材
当广告素材被从展示界面中移除后，请调用以下方法来回收素材
`KAAdNativeExpress`

```Objective-c
[ad recyclePrimaryView];
```

### 广告回调
使用以下回调接收加载广告成功和失败的事件
`KAAdNativeExpressDelegate`

```Objective-c
广告请求成功
- (void) nativeExpressAdRequestCompletedWithAd:(nonnull KAAdNativeExpress *)nativeAd;

广告请求失败
- (void) nativeExpressAdRequestFailedWithAd:(nonnull KAAdNativeExpress *)nativeAd
                                 withStatus:(nonnull NSError *)nativeAdStatus;

@optional

广告点击
- (void) nativeExpressAdDidClicked:(nonnull KAAdNativeExpress *)native;

广告落地页展示
- (void) nativeExpressAdDidPresentScreen:(nonnull KAAdNativeExpress *)nativeAd;

广告落地页关闭
- (void) nativeExpressAdDidDismissScreen:(nonnull KAAdNativeExpress *)nativeAd;
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

### 暂停展示广告
使用以下方法来暂停展示广告，在load到开始展示的这段时间里，你认为不再适合展示开屏广告，可以调用此方法来暂停展示
`KAAdSplash`

```Objective-c
[splash suspend];
```

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
* **Delegate** - id<KAAdBannerDelegate> 实例，用于接收广告事件回调
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

### 兑换码

输入兑换码兑换礼物

`KAPub`

```Objective-c
[KAPub redeemCode:<code> withDelegate:<Delegate>]
```
* **code** - 兑换码 (相关配置请联系运营人员获取)
* **Delegate** - id<KAPubConfigManagerDelegate>实例，用于接收兑换是否成功

使用以下回调接收兑换事件

`KAPubConfigManagerDelegate`

```Objective-c
/**
 * 将成功兑换回的数据包返回给代理进行处理,并返回对应的兑换码
 */
- (void) redeemCodeSuccessWithData:(NSDictionary *)data withCode:(NSString *)code;
/**
 * 兑换失败，返回错误码和对应的兑换码
 */
- (void) redeemCodeFailedWithError:(NSError *)error withCode:(NSString *)code;
```
### 支付
`KAPub`

支付

```Objective-c
[KAPub payWithIAPId:<iapId> withOrderId:<orderId> withDelegate:<Delegate>]
```
恢复购买

```Objective-c
[KAPub restoreCompletedTransactionsWithDelegate:<Delegate>]
```


* **iapId** - 平台计费点
* **orderId** - 订单Id（请保证每次传入的订单Id为唯一Id）
* **Delegate** - id<KAPubConfigManagerDelegate>实例，用于接收是否支付成功

使用以下回调接收支付事件

`KAPubConfigManagerDelegate `

```Objective-c
/**
 * 支付成功并返回平台计费点id
 */
- (void)paymentSuccessWithIapId:(NSString *)iapId;
/**
 * 支付失败返回平台计费点id和错误信息
 */
- (void)paymentFailedIapId:(NSString *)iapId withErrorInfo:(NSError *)error;
/**
 * 恢复购买失败
 */
- (void)restorePaymentFailed;
/**
 * 恢复购买成功并返回Apple计费点id
 */
- (void)restorePaymentSuccessWithIdentifier:(NSString *)iapId;
```

### PUSH


`KAPub`

在`UIApplicationDelegate`的代理方法中获取deviceToken

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
