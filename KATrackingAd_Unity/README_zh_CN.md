>[English Doc](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_Unity/README.md)

# KATracking unity plugin 接入说明

* [关于](#start)
* [接入](#step1)
* [ios工程配置](#step2)
* [如何运行示例工程](#step3)

## <a name="start">关于</a>


* 支持广告形式： `插屏`、`开屏`、`激励视频`
* 支持 Unity4.x, Unity5.x, Unity2017;
* 支持 iOS 8.0+;
* [下载最新版本KATrackingUnityPlugin;](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_Unity/KATrackingUnityPlugin.unitypackage.zip)
* [点击下载示例工程;](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_Unity/KATrackingUnitySampleProj)
* [点击下载第三方广告sdk;](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/MediationSDK.zip) 



## <a name="step1">接入</a>

* 将sdk导入unity工程

* 新建一个script，将该script添加到`Main Camera`（或者任何其他你认为合适的gameObject上），然后在该script的`Awake`方法中添加以下代码：
```
using KATrackingAD;
void Awake () {
KATracking.init (appID,appChannel);
}
```

* 创建script，添加广告相关的`load`和`show`方法，并将该script添加到合适的gameObject中。该script中方法如下：

```
void OnDisable ()
{
KATracking.interstitialADLoadSuccess -= interstitialLoadSuccess;
KATracking.interstitialADClick -= interstitialADClick;
KATracking.interstitialADLoadFail -= interstitialLoadFailed;
KATracking.interstitialADPresent -= interstitialADPresent;

KATracking.splashADClick -= splashADClick;
KATracking.splashADDismiss -= splashDismiss;
KATracking.splashPresentFail -= splashPresentFail;
KATracking.splashPresentSuccess -= splashPresentSuccess;

KATracking.rewardVideoADPresentComplete -= rewardVideoPresentComplete;
KATracking.rewardVideoADPresentFail -= rewardVideoADPresentFail;
KATracking.rewardVideoADPresentSkip -= rewardVideoADPresentSkip;
KATracking.rewardVideoADPresentSuccess -= rewardVideoADPresentSuccess;
}

void setupDelegates ()
{
KATracking.interstitialADLoadSuccess += interstitialLoadSuccess;
KATracking.interstitialADClick += interstitialADClick;
KATracking.interstitialADLoadFail += interstitialLoadFailed;
KATracking.interstitialADPresent += interstitialADPresent;

KATracking.splashADClick += splashADClick;
KATracking.splashADDismiss += splashDismiss;
KATracking.splashPresentFail += splashPresentFail;
KATracking.splashPresentSuccess += splashPresentSuccess;

KATracking.rewardVideoADPresentComplete += rewardVideoPresentComplete;
KATracking.rewardVideoADPresentFail += rewardVideoADPresentFail;
KATracking.rewardVideoADPresentSkip += rewardVideoADPresentSkip;
KATracking.rewardVideoADPresentSuccess += rewardVideoADPresentSuccess;
}


public void loadInterstitial ()
{
log ("loadInterstitial...");
KATracking.loadInterstitial ("DlGdpoGq");
}

public void showInterstitial ()
{
log ("show interstitial");
if (KATracking.isInterstitialAvaliable ("DlGdpoGq")) {
KATracking.showInterstitial ("DlGdpoGq");
}
}

public void loadSplash ()
{
log ("showSplash...");
KATracking.showSplash ("bPmPrQGq");
}

public void loadRewardVideo ()
{
log ("loadRewardVideo...");
KATracking.loadRewardVideoAD ();
}

public void showRewardVideoAD ()
{
log ("showRewardVideo...");
if (KATracking.isRewardVideoADAvaliable ()) {
KATracking.showRewardVideoAD ();
}
}
```

## <a name="step2">ios工程配置</a>

*  导出xcode工程
*  添加link flag：`-ObjC`: `Build Settings` -> `Other Linker Flags` -> `-ObjC`
*  设置 deployment target: `General` -> `Deployment Info` -> `Deployment Target` -> `8.0` (8.0或以上，根据你的项目需求)
*  添加以下依赖项: `Build Phases` -> `Link Binary With Libraries`.
* AdSupport.framework
* AVFoundation.framework
* GLKit.framework
* StoreKit.framework
* SystemConfiguration.framework
* CFNetwork.framework
* CoreMotion.framework
* CoreLocation.framework
* CoreGraphics.framework
* CoreData.framework
* CoreText.framework
* QuartzCore.framework
* CoreTelephony.framework
* libxml2.tbd
* libc++.tbd
* libz.tbd
* KATracking.framework
* libsqlite3.0.tbd
* EventKit.framework
* EventKitUI.framework
* WebKit.framework
* Security.framework
* UIKit.framework

*  根据你的需要添加第三方sdk (我们支持的三方sdk:`Inmobi`、`Admob`、`GDT`、`CloudMobi`、`Vungle`. 点击下载: [第三方广告sdk](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/MediationSDK.zip)

## <a name="step3">如何运行示例工程</a>

* 在unity中打开示例工程
* 导出xcode工程
* 添加所有的第三方sdk到工程中
* 根据步骤([ios工程配置](#step2)) 的描述来配置工程
* 可以运行了。

