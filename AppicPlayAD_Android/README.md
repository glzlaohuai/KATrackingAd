# AppicPlay AD SDK接入说明

* [关于](#start)
* [基础SDK接入](#step1)
* [加入第三方平台SDK](#step2)
* [接入原生广告](#step3)
* 

## <a name="start">关于</a>

* 只支持**原生广告**
* 下载[AppicPlay AD SDK](https://github.com/KATracking/KATrackingAd/blob/master/AppicPlayAD_Android/AppicPlaySDK.zip)
* 支持广告平台：**广点通**、**inmobi**、**头条**、**掌酷**

## <a name="step1">基础SDK接入</a>

* 下载[sdk](https://github.com/KATracking/KATrackingAd/blob/master/AppicPlayAD_Android/AppicPlaySDK.zip)并解压，将解压后的`AppicPlay_AD_xxx.aar`和`AppicPlay_Core_xxx.aar`文件加入工程依赖
* 接入工程的`app module`的`build.gradle`中添加依赖：

	```
	implementation 'com.android.volley:volley:1.1.0'
    implementation 'com.android.support:appcompat-v7:26.1.0'
    implementation 'com.android.support:support-v4:26.1.0'
	```
* `AndroidManifest.xml`的`application`节点下加入：

	```
	<provider
            android:name="android.support.v4.content.FileProvider"
            android:authorities="${applicationId}.fileprovider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/appicplay_file_path" />
        </provider>
	```
* `AndroidManiest.xml`的`application`节点加入配置：`android:hardwareAccelerated="true"`
* `AndroidManifest.xml`中加入权限：

	```
	<uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
	```
* `Application`的回调方法中分别做如下修改（工程如果没有自定义`Application`请自行加入）：
	*	`onCreate`回调方法：

		```
		@Override
    	public void onCreate() {
        super.onCreate();
        APLifeCycleInvoker.onApplicationCreate(this);
    	}
		```
	*	`attachBaseContext`回调方法：

		```
		@Override
    	protected void attachBaseContext(Context base) {
       	super.attachBaseContext(base);
       	APLifeCycleInvoker.onApplicationAttachBaseContext(base);
    	}
		```
* main activity 的`onCreate`回调方法中执行初始化（不建议在splash activity中执行初始化，因为初始化过程中会申请权限，而splash activity一般停留时间很短，会影响体验）：

	```
	APAD.init(this, "appID", "channelID");
	```
	**注**:`appID`和`channelID`的值将在您接入sdk时由我方相关对接人员提供。

## <a name="step2">加入第三方平台SDK</a>
* 受支持的第三方平台sdk在[这里](https://github.com/KATracking/KATrackingAd/tree/master/AppicPlayAD_Android/ThirdParyADLibs)查看
* `zk`文件夹内包含接入`掌酷`平台需要的所有配置，相应的：`inmobi`对应`inmobi`广告平台、`gdt`对应`广点通`广告平台、`tt`对应`头条`广告平台
* 第三方广告平台所需要的配置可能包含有：`jar、aar依赖项`（在`libs`文件夹内）、`build.gradle`文件中的自动依赖项（在`dependicies`文件夹内）、需要配置的权限（在`permissions`文件内）、`AndroidMnifest.xml`中需要添加的组件（`activity`、`service`、`receiver`、`provider`等内容）（在`components`文件内）、混淆配置项（在`proguard`文件内）
* 将需要支持的广告平台的所有内容加入到待接入工程中即可


	**注**：如果要加入`掌酷`广告平台，请联系我们索要`libs`文件夹下的依赖文件（`aar`格式的依赖文件）

## <a name="step3">接入原生广告</a>

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
	apNative.load();
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
