# KATracking Flash AIR SDK接入说明

* [关于](#start)
* [SDK接入](#step1)
* [编译适合自己需求的ANE](#step2)

## <a name="start">关于</a>

* 支持**插屏**、**开屏**、**激励视频广告**
* 支持**IOS 8.0+**（不支持android）
* ANE下载地址：[KATracking ANE](https://github.com/KATracking/KATrackingAd/blob/master/KATrackingAd_FlashAir/KATracking.ane)
* 提供的ANE内集成了一下几家广告平台：**广点通**、**admob**、**vungle**、**inmobi**、**unityad**。如果您不想将上面列举的广告平台sdk全部都集成到自己的工程中，那么可以按照[此处步骤说明](#step2)编译适合您自己需求的版本。


## <a name="step1">SDK接入</a>

* 将ane文件加入到工程中
* 在工程运行起始位置处加入以下代码：  
```
KATracking.initiate("appID","channelID");
```
**appID**和**channelID**的具体值请联系与您对接的人获取。
* 如果需要接收sdk运行过程中生成的**log信息**，和广告相关**回调事件**（例如广告加载完成、广告展示、广告被点击等），加入以下代码：
```
KATracking.instance.addEventListener(LogEvent.LOG_PRINT,receiveSDKLog);
KATracking.instance.addEventListener(KATrackingADEvent.AD_EVENT,receiveADCallback);
```
`receiveSDKLog`方法：
```
public function receiveSDKLog(e:LogEvent):void
{
trace("sdk's log："+e.log);
}
```
`receiveADCallback`方法:
```
public function receiveADCallback(e:KATrackingADEvent):void
{
var msg :String = "adType:"+e.adType+", event:"+e.eventType+", slotID:"+e.slotID+",msg:"+e.msg;
trace("ad callback："+msg);
}
```
**KATrackingADEvent**中各个参数说明：其中`adType`表示广告类型（可能取值请见枚举类`KATrackingADType`中的定义），`eventType`表示事件类型（可能取值请见枚举类`KATrackingADEventType`中的定义），`slotID`为广告位ID（在调用sdk加载插屏和开屏广告方法时会使用到该值，见这里），`msg`为当广告请求出错时的错误提示信息。

* 加载插屏：
```
KATracking.instance.loadInterstitial("slotID");
```
`slotID`为该位置处展示的插屏的id，具体值请联系对接人员获取。（下面任何用到该参数的方法意义同此处）
* 检查插屏是否加载完毕：
```
KATracking.instance.isInterstitialReady("slotID");
```
* 展示插屏：
```
if(KATracking.instance.isInterstitialReady("slotID")){
KATracking.instance.showInterstitial("slotID"); 
}
```
**注意**：因为插屏加载需要时间，所以在使用之前请先使用`loadInterstitial`方法进行插屏预加载，并且在每次使用`showInterstitial`方法展示成功之后立即使用`loadInterstitial`方法进行加载。

* 加载&展示开屏：
```
KATracking.instance.showSplash("slotID");
```
* 加载激励视频广告：
```
KATracking.instance.loadRewardVideo();
```
**注**：激励视频广告不需要指定slotID
* 检查激励视频广告是否加载完毕：
```
KATracking.instance.isRewardVideoADReady();
```
* 展示激励视频广告：
```
if(KATracking.instance.isRewardVideoADReady()){
KATracking.instance.showRewardVideo();
}
```

## <a name="step2">编译适合自己需求的ANE</a>

1. 下载[IOS工程](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_FlashAir/KATrackingAdobeLib)
2. 下载[编译配置](https://github.com/KATracking/KATrackingAd/tree/master/KATrackingAd_FlashAir/build)
3. 在xcode中打开ios工程，根据自己需求从工程中移除不需要的第三方sdk（第三方sdk在**ThirdPartyLibs**目录下）
4. 编译生成`simulator`适用的`.a`库文件和真机适用的`.a`库文件。然后使用`lipo`命令创建一个`fat`库文件，将该文件重命名为：`libKATracking.a`
5. 解压在`步骤2`中下载的编译配置文件（假设其目录为：**KABuildDir**），将`步骤4`中生成的`libKATracking.a`库文件覆盖掉`<KABuilderDir>/ios/`目录下的同名文件
6. 开始编译，打开终端，`cd`到**KABuildDir**目录下，执行命令：
`adt -package -target ane KATracking.ane extension.xml -swc KATracking.swc -platform iPhone-ARM -C ios . -platformoptions platformoptions.xml -platform default -C default . `
7. 如果一切运行正常，那么将在**KABuildDir**目录下生成ane文件：`KATracking.ane`
