//
//  KATracking.h
//  KATracking
//
//  Created by KA on 5/11/16.
//  Copyright © 2016 KA. All rights reserved.
//

@interface KATracking : NSObject
    
+ (KATracking *) sharedInstance;

- (void) initWithAppId:(NSString *)appid
               channel:(NSString *)channel;

- (NSString *) sdkVersion;

@end
