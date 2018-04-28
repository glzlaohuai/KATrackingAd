//
//  KATrackingAdobeLib.h
//  KATrackingAdobeLib
//
//  Created by glzlaohuai on 2018/4/26.
//  Copyright © 2018年 glzlaohuai. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>

#import <objc/runtime.h>

NSString *getStringFromFREObject(FREObject freObject);
void dispatchADEvent(NSString *adType,NSString *adEvent,NSString *slotID,NSString *msg);

void adobeLog(NSString *log);
