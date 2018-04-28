> [中文文档](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_FlashAir/README_zh_CN.md)
# Get Start With KATracking Flash AIR SDK

* [About](#start)
* [Integrate SDK](#step1)
* [build your own ane file](#step2)

## <a name="start">About</a>

* Support **interstitial**、**splash**、**rewardVideo**
* support **IOS 8.0+**（android not supported）
* ANE download：[KATracking ANE](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_FlashAir/KATracking.ane)
* the `ane` we provide default contains these listed third party ad sdk：**广点通**、**admob**、**vungle**、**inmobi**、**unityad**。If you do not want to add them all，you can follow [build you own ane file](#step2) to build ane file fit your needs


## <a name="step1">sdk integerate</a>

* add ane file to your project
* add code at you project's entry point：  
```
KATracking.initiate("appID","channelID");
```
**appID** and **channelID** are provided by our operation manager.

* add codes listed below to observe the log message and the ad's callbacks:
```
KATracking.instance.addEventListener(LogEvent.LOG_PRINT,receiveSDKLog);
KATracking.instance.addEventListener(KATrackingADEvent.AD_EVENT,receiveADCallback);
```
method `receiveSDKLog`：
```
public function receiveSDKLog(e:LogEvent):void
{
trace("sdk's log："+e.log);
}
```
method `receiveADCallback`：
```
public function receiveADCallback(e:KATrackingADEvent):void
{
var msg :String = "adType:"+e.adType+", event:"+e.eventType+", slotID:"+e.slotID+",msg:"+e.msg;
trace("ad callback："+msg);
}
```

* load interstitial：
```
KATracking.instance.loadInterstitial("slotID");
```
`slotID` is provided by our operation manager.
```
KATracking.instance.isInterstitialReady("slotID");
```
* show interstitial：
```
if(KATracking.instance.isInterstitialReady("slotID")){
KATracking.instance.showInterstitial("slotID"); 
}
```

* load&show splash：
```
KATracking.instance.showSplash("slotID");
```
* load reward video：
```
KATracking.instance.loadRewardVideo();
```

* check if reward video ready to present：
```
KATracking.instance.isRewardVideoADReady();
```
* present reward video ad：
```
if(KATracking.instance.isRewardVideoADReady()){
KATracking.instance.showRewardVideo();
}
```

## <a name="step2">build your own ANE</a>

1. download [xcode project](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_FlashAir/KATrackingAdobeLib)
2. download [build config](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_FlashAir/build)
3. open xcode project, remove third party ad sdks that you do not need（in directory **ThirdPartyLibs**）
4. build a `fat` library and rename it to `libKATracking.a`
5. extract the zip file downloaded in step 2 to directory **KABuildDir**(or any other name if you like), move `libKATracking.a` file you just build in step 4 to directory:`KABuildDir/ios/` to replace the original `libKATracking.a` file.
6. open `terminal`，`cd` to directory **KABuildDir**, run command:
`adt -package -target ane KATracking.ane extension.xml -swc KATracking.swc -platform iPhone-ARM -C ios . -platformoptions platformoptions.xml -platform default -C default . `
7. if everything go well, the ane file will generated at **KABuildDir** root directory and named as: `KATracking.ane`.

