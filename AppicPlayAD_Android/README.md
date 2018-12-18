# 当前版本Ver.3.2.4 [ReleaseNote](https://github.com/KATracking/KATrackingAd/blob/master/AppicPlayAD_Android/ReleaseNote.md)
# AppicPlay AD SDK接入说明

* [关于](#about)
* [基础SDK接入](#essential)
* [加入第三方平台SDK](#thirdPartySDK)
* [接入原生广告（模板模式）](#nativeAD)
* [接入原生广告（非模板模式）](#nativeADRaw)
* [接入开屏广告](#splashAD)
* [接入插屏广告](#interstitialAD)
* [接入横幅广告](#bannerAD)
* [接入激励视频广告](#videoAD)
* [关于权限申请](#permissions)
* [其他](#others)


## <a name="about">关于</a>

* 支持广告类型：**原生**、**开屏**、**插屏**、**横幅**、**激励视频**
* 下载[AppicPlay AD SDK](https://github.com/KATracking/KATrackingAd/blob/master/AppicPlayAD_Android/AppicPlaySDK.zip)

## <a name="essential">基础SDK接入</a>

* 下载[sdk](https://github.com/KATracking/KATrackingAd/blob/master/AppicPlayAD_Android/AppicPlaySDK.zip)并解压，将解压后的`AppicPlay_AD_xxx.aar`、`AppicPlay_Core_xxx.aar`文件加入工程依赖
* 接入工程的`app module`的`build.gradle`中添加依赖：

	```
	implementation 'com.android.volley:volley:1.1.0'
    implementation 'com.android.support:support-v4:26.1.0'
    implementation 'com.liulishuo.filedownloader:library:1.7.4'
	```
	
* `Application`的回调方法中分别做如下修改（工程如果没有自定义`Application`请自行加入）：
	*	`onCreate`回调方法：

		```
		@Override
    	public void onCreate() {
        super.onCreate();
        APApplication.onApplicationCreate(this);
    	}
		```
	*	`attachBaseContext`回调方法：

		```
		@Override
    	protected void attachBaseContext(Context base) {
       	super.attachBaseContext(base);
       	APApplication.onApplicationAttachBaseContext(base);
    	}
		```
* main activity 的`onCreate`回调方法中执行初始化（不建议在splash activity中执行初始化，因为初始化过程中会申请权限，而splash activity一般停留时间很短，会影响体验）：

	```
	APAD.init(this, "appID", "channelID");
	```
	**注**:`appID`和`channelID`的值将在您接入sdk时由我方相关对接人员提供。
	
	**注**：请勿将该方法调用放到`Application`的`onCreate`中，为了保证每次应用重新启动都会执行该方法（以保证配置的更新），请将该方法调用放到`Activity`的`onCreate`方法中。

* `proguard`配置：

	```
	-keep class * implements com.appicplay.sdk.core.APApplicationInvoker
	
	```

## <a name="thirdPartySDK">加入第三方平台SDK</a>
* 受支持的第三方平台sdk在[这里](https://github.com/KATracking/KATrackingAd/tree/master/AppicPlayAD_Android/ThirdParyADLibs)查看
* `inmobi `文件夹内包含接入`inmobi`平台需要的所有配置，相应的：`gdt`对应`广点通`广告平台、`tt`对应`头条`广告平台、`unity`对应`unity`广告平台、`vungle`对应`vungle`广告平台、`tcash`对应`tcash`广告平台
* 第三方广告平台所需要的配置可能包含有：`jar、aar`依赖项（在`libs`文件夹内）、`build.gradle`文件中的依赖项（在`dependicies`文件夹内）、需要配置的权限（在`permissions`文件内）、`AndroidMnifest.xml`中需要添加的组件（`activity`、`service`、`receiver`、`provider`等内容）（在`components`文件内）、混淆配置项（在`proguard`文件内）
* 将需要支持的广告平台的所有内容加入到待接入工程中即可


## <a name="nativeAD">接入原生广告(模板方式)</a>

**注**：原生广告有两种接入方式：`模板方式`、`非模板模式`，在`模板模式`下，原生广告会提供方法来很方便的获取一个`view`，同时该view会处理相应的touch事件，方便开发者接入。而在`非模板模式`下，需要开发者自行处理原生广告的布局，同时sdk会提供相应方法来处理开发者自行进行的广告布局的touch事件。

**注**：默认接入方式为：`模板方式`，可以通过调用方法：`apNativeInstance.setPattern(patternEnum)`来进行设置。

1. **创建原生广告实例：**

	```
	APNative apNative = new APNative(activity, "slotID", listener);
	```
	参数	|	说明
	---	|	---
	activity	|	创建该实例所处的activity
	slotID	|	广告位id
	listener	|	原生广告加载结果回调
1. **设置期望返回广告大图尺寸：**

	```
	apNative.setPreferImageSize(int,int)
	```
	**注**：实际返回图片尺寸可能与期望尺寸不同
1. **广告load：**

	```
	apNative.loadNative();
	```
1. **加载成功后（收到加载成功的回调），从APNative实例中获取广告相关内容：**

	说明	|	获取方法
	---	|	---
	icon地址	|	`getIconUrl`
	image地址	|	`getImageUrl`
	描述文字	|	`getDesc`
	标题文字	|	`getTitle`
	响应按钮的文字（可能包含的值：“查看详情”、“下载”等）	|	`getActionText`
	获取包含广告内容的view	|	`getExposureView`
1. **将广告内容添加到容器中：**

	使用方法：`getExposureView(viewContainer,viewWidth)`来获得待添加到广告容器中的view
	
	参数	|	说明
	---	|	---
	viewContainer	|	广告容器
	viewWidth	|	待展示view的宽度，如果传值`APNative.MATCH_PARENT`，那么宽将于`viewContainer`相同，否则将按实际传的值来设置view的宽（单位px），返回view的高度将按照广告物料宽高比自行设置
	
	**注**：返回的view并不会自动添加到`viewContainer`中，需自行处理。
	
1. **当原生广告由adContainer展示出来之后（可以被用户看到）：**

	调用方法：`apNative.show();`
1. **在创建广告实例的activity的以下回调方法中分别执行`APNative`实例的相应方法：**

	* `onPause`回调方法中执行：`apNative.onPause();`
	* `onResume`回调方法中执行：`apNative.onResume();`
	* `onDestroy`回调方法中执行：`apNative.onDestroy();`
1. **当不再需要APNative实例时执行：**

	```
	apNative.destroy();
	```
	**注**：广告展示时必须将`getExposureView `返回的view添加到容器中，其他内容（如`adTitle`、`adDesc`、`adIcon`，返回内容可能为`null`）由开发者自行决定是否展示以及如何展示。
	
	
## <a name="nativeADRaw">接入原生广告(非模板方式)</a>


1. **创建原生广告实例：**

	```
	APNative apNative = new APNative(activity, "slotID", listener);
	```
	参数	|	说明
	---	|	---
	activity	|	创建该实例所处的activity
	slotID	|	广告位id
	listener	|	原生广告加载结果回调
	
1. **设置接入方式：**

	```
	apNative.setPattern(APNativePattern.RAW);
	```
	
	
1. **设置期望返回广告大图尺寸：**

	```
	apNative.setPreferImageSize(int,int)
	```
	**注**：实际返回图片尺寸可能与期望尺寸不同
1. **广告load：**

	```
	apNative.loadNative();
	```
1. **加载成功后（收到加载成功的回调），从APNative实例中获取广告相关内容：**

	说明	|	获取方法
	---	|	---
	icon地址	|	`getIconUrl`
	image地址	|	`getImageUrl`
	描述文字	|	`getDesc`
	标题文字	|	`getTitle`
	响应按钮的文字（可能包含的值：“查看详情”、“下载”等）	|	`getActionText`
	
1. **将广告内容添加到容器中：**

	根据自己应用的需求自行将需要展示的广告物料内容添加到布局中。
	
1. **对自行布局之后的广告容器进行事件注册：**

	使用方法：`apNative.registerViewForInteraction(viewContainer)`来进行touch/click的事件注册。
	
1. **当原生广告由adContainer展示出来之后（可以被用户看到）：**

	调用方法：`apNative.show();`
	
1. **在创建广告实例的activity的以下回调方法中分别执行`APNative`实例的相应方法：**

	* `onPause`回调方法中执行：`apNative.onPause();`
	* `onResume`回调方法中执行：`apNative.onResume();`
	* `onDestroy`回调方法中执行：`apNative.onDestroy();`
1. **当不再需要APNative实例时执行：**

	```
	apNative.destroy();
	```
	
## <a name="splashAD">接入开屏广告</a>
1. **创建开屏广告实例**：

	```
	APSplash splash = new APSplash(activity,slotID,listener);
	```

	参数	|	说明
	--- | ---
	activity	|	所处activity实例
	slotID	|	广告位id
	listener	|	开屏广告加载、展示、关闭等的结果回调
2. **加载&展示**

	```
	splash.loadAndPresent(splashViewContainer,bottomViewLayoutID);
	```
	
	参数	|	说明
	---	|	---
	splashViewContainer	|	承载广告内容的容器（容器类型为LinearLayout，要保证其`orientation`属性为`portrait`）
	bottomViewLayoutID	|	布局文件的id，如果广告平台返回的物料内容不足以填充全部广告容器，那么将由该布局填充，由于剩余空间高度不确定，请确保该布局能按高度自适应

3. **释放占用资源**
	
	开屏广告展示完毕之后，在合适的时机（绝对大多数情况应该是在展示开屏广告的activity的onDestroy回调方法中）调用方法：`splash.onDestroy()`

4. **`AndroidManifest.xml`配置**

	因为在请求开屏过程中可能会导致展示开屏的`activity`的朝向改变，所以，需要在`manifest`中为展示开屏广告的`activity`添加属性：`android:configChanges="keyboard|keyboardHidden|orientation|screenSize"`
	
	
## <a name="interstitialAD">接入插屏广告</a>
1. **创建插屏实例**

	`APInterstitial apInterstitial = new APInterstitial(activity, "slotID", interstitialListener`
2. **设置期望尺寸**

	`apInterstitial.setPreferImageSize(width, height);`

3. **加载插屏**

	`apInterstitial.loadInterstitial();`
	
4. **展示插屏**

	`apInterstitial.show();`
	
5. **释放资源**

	在不需要改插屏实例时（每次插屏展示完毕，需要再次展示时需要重新创建插屏实例），需要调用方法：`apInterstitial.onDestroy();`来释放所占用的资源。

## <a name="bannerAD">接入横幅广告</a>

1. **创建横幅广告实例**

	`APBanner banner = new APBanner(activity, "slotID", listener);`
	
1. **加载广告**

	`banner.loadBanner(bannerContainer);`
	
	**注**：bannerContainer尺寸：300dp*50dp
	
1. **释放资源**

	在不需要该横幅广告实例时（一般情况下，应该是在创建该实例所处的`activity`的`onDestroy`方法回调时）,调用方法：`banner.onDestroy();`来释放该实例所占用的资源。
	
1. **隐藏banner**

	`banner.hide();`
	
1. **展示banner**

	`banner.show()`
	
	**注**：banner加载成功之后会立即显示，不需额外调用`show`方法，该方法对应于`hide`方法，用于在调用`hide`方法后，要继续显示banner时使用。
	

## <a name="videoAD">接入激励视频广告</a>

**注**：激励视频不同于其他广告形式，使用单例模式，无需创建额外实例。

1. **设置激励视频回调**

	`APVideo.setListener(apVideoListener);`
	
1. **设置当前需要使用激励视频相关功能的activity**

	`APVideo.setActivity(currentActivity);`
	
1. **加载激励视频**

	`APVideo.loadVideoAD();`
	
1. **检查是否有可用的激励视频**

	`APVideo.isReady();`
	
1. **展示激励视频广告**

	`APVideo.showVideoAD(currentActivity);`
	


## <a name="permissions">关于权限申请</a>

* sdk需要动态申请的权限：`android.permission.READ_PHONE_STATE`、`android.permission.WRITE_EXTERNAL_STORAGE`、`android.permission.ACCESS_FINE_LOCATION`

* sdk在初始化（执行方法：`APAD.init(context,appID,channelID)`）时默认会申请所需要的权限（要保证传递的`context`参数为`Activity`类型）

* 调用方法：`APCore.setAutoRequestPermission(false)`可以让sdk在初始化时候不自动申请所需权限。

* 如果sdk初始化代码写在`splash activity`中或者其他只停留很短时间就跳到其他界面的activity中，建议为了有更好的用户体验关闭sdk自动申请权限的行为，在接入应用内处理权限申请，在未收到权限申请结果之前不进行activity的跳转和sdk的初始化。

## <a name="others">其他</a>

* 如果想在用户在非wifi环境时点击下载类型广告时进行弹窗提醒，那么可以使用方法：`APAD.setIsMobileNetworkDirectlyDownload(boolean)`进行设置，如果不进行设置，那么默认为`true`（亦即在非wifi环境下点击下载类广告时不进行提示而直接下载）。**由于部分广告平台未提供设置方法，所以该设置只在部分广告平台上生效。**

* sdk在执行初始化过程中会从服务器获取广告相关配置文件，各类型广告相关功能均依赖该配置文件中的相关配置，可以通过方法：`APAD.hasSDKEverInitedSuccess(context);`来检查是否sdk初始化成功（成功从服务器获取到配置文件）
* 由于sdk初始化完成需要大概几秒钟的时间（具体时间依赖当前的网络环境），而splash广告一般在启动应用时候就需要进行加载和展示，所以为了保证在sdk未初始化完成前也能正常进行开屏广告的加载和展示功能，sdk提供了方法：`APAD.useDefaultConfigForSplashIfNoConfigExist(context, "splashSlotID");`来为指定的开屏广告位设置默认配置以保证开屏广告在sdk未完成初始化时亦可以正常的加载。**该方法必须要在sdk初始化方法之后调用**。
