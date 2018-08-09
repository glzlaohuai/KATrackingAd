>[中文文档](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_Unity/README_zh_CN.md)


# Getting Started with the KATracking Unity Plugin

* [Before You Start](#start)
* [SDK Set Up](#step1)
* [Additional Settings for iOS](#step2)
* [How To Run Sample Project](#step3)
* [Others](#step4)

## <a name="start">Before You Start</a>


* Support `interstitial`、`splash`、`rewardVideo`
* Support Unity4.x、Unity5.x、Unity2017、Unity2018;
* Support iOS 8.0+;
* [Click Here to Download Latest SDK;](https://github.com/AppicPlay/KATrackingUnityPlugin/blob/master/KATrackingUnityPlugin.unitypackage)
* [Click Here to Download Sample Unity Project;](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_Unity/KATrackingUnitySampleProj)
* Click Here to Download Third Party AD SDKs： [part1](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_1.zip)，[part2](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/Mediation_2.zip) 



## <a name="step1">SDK Set Up</a>

* Import KATrackingUnityPlugin.unitypackage to your U3D project.

* Create a script and attach it to `Main Camera`. Then implement the `Awake` function as belows.(`appID` and `appChannel` are provided by AppicPlay operation manager)

```
using KATrackingAD;
void Awake () {
KATracking.init (appID,appChannel);
}
```

* Create a script and attach it to a Unity UIController which you'd like to show interstitial ad on. Then add the `load` and `show` methods as described below, and invoke the appropriate method as you need.(`slotID` is provided by AppicPlay operation manager)

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

## <a name="step2">Additional Settings for iOS</a>

*  Export a Xcode project.
*  Follow instructions [here](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README_EN.md) to set your exported project.
*  Add third party ad sdks depends on your need

## <a name="step3">How To Run The Sample Project</a>

* Open it in unity
* Export a Xcode project
* Add all the third party ad sdks into the xcode project
* Follow instructions [here](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/README_EN.md) to set your exported project.
* All done. Now you can build and run on your iphone or a simulator to see how it works, and also you can modify the `appID`、`appChannel`、`slotID`, and the sample project's bundleID and version to the same as your project's to see if everything works correctly.

## <a name="step4">Others</a>
* This plugin do not support `native ad ` and `splash ad`'s function: `[splash loadAndPresentWithViewController:<Controller> andBackgroundColor:<Color> andBottomView:<View> andBottomViewAutoFitDisplay:<Auto>];` (because these two sections all use `UIView` that we can't handle in`unity` side). If you really need these functions, please do it yourself.