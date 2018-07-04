# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /Users/glzlaohuai/Library/Android/sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}


# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /Users/liuqiang/Development/android-sdk-macosx/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}
#############################基本配置#############################
-dontshrink
-allowaccessmodification
# 指定代码的压缩级别
-optimizationpasses 7
# 是否使用大小写混合
-dontusemixedcaseclassnames
# 混淆时是否做预校验
-dontpreverify
# 屏蔽warning
-ignorewarnings
# 混淆时是否记录日志
-verbose
# 混淆时所采用的算法
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
-dontwarn
#-dontoptimize
-keepattributes InnerClasses,LineNumberTable,Exceptions,SourceFile
-renamesourcefileattribute SourceFile
-dontskipnonpubliclibraryclassmembers
# 是否混淆第三方jar

-keep public class * extends android.app.Fragment
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class com.android.vending.licensing.ILicensingService
-keep class **.R$* {*;}
-keep class android.net.http.SslError
-keep class android.webkit.**{*;}
-keepclasseswithmembernames class * {
    native <methods>;
}
-keepclasseswithmembernames class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}
-keepclasseswithmembernames class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}
-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}
-keepclassmembers class * {
   public <init>(org.json.JSONObject);
}
-keep class * extends android.os.AsyncTask { *;}

-keepnames class * implements java.io.Serializable
##support
-keep class android.support.**{*;}
-dontwarn android.support.**

#############################基本配置#############################

#appicsdk
-keep class * implements com.appicplay.sdk.core.APApplicationInvoker

#inmobi混淆配置
-keepattributes SourceFile,LineNumberTable
-keep class com.inmobi.** {*;} 
-keep public class com.google.android.gms.** 
-dontwarn com.google.android.gms.** 
-dontwarn com.squareup.picasso.** 
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient { public *; } 
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient$Info { public *; } 
# skip the Picasso library classes 
-keep class com.squareup.picasso.** {*;} 
-dontwarn com.squareup.picasso.** 
-dontwarn com.squareup.okhttp.** 
# skip Moat classes 
-keep class com.moat.** {*;} 
-dontwarn com.moat.**
# skip AVID classes
-keep class com.integralads.avid.library.* {*;}


#gdt 混淆配置
-keep class com.qq.e.** {
    public protected *;
}

