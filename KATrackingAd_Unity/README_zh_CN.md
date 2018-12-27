>[English Doc](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_Unity/README.md)

# KATracking unity plugin 接入说明

* [关于](#start)
* [接入](#step1)
* [ios工程配置](#step2)
* [android工程配置](#step3)

## <a name="start">关于</a>

* 支持广告形式： `插屏`、`开屏`、`激励视频`、`横幅`
* 支持 iOS 8.0+、Android 4.0+;
* 支持平台：iOS、Android
* [下载KATrackingUnityPlugin;](https://github.com/KATracking/KATrackingAd/releases)
* [下载示例工程;](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_Unity/KATrackingUnitySampleProj)
* 点击下载iOS第三方广告sdk：[part1](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_1.zip)，[part2](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_2.zip) ，[part3](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_3.zip) 
* Android[第三方广告sdk](https://github.com/KATracking/KATrackingAd/tree/master/AppicPlayAD_Android/ThirdParyADLibs)


## <a name="step1">接入</a>

* 将sdk导入unity工程

* sdk初始化：

	在游戏开始位置执行sdk的初始化方法

	```
	KATracking.init("appID", "channelID");
	```

* 添加广告回调监听：

	```
	void setupDelegates()
    {
        KATracking.interstitialADLoadSuccess += interstitialLoadSuccess;
        KATracking.interstitialADClick += interstitialADClick;
        KATracking.interstitialADLoadFail += interstitialLoadFailed;
        KATracking.interstitialADPresent += interstitialADPresent;
        KATracking.interstitialADDismiss += interstitialADDismiss;

        KATracking.splashADClick += splashADClick;
        KATracking.splashADDismiss += splashDismiss;
        KATracking.splashPresentFail += splashPresentFail;
        KATracking.splashPresentSuccess += splashPresentSuccess;

        KATracking.rewardVideoADPresentComplete += rewardVideoPresentComplete;
        KATracking.rewardVideoADPresentFail += rewardVideoADPresentFail;
        KATracking.rewardVideoADPresentSkip += rewardVideoADPresentSkip;
        KATracking.rewardVideoADPresentSuccess += rewardVideoADPresentSuccess;

        KATracking.bannerPresentScreen += bannerBeClicked;
        KATracking.bannerLoadFailed += bannerLoadFailed;
        KATracking.bannerLoadComplete += bannerLoadComplete;
        KATracking.bannerPresentScreenDismissed += bannerPresentScreenDismissed;
    }
	```
* 移除广告回调监听:

	```
	void removeDelegates()
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
	```

* 展示开屏广告：

	```
	KATracking.showSplash("slotID");
	```
	
* 插屏广告加载：

	```
	KATracking.loadInterstitial("slotID");
	```
	
	**注**：由于插屏广告加载需要时间，所以需要在展示之前的合适时间提前执行插屏广告的加载方法
	
	**注**：请不要在插屏广告的失败回调方法中执行该方法，因为在某些极端情况下（网络状况不好、当前阶段暂时没有广告可填充）会导致频繁的执行插屏广告请求，从而影响接入游戏的性能。合适的执行插屏广告加载的时间点应该是当接入游戏的插屏展示事件被触发时。
	
	
* 检查插屏广告是否可用：

	```
	KATracking.isInterstitialAvaliable("slotID");
	```
	
* 展示插屏广告：

	```
	KATracking.showInterstitial("slotID");
	```
		
* 创建并展示横幅广告：

	```
	KATracking.loadAndPresentBanner("slotID", bannerSize, x, y);
	```
	**注：**`bannerSize`参数为枚举类型，可选值：`BANNER_SIZE_320_50`、`BANNER_SIZE_480_60`、`BANNER_SIZE_728_90`
	
	**注**：Android平台的`bannerSize`参数取值只支持`BANNER_SIZE_320_50`
	
	**注：**`x`和`y`参数用于设置横幅广告**中心**位置所处`ios`设备的屏幕坐标。例如，如果想将横幅广告在屏幕底部居中显示，假设屏幕宽高分别为：`screenWidth`、`screenHeight`，同时`bannerSize`为`BANNER_SIZE_320_50 `，那么参数`x`应该设置为：`screenWidth/2`，`y`应该设置为：`screenHeight-50/2`。
	
	**注**：可以使用方法：`KATracking.getDeviceScreenSize();`来获取设备屏幕尺寸
		
* 隐藏横幅广告：

	```
	KATracking.hideBanner("slotID");
	```

* 展示横幅广告：

	```
	KATracking.showBanner("slotID");
	```
	
* 将横幅广告移除并销毁：

	```
	KATracking.removeAndDestroyBanner("slotID");
	```
	
* 加载视频广告：

	```
	无需主动调用方法进行视频广告的加载，sdk会自己处理视频广告的加载
	```
	
* 检查视频广告是否可以展示：

	```
	KATracking.isRewardVideoADAvaliable()
	```
	
* 展示视频广告：

	```
	KATracking.showRewardVideoAD();
	```


## <a name="step2">iOS工程配置</a>

*  根据你的需要添加需要支持的第三方sdk（你可以将第三方sdk添加到文件夹：`Assets/Plugins/iOS/KATracking/libs`下，或者文件夹`Assets/Plugins/iOS/`下的任意你觉得合适的其他位置）
*  导出xcode工程
*  根据[这里](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md)的说明来配置导出的ios工程（插件在导出iOS工程时已经进行了一部分的设置，包括：[添加依赖库](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_iOS#%E5%8A%A0%E5%85%A5%E5%85%B6%E5%AE%83%E4%BE%9D%E8%B5%96%E5%BA%93)、[设置白名单](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md#infoplist%E8%AE%BE%E7%BD%AE%E7%99%BD%E5%90%8D%E5%8D%95)、[添加-ObjC linker flag](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md#infoplist%E8%AE%BE%E7%BD%AE%E7%99%BD%E5%90%8D%E5%8D%95)、`Enable Bitcode`设置为No）

## <a name="step3">Android工程配置</a>
*  根据[这里](https://github.com/KATracking/KATrackingAd/blob/master/AppicPlayAD_Android/README.md#thirdPartySDK)的说明来添加需要支持的三方广告sdk


