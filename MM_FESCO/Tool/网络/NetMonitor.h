//
//  NetMonitorState.h
//  BlackCat
//
//  Created by bestseller on 15/10/13.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef NS_ENUM(NSUInteger,NetMonitorState){
    NetMonitorStateUnkown,
    NetMonitorStateWiFi,
    NetMonitorStateWWAN
};

@interface NetMonitor : NSObject
@property (readonly,atomic,assign) NetMonitorState _netMonitorState;
@property (atomic, readonly, copy) NSString *netStateExplain;

+ (NetMonitor *)manager;

@end
