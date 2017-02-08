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
@property (readwrite,nonatomic,assign) NetMonitorState _netMonitorState;
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

        _AFManager = [AFNetworkReachabilityManager sharedManager];
        [_AFManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"status");

            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    __netMonitorState = NetMonitorStateUnkown;
                    break;
                    case AFNetworkReachabilityStatusReachableViaWiFi:
                    __netMonitorState = NetMonitorStateWiFi;
                    _netStateExplain = @"WiFi";
                    break;
                    case AFNetworkReachabilityStatusReachableViaWWAN:
                    __netMonitorState = NetMonitorStateWWAN;
                    _netStateExplain = @"3G";
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
