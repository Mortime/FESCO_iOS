//
//  AppDelegate+DealJPushMessage.h
//  studentDriving
//
//  Created by bestseller on 15/11/13.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate (DealJPushMessage)
//启动收到请求
- (void)JPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
//接受到本地通知
//- (void)JPushApplication:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;

//注册token
//- (void)JPushApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

//接受推送消息
- (void)JPushApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

//统一处理推送消息
- (void)JPushfetchCompletionHandlerApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

@end
