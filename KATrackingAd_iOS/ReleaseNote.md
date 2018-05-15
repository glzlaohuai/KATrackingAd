# 版本发布记录

## Ver3.3.1
## Release Date: 2018-5-15

* 修复原生广告点击事件重复上报bug

## Ver3.3
## Release Date: 2018-5-11

* KAAdNative 增加聚合功能
* isReady方法删除，仅供根据广告请求成功回调判断广告获取成功
* ka_adIconImageView 修改成 ka_adIcon, UIImage
* ka_adImage 大图广告素材通过 primaryViewOfSize 方法获取
* 增加 recyclePrimaryView 方法回收广告资源
* nativeAdLandingPageAtPoint 现在返回 NSURL
