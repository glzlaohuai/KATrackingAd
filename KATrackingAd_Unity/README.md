>[中文文档](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_Unity/README_zh_CN.md)


# Get Start with the KATracking Unity Plugin

* [Before you get started](#about)
* [Integrate](#step1)
* [Additional Settings for iOS](#step2)
* [Additional Settings for Android](#step3)

## <a name="about">Before you get started</a>


* Support `interstitial`、`splash`、`rewardVideo`、`banner`
* Support iOS 8.0+、Android 4.0+
* [Download unity plugin](https://github.com/KATracking/KATrackingAd/releases)
* [Download unity sample project](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_Unity/KATrackingUnitySampleProj)
* Download iOS Third Party AD SDKs from [here](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS_new/README_EN.md#download-the-sdk-zip-package-for-integration)
* [Android Third Party AD SDKs](https://github.com/KATracking/KATrackingAd/tree/master/AppicPlayAD_Android/ThirdParyADLibs)


## <a name="step1">Integrate</a>

* Import ad sdk plugin into your project

* Invoke sdk's initialization method at your game's entrance point:

	```
	KATracking.init("appID", "channelID");
	```
	
* add callback methods for the ad events that you might be interested in like this:

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
	
* remove callback methos when you do not need them:

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
	
* load and show splash ad:

	```
	KATracking.showSplash("slotID");
	```
	
* load interstitial ad:

	```
	KATracking.loadInterstitial("slotID");
	```
	
	**Note**: Because it need time to complete the load stuff, so you should invoke the load method at a proper time before trying to display it.
	
	**Note**: Make sure not to invoke this method inside its loadFailed delegate method, for in some extreme occasions(bad networks or current no ad fill temporarily), doing this will cause a frequent load interstitial request and result in a bad performance in the integrated game. The proper time to invoke this method should be the time when the 'interstitial show event' is triggered.
	
* check if interstitial ad is ready or not:

	```
	KATracking.isInterstitialAvaliable("slotID");
	```
	
* show interstitial ad:

	```
	KATracking.showInterstitial("slotID");
	```
	
* load and show banner ad:

	```
	KATracking.loadAndPresentBanner("slotID", bannerSize, x, y);
	```
	
	**Note:** `bannerSize` is an param of `Enum` type. Its option values are:`BANNER_SIZE_320_50 `、`BANNER_SIZE_480_60 `、`BANNER_SIZE_728_90`(`android` platform only support the size `BANNER_SIZE_320_50`)
	
	**Note:** `x` and `y` indicate a position on the `ios` device's screen that the banner ad's center point is located at, e.g. if you want the banner ad be positioned at the bottom of the screen, and center in horizontal, we assume that the variables `screenWidth` and `screenHeight` represent the screen size, and `bannerSize` is `BANNER_SIZE_320_50 `, then `x` should be `screenWidth/2` and `y` should be `screenHeight-50/2`.
	
	**Note:** you can get the device's screen size by invoking the method:`KATracking.getDeviceScreenSize();`
	
* hide banner ad:

	```
	KATracking.hideBanner("slotID");
	```
	
* show banner ad:

	```
	KATracking.showBanner("naArbAbz");
	```
	
* remove banner ad and destroy it:

	```
	KATracking.removeAndDestroyBanner("slotID");
	```
	
* load reward video ad:

	```
	There is no need to invoke the reward video load method manually(and also, the plugin do not provide this function), sdk will handle the load stuff itself.
	```
	
* check if reward video ad is ready or not:

	```
	KATracking.isRewardVideoADAvaliable()
	```
	
* show reward video ad:

	```
	KATracking.showRewardVideoAD();
	```
	
* get channel id：

	```
	KATracking.getChannelID();
	```
	
## <a name="step2">Additional Settings for iOS</a>
* add third party ad sdks depend on your needs (you can put the third party ad sdks' files in directory: `Assets/Plugins/iOS/KATracking/libs` or any other subdir under `Assets/Plugins/iOS/` depending on your favor)
* export an ios project
* follow the instructions [here](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS_new/README_EN.md) to set your ios project (during the exporting in previous step, the plugin has already done some of the settings for you, that include [add dependicies](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md#infoplist%E8%AE%BE%E7%BD%AE%E7%99%BD%E5%90%8D%E5%8D%95)、[set white list](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md#infoplist%E8%AE%BE%E7%BD%AE%E7%99%BD%E5%90%8D%E5%8D%95)、[add -ObjC linker flag](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README.md#infoplist%E8%AE%BE%E7%BD%AE%E7%99%BD%E5%90%8D%E5%8D%95) and set `Enable Bitcode` to `No`)


## <a name="step3">Additional Settings for Android</a>
* enable `Custom Gradle Template` in `Unity Editor`'s android player settings.
* add dependency `implementation 'com.android.support:support-v4:26.1.0'` to the generated `gradle` file's `dependency` block 
* export an `android` project and run it in `android studio`, if no error occurs, you can now send the exported android project to us, and we'll use your android pack tool to do the add third party ads stuff for you.
