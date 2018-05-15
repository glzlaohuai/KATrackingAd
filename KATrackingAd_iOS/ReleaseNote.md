# 版本发布记录

## Ver3.3
## Release Date: 2018-5-11

* 相较于3.3之前的版本，KAAdNative添加了以下修改以及结构变化
* KAAdNative 增加聚合功能
* isReady方法删除，仅供根据广告请求成功回调判断广告获取成功
* ka_adIconImageView 修改成 ka_adIcon, UIImage
* ka_adImage 大图广告素材通过 primaryViewOfSize 方法获取
* 增加 recyclePrimaryView 方法回收广告资源
* nativeAdLandingPageAtPoint 现在返回 NSURL
