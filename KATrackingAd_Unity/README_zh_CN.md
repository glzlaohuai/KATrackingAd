>[English Doc](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_Unity/README.md)

# APSDK unity plugin 接入说明

* [关于](#start)
* [广告接入](#step1)
* [支付接入](#pay)
* [ios工程配置](#step2)
* [android工程配置](#step3)

## <a name="start">关于</a>

* 支持广告形式： `插屏`、`开屏`、`激励视频`、`横幅`
* 支持 iOS 8.0+、Android 4.0+;
* 支持平台：iOS、Android
* [下载KATrackingUnityPlugin;](http://sayhey.oss-cn-shanghai.aliyuncs.com/sdk/android/APSDKUnityPlugin.unitypackage)
* [这里](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS_new/README_EN.md#download-the-sdk-zip-package-for-integration)下载iOS第三方平台的广告sdk


## <a name="step1">广告接入</a>

* 将sdk导入unity工程

* sdk初始化：

	在游戏开始位置执行sdk的初始化方法

	```
	APSDK.init("appID");
	```

* 添加广告回调监听：

	```
	void setupDelegates()
    {
        APSDK.interstitialADLoadSuccess += interstitialLoadSuccess;
        APSDK.interstitialADClick += interstitialADClick;
        APSDK.interstitialADLoadFail += interstitialLoadFailed;
        APSDK.interstitialADPresent += interstitialADPresent;
        APSDK.interstitialADDismiss += interstitialADDismiss;

        APSDK.splashADClick += splashADClick;
        APSDK.splashADDismiss += splashDismiss;
        APSDK.splashPresentFail += splashPresentFail;
        APSDK.splashPresentSuccess += splashPresentSuccess;

        APSDK.rewardVideoADPresentComplete += rewardVideoPresentComplete;
        APSDK.rewardVideoADPresentFail += rewardVideoADPresentFail;
        APSDK.rewardVideoADPresentSkip += rewardVideoADPresentSkip;
        APSDK.rewardVideoADPresentSuccess += rewardVideoADPresentSuccess;

        APSDK.bannerPresentScreen += bannerBeClicked;
        APSDK.bannerLoadFailed += bannerLoadFailed;
        APSDK.bannerLoadComplete += bannerLoadComplete;
        APSDK.bannerPresentScreenDismissed += bannerPresentScreenDismissed;
    }
	```
* 移除广告回调监听:

	```
	void removeDelegates()
    {
        APSDK.interstitialADLoadSuccess -= interstitialLoadSuccess;
        APSDK.interstitialADClick -= interstitialADClick;
        APSDK.interstitialADLoadFail -= interstitialLoadFailed;
        APSDK.interstitialADPresent -= interstitialADPresent;

        APSDK.splashADClick -= splashADClick;
        APSDK.splashADDismiss -= splashDismiss;
        APSDK.splashPresentFail -= splashPresentFail;
        APSDK.splashPresentSuccess -= splashPresentSuccess;

        APSDK.rewardVideoADPresentComplete -= rewardVideoPresentComplete;
        APSDK.rewardVideoADPresentFail -= rewardVideoADPresentFail;
        APSDK.rewardVideoADPresentSkip -= rewardVideoADPresentSkip;
        APSDK.rewardVideoADPresentSuccess -= rewardVideoADPresentSuccess;
    }
	```

* 展示开屏广告：

	```
	APSDK.showSplash("slotID");
	```
	
* 插屏广告加载：

	```
	APSDK.loadInterstitial("slotID");
	```
	
	**注**：由于插屏广告加载需要时间，所以需要在展示之前的合适时间提前执行插屏广告的加载方法
	
	**注**：请不要在插屏广告的失败回调方法中执行该方法，因为在某些极端情况下（网络状况不好、当前阶段暂时没有广告可填充）会导致频繁的执行插屏广告请求，从而影响接入游戏的性能。合适的执行插屏广告加载的时间点应该是当接入游戏的插屏展示事件被触发时。
	
	
* 检查插屏广告是否可用：

	```
	APSDK.isInterstitialAvaliable("slotID");
	```
	
* 展示插屏广告：

	```
	APSDK.showInterstitial("slotID");
	```
		
* 创建并展示横幅广告：

	```
	APSDK.loadAndPresentBanner("slotID", bannerSize, x, y);
	```
	**注：**`bannerSize`参数为枚举类型，可选值：`BANNER_SIZE_320_50`、`BANNER_SIZE_480_60`、`BANNER_SIZE_728_90`
	
	**注**：Android平台的`bannerSize`参数取值只支持`BANNER_SIZE_320_50`
	
	**注：**`x`和`y`参数用于设置横幅广告**中心**位置所处`ios`设备的屏幕坐标。例如，如果想将横幅广告在屏幕底部居中显示，假设屏幕宽高分别为：`screenWidth`、`screenHeight`，同时`bannerSize`为`BANNER_SIZE_320_50 `，那么参数`x`应该设置为：`screenWidth/2`，`y`应该设置为：`screenHeight-50/2`。
	
	**注**：可以使用方法：`APSDK.getDeviceScreenSize();`来获取设备屏幕尺寸
		
* 隐藏横幅广告：

	```
	APSDK.hideBanner("slotID");
	```

* 展示横幅广告：

	```
	APSDK.showBanner("slotID");
	```
	
* 将横幅广告移除并销毁：

	```
	APSDK.removeAndDestroyBanner("slotID");
	```
	
* 加载视频广告：

	```
	无需主动调用方法进行视频广告的加载，sdk会自己处理视频广告的加载
	```
	
* 检查视频广告是否可以展示：

	```
	APSDK.isRewardVideoADAvaliable()
	```
	
* 展示视频广告：

	```
	APSDK.showRewardVideoAD();
	```
	
* 获取渠道号：

	```
	APSDK.getChannelID();
	```

## <a name="pay">支付接入</a>
* **添加获取计费点列表回调**：

	```
	APSDK.IAPLoadFailed += MyIAPLoadFailedDelegate;
   APSDK.IAPLoadSuccess += MyIAPLoadSuccessDelegate;
	```
	
	* 计费点列表获取失败回调参数说明：

		参数	|	类型	|	说明
		---		|	---		|	---
		errorCode	|	int		|	错误码
		errorMsg	|	string		|	错误描述
		
	* 计费点列表获取成功回调参数说明：

		参数	|	类型	|	说明
		---		|	---		|	---
		iapList	|	List<>	|	计费点列表
		
	* 计费点结构说明：

		参数	|	类型	|	说明
		---		|	---		|	---
		iapID	|	string	|	计费点id
		channelIAPID	|	string	|	对应的渠道计费点id（大部分情况下你无需关心该参数）
		productName	|	string	|	产品名
		price	|	int		|	价格

* **获取计费点列表**：

	调用方法：`APSDK.loadIAPList(timeout);`
	
	**注**：`timeout`参数为超时时间，单位为毫秒

		
* **添加支付回调监听：**

	```
	void setupPayDelegates()
    {
        APSDK.PayFailed += MyPayFailedDelegate;
        APSDK.PaySuccess += MyPaySuccessDelegate;
    }
	```
	
	* 支付失败回调参数说明：

		参数	|	类型	|	说明
		---		|	---		|	---
		iapID	|	string		|	调用支付时传入的计费点id
		orderID	|	string	|	调用支付时传入的订单号
		errorCode	|	int		|	错误码
		errorMsg	|	string		|	错误描述
		
	* 支付成功回调参数说明：

		参数	|	类型	|	说明
		---		|	---		|	---
		iapID	|	string		|	调用支付时传入的计费点id
		orderID	|	string	|	调用支付时传入的订单号

* **调起支付：**

	使用方法：`APSDK.pay("orderID", "iapID");`来调起来支付功能
	
* **添加兑换码监听回调：**

	```
	void setupRedeemCodeDelegates()
    {
		APSDK.RedeemFailed += MyRedeemFailed;
		APSDK.RedeemSuccess += MyRedeemSuccess;
    }
	```
	* 兑换码失败回调参数说明：

		参数	|	类型	|	说明
		---		|	---		|	---
		redeemCode	|	string		|	传入的兑换码id
		errorCode		|	int		|	错误码
		errorMsg		|	string		|	错误描述
		
	* 兑换码成功回调参数说明：

		参数	|	类型	|	说明
		---		|	---		|	---
		redeemCode	|	string		|	传入的兑换码
		jsonString		|	string		|	兑换成功后返回的json格式的字符串
		redeemData		|	Dictionary	|	兑换成功后使用jsonString构造的dictionary结构数据（游戏中也可以自行使用返回的jsonString来构造Dictionary）

*	**查单：**

	使用方法：`APSDK.checkOrder("orderID");`来进行查单。
	
*	**添加查单结果回调：**

	```
		APSDK.CheckOrderFailed += APSDK_CheckOrderFailed;
        APSDK.CheckResultOrderCompleted += APSDK_CheckResultOrderCompleted;
        APSDK.CheckResultOrderNotCompleted += APSDK_CheckResultOrderNotCompleted;
        APSDK.CheckResultOrderCompletedAndHasAlreadyCheckedBefore += APSDK_CheckResultOrderCompletedAndHasAlreadyCheckedBefore;
	```
	*	查单结果回调说明：

		回调	|	说明
		---		|	---
		CheckOrderFailed		|	由于网络或者其他原因，检查失败，收到这个回调之后游戏应当在适当时机重新进行查单操作
		CheckResultOrderCompleted	|	该笔订单已支付成功
		CheckResultOrderNotCompleted	|	该笔订单未支付成功
		CheckResultOrderCompletedAndHasAlreadyCheckedBefore	|	该笔订单已支付成功且之前已经对该订单执行过查单操作且之前进行查单操作时回调过：`CheckResultOrderCompleted `

	
* **使用兑换码：**

	```
	APSDK.redeemCode("redeemCode");
	```	
* **游戏暂停：**

	游戏暂停时，调用方法：

	```
	APSDK.pauseGame();
	```
* **退出游戏：**

	退出游戏时，调用方法：
	```
	APSDK.exitGame();
	```		
* **查看渠道是否支持游戏退出方法：**

	```
	APSDK.hasSpecialExitGameMethod();
	```
* **查看渠道是否支持游戏暂停方法：**

	```
	APSDK.hasSpecialPauseGameMethod();
	```
		

## <a name="step2">iOS工程配置</a>

*  根据你的需要添加需要支持的第三方sdk（你可以将第三方sdk添加到文件夹：`Assets/Plugins/iOS/APSDK/libs`下，或者文件夹`Assets/Plugins/iOS/`下的任意你觉得合适的其他位置）
*  导出xcode工程
*  根据[这里](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS_new/README.md)的说明来配置导出的ios工程（插件在导出iOS工程时已经进行了一部分的设置，包括：[添加依赖库](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_iOS#%E5%8A%A0%E5%85%A5%E5%85%B6%E5%AE%83%E4%BE%9D%E8%B5%96%E5%BA%93)、[设置白名单](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md#infoplist%E8%AE%BE%E7%BD%AE%E7%99%BD%E5%90%8D%E5%8D%95)、[添加-ObjC linker flag](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md#infoplist%E8%AE%BE%E7%BD%AE%E7%99%BD%E5%90%8D%E5%8D%95)、`Enable Bitcode`设置为No）
*  如果要接入admob，需要在info.plist文件中添加admob相关配置，参见[这里](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS_new/README.md#%E6%8E%A5%E5%85%A5admob%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9)

## <a name="step3">Android工程配置</a>
*  在`Unity Editor`的`Player Settings`中勾选`Custom Gradle Template`
*  在上一步生成的`gradle`文件中添加依赖：`implementation 'com.android.support:support-v4:26.1.0'`到其`dependency`
*  导出apk，测试功能正常，将该apk发给我们来产出各个渠道包。


