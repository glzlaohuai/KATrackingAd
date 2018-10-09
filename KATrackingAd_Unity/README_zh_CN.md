>[English Doc](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_Unity/README.md)

# KATracking unity plugin 接入说明

* [关于](#start)
* [接入](#step1)
* [ios工程配置](#step2)
* [如何运行示例工程](#step3)
* [备注](#step4)

## <a name="start">关于</a>


* 支持广告形式： `插屏`、`开屏`、`激励视频`、`横幅`
* 支持 iOS 8.0+;
* [下载KATrackingUnityPlugin;](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_Unity/KATrackingUnityPlugin.unitypackage)
* [下载示例工程;](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_Unity/KATrackingUnitySampleProj)
* 点击下载第三方广告sdk：[part1](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_1.zip)，[part2](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_2.zip) ，[part3](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_3.zip) 


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
	
	**注：**`x`和`y`参数用于设置横幅广告**中心**位置所处`ios`设备的屏幕坐标。例如，如果想将横幅广告在屏幕底部居中显示，假设屏幕宽高分别为：`screenWidth`、`screenHeight`，同时`bannerSize`为`BANNER_SIZE_320_50 `，那么参数`x`应该设置为：`screenWidth/2`，`y`应该设置为：`screenHeight-50/2`。
	
	**注**：可以使用方法：`KATracking.getIOSDeviceScreenSize();`来获取ios设备的屏幕尺寸
		
* 隐藏横幅广告：

	```
	KATracking.hideBanner("slotID");
	```

* 展示横幅广告：

	```
	KATracking.showBanner("naArbAbz");
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


## <a name="step2">ios工程配置</a>

*  导出xcode工程
*  根据[这里](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md)的说明来配置导出的ios工程（插件在导出iOS工程时已经进行了一部分的设置，包括：[添加依赖库](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_iOS#%E5%8A%A0%E5%85%A5%E5%85%B6%E5%AE%83%E4%BE%9D%E8%B5%96%E5%BA%93)、[设置白名单](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md#infoplist%E8%AE%BE%E7%BD%AE%E7%99%BD%E5%90%8D%E5%8D%95)、[添加-ObjC linker flag](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md#infoplist%E8%AE%BE%E7%BD%AE%E7%99%BD%E5%90%8D%E5%8D%95)、`Enable Bitcode`设置为No）
*  根据你的需要添加第三方sdk

## <a name="step3">如何运行示例工程</a>

* 在unity中打开示例工程
* 导出xcode工程
* 添加所有的第三方sdk到工程中
* 根据[这里](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md)的说明来配置ios工程
* 可以运行了。