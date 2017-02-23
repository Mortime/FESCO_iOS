//
//  AppDelegate+DealJPushMessage.m
//  studentDriving
//
//  Created by bestseller on 15/11/13.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "AppDelegate+DealJPushMessage.h"
#import "BLPFAlertView.h"
#import "PushInformationManager.h"

@interface AppDelegate () <JPUSHRegisterDelegate>

@end

@implementation AppDelegate (DealJPushMessage)
#pragma mark - JPush 载入

- (void)JPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    

    
}

//#pragma mark - 接受到本地通知
//- (void)JPushApplication:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
//}

#pragma mark - 接受推送消息
- (void)JPushApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];

}
#pragma mark - 统一处理消息
- (void)JPushfetchCompletionHandlerApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    MMLog(@"JPushfetchCompletionHandlerApplication userInfo:%@",userInfo);
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:YBNotif_HandleNotification object:nil userInfo:userInfo];
    
    // 应用正处理前台状态下，不会收到推送消息，因此在此处需要额外处理一下
//    if (application.applicationState == UIApplicationStateActive) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到推送消息"
//                                                        message:userInfo[@"aps"][@"alert"]
//                                                       delegate:nil
//                                              cancelButtonTitle:@"取消"
//                                              otherButtonTitles:@"确定",  nil];
//        [alert show];}
    
#endif
    
}

@end
