>[中文文档](http://https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_Unity/README_zh_CN.md)


# Getting Started with the KATracking Unity Plugin

* [Before You Start](#start)
* [SDK Set Up](#step1)
* [Additional Settings for iOS](#step2)
* [How To Run Sample Project](#step3)

## <a name="start">Before You Start</a>


* Support `interstitial`、`splash`、`rewardVideo`
* Support Unity4.x, Unity5.x, Unity2017;
* Support iOS 8.0+;
* [Click Here to Download Latest SDK;](https://github.com/AppicPlay/KATrackingUnityPlugin/blob/master/KATrackingUnityPlugin.unitypackage.zip)
* [Click Here to Download Sample Unity Project;](https://github.com/AppicPlay/KATrackingUnityPlugin/blob/master/KATrackingUnitySampleProj.zip)
* [Click Here to Download Third Party AD SDKs;](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/MediationSDK.zip) 



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
*  Add a static link to: `Build Settings` -> `Other Linker Flags` -> `-ObjC`
*  Set deployment target: `General` -> `Deployment Info` -> `Deployment Target` -> `8.0` (8.0 or above depend on your need)
*  Add dependencies: `Build Phases` -> `Link Binary With Libraries`.
- GooleMobileAds.framework
- InMobiSDK.framework
- libGDTMobSDK.a
- AdSupport.framework
- AVFoundation.framework
- GLKit.framework
- StoreKit.framework
- SystemConfiguration.framework
- CFNetwork.framework
- CoreMotion.framework
- CoreLocation.framework
- CoreGraphics.framework
- CoreData.framework
- CoreText.framework
- QuartzCore.framework
- CoreTelephony.framework
- libxml2.tbd
- libc++.tbd
- libz.tbd
- KATracking.framework
- libsqlite3.0.tbd
- EventKit.framework
- EventKitUI.framework
- WebKit.framework
- Security.framework
- UIKit.framework
*  Add third party ad sdks depends on your need (till now we support:`Inmobi`、`Admob`、`GDT`、`CloudMobi`、`Vungle`. Click to download: [third party ad sdks](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_iOS/MediationSDK.zip)

## <a name="step3">How To Run The Sample Project</a>

* Open it in unity
* Export a Xcode project
* Add all the third party ad sdks into the xcode project
* Follow the above step([Additional Settings for iOS](#step2)) to set your project
* All done. Now you can build and run on your iphone or a simulator to see how it works, and also you can modify the `appID`、`appChannel`、`slotID`, and the sample project's bundleID and version to the same as your project's to see if everything works correctly.

