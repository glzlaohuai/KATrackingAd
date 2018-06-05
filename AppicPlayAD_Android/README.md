# AppicPlay AD SDK接入说明

* [关于](#start)
* [基础SDK接入](#step1)
* [加入第三方平台SDK](#step2)
* [接入原生广告](#step3)

## <a name="start">关于</a>

* 只支持**原生广告**
* 点击下载[AppicPlay AD SDK](https://github.com/KATracking/KATrackingAd/blob/master/AppicPlayAD_Android/AppicPlaySDK.zip)
* 支持的广告平台：**广点通**、**inmobi**、**掌酷**

## <a name="step1">基础SDK接入</a>

* 下载[sdk](https://github.com/KATracking/KATrackingAd/blob/master/AppicPlayAD_Android/AppicPlaySDK.zip)并解压，将解压后的`core.aar`和`ad.aar`文件加入到工程中
* 在接入工程的`AndroidManifest.xml`文件的`application`节点下加入以下内容：  
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
* 在接入工程的`AndroidManifest.xml`文件的`application`节点中加入配置：`android:hardwareAccelerated="true"`
* 在接入工程的`AndroidManifest.xml`文件中加入以下权限：
```
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
```

* 接入工程的`application`的回调方法中分别添加以下方法：
* `onCreate`回调方法:
```
@Override
public void onCreate() {
super.onCreate();
APLifeCycleInvoker.onApplicationCreate(this);
}
```
* `attachBaseContext`回调方法：
```
@Override
protected void attachBaseContext(Context base) {
super.attachBaseContext(base);
APLifeCycleInvoker.onApplicationAttachBaseContext(base);
}
```

* 在应用的主activity（主activity指除非退出应用，否则一般不会被销毁的activity）的`onCreate`回调方法中加入以下代码：
```
APAD.init(this, "appID", "channelID");
```
**注**:`appID`和`channelID`的值将在您接入sdk时由跟您对接的我方相关人员提供。

## <a name="step2">加入第三方平台SDK</a>

* 所有受支持的第三方平台sdk可在[这里](https://github.com/KATracking/KATrackingAd/tree/master/AppicPlayAD_Android/ThirdParyADLibs)查看
* 其中`zk`文件夹内包含要接入`掌酷`广告平台所需要的所有配置，`inmobi`对应`inmobi`广告平台、`gdt`对应`广点通`广告平台
* 广告平台所需要的配置可能包含有：`jar、aar依赖项`（在`libs`文件夹内）、`build.gradle`文件中的自动依赖项（在`dependencies`文件内）、`AndroidManifest.xml`中需配置的权限（在`permissions`文件内）、`AndroidManifest.xml`中需要配置的组件（`activity`、`service`、`receiver`、`provider`等内容）（在`components`文件内）、混淆配置项（在`proguard`文件内）
* 将所需要的特定广告平台的特定内容加入到待接入工程中即可

**注**：如果您的工程要加入`掌酷`广告平台，我们将为您提供该平台的依赖文件（`aar格式的依赖文件`）

## <a name="step3">接入原生广告</a>

1. 创建原生广告实例：`APNative apNative = new APNative(activity, "slotID", adContainer, showDetailView, nativeADListener);`参数说明如下： 

参数    |   说明
--- |   ---
activity    |   创建该原生广告示例所处activity
slotID  |   广告位id
adContainer |   在广告加载完毕之后，将展示该广告的容器view（不能为空）
showDetailView  |   在广告展示时候，响应点击的组件（例如：“查看详情”按钮，不能为空，可与adContainer参数相同）
nativeADListener    |   原生广告加载回调

2. 加载广告：`apNative.load();`
3. 加载完毕之后，从`APNative`实例中获取相应物料下载地址，其中原生广告中包含的内容以及获取方法：

内容 | 获取方法 
---|--- | ---
icon地址    | `getIconUrl`
image地址   | `getImageUrl`
描述    |   `getDesc`
标题    |   `getTitle`
响应按钮的文字  |   `getActionText`

4. 当原生广告由`adContainer`展示出来之后，调用方法：`apNative.show();`

3. 在创建该实例的`activity`的以下回调方法中分别执行`APNative`实例的相应方法：
* `onPause`回调方法中执行：`apNative.onPause();`
* `onResume`回调方法中执行：`apNative.onResume();`
* `onDestroy`回调方法中执行：`apNative.onDestroy();`
4. 当不再需要展示该原生广告时执行方法：`apNative.destroy();`
