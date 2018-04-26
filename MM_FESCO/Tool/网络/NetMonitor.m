//
//  NetMonitorState.m
//  BlackCat
//
//  Created by bestseller on 15/10/13.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "NetMonitor.h"
#import <AFNetworkActivityIndicatorManager.h>

@interface NetMonitor ()
@property (strong, nonatomic) AFNetworkReachabilityManager *AFManager;
@end
@implementation NetMonitor
+ (NetMonitor *)manager {
    
    static NetMonitor *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
- (id)init {
    if (self = [super init]) {
        WS(ws);
        _AFManager = [AFNetworkReachabilityManager sharedManager];
        [_AFManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"status");

            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    ws.netMonitorState = NetMonitorStateUnkown;
                    break;
                    case AFNetworkReachabilityStatusReachableViaWiFi:
                    ws.netMonitorState = NetMonitorStateWiFi;
                    ws.netStateExplain = @"WiFi";
                    break;
                    case AFNetworkReachabilityStatusReachableViaWWAN:
                    ws.netMonitorState = NetMonitorStateWWAN;
                    ws.netStateExplain = @"3G";
                    break;
                    case AFNetworkReachabilityStatusNotReachable:
                {
                    ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"网络出错"];
                    [alertView show];
                
                }
                    
                default:
                    break;
            }
        }];
        
        [_AFManager startMonitoring];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}

@end
