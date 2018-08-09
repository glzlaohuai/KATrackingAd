>[English Doc](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_Unity/README.md)

# KATracking unity plugin 接入说明

* [关于](#start)
* [接入](#step1)
* [ios工程配置](#step2)
* [如何运行示例工程](#step3)
* [备注](#step4)

## <a name="start">关于</a>


* 支持广告形式： `插屏`、`开屏`、`激励视频`
* 支持 Unity4.x、Unity5.x、 Unity2017、Unity2018;
* 支持 iOS 8.0+;
* [下载最新版本KATrackingUnityPlugin;](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_Unity/KATrackingUnityPlugin.unitypackage.zip)
* [点击下载示例工程;](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_Unity/KATrackingUnitySampleProj)
* 点击下载第三方广告sdk：[part1](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_1.zip)，[part2](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_2.zip) 



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
*  根据[这里](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md)的说明来配置导出的ios工程
*  根据你的需要添加第三方sdk

## <a name="step3">如何运行示例工程</a>

* 在unity中打开示例工程
* 导出xcode工程
* 添加所有的第三方sdk到工程中
* 根据[这里](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md)的说明来配置ios工程
* 可以运行了。

## <a name="step4">备注</a>

* 该plugin不支持iOS native sdk提供的[`原生广告`](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md#%E5%8E%9F%E7%94%9F%E5%B9%BF%E5%91%8A---native)类型以及不支持`开屏`广告的[`展示广告并添加产品标示`](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md#%E5%B1%95%E7%A4%BA%E5%B9%BF%E5%91%8A%E5%B9%B6%E6%B7%BB%E5%8A%A0%E4%BA%A7%E5%93%81%E6%A0%87%E8%AF%86)方法（这两部分都涉及到使用`UIView`，无法在unity端进行处理），如果您的产品中需要该功能，请参照plugin的现有代码自行修改添加。

