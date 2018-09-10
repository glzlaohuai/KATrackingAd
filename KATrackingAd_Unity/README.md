>[中文文档](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_Unity/README_zh_CN.md)


# Getting Started with the KATracking Unity Plugin

* [About](#about)
* [SDK Set Up](#step1)
* [Additional Settings for iOS](#step2)
* [How To Run Sample Project](#step3)
* [Others](#step4)

## <a name="about">About</a>


* Support `interstitial`、`splash`、`rewardVideo`、`banner`
* Support iOS 8.0+
* [Download unity plugin](https://github.com/AppicPlay/KATrackingUnityPlugin/blob/master/KATrackingUnityPlugin.unitypackage)
* [Download unity sample project](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_Unity/KATrackingUnitySampleProj)
* Download Third Party AD SDKs： [part1](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_1.zip)，[part2](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_2.zip)，[part3](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_3.zip) 



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
	
	**Note:**`bannerSize` is an param of `Enum` type. Its option values are:`BANNER_SIZE_320_50 `、`BANNER_SIZE_480_60 `、`BANNER_SIZE_728_90 `
	
	**Note:**`x` and `y` indicate a position on the `ios` device's screen that the banner ad's center point is located at, e.g. if you want the banner ad be positioned at the bottom of the screen, and center in horizontal, we assume that the variables `screenWidth` and `screenHeight` represent the screen size, and `bannerSize` is `BANNER_SIZE_320_50 `, then `x` should be `screenWidth/2` and `y` should be `screenHeight-50/2`.
	
	**Note:**you can get the `ios` device's screen size by invoking the method:`KATracking.getIOSDeviceScreenSize();`
	
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
	There is no need to invoke the reward video load method manually, sdk will handle the load stuff itself.
	```
	
* check if reward video ad is ready or not:

	```
	KATracking.isRewardVideoADAvaliable()
	```
	
* show reward video ad:

	```
	KATracking.showRewardVideoAD();
	```
	
## <a name="step2">Additional Settings for iOS</a>

* build an ios project
* for the instructions [here](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README_EN.md) to set you ios project
* add third party ad sdks depend on your needs

		
## <a name="step3">How to run the sample project</a>

* open it in unity
* build an ios project out
* add all third party ad sdks to the ios project
* for the instructions [here](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README_EN.md) to set you ios project
* all done