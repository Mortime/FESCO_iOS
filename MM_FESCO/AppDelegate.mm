//
//  AppDelegate.m
//  MM_FESCO
//
//  Created by Mortimey on 16/7/27.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "AppDelegate.h"
#import "MMMainController.h"
#import "MMLoginController.h"
#import "MMLoginTool.h"
#import "DVVTabBarController.h"
#import "MMMainController.h"
#import "BuffetController.h"
#import "NewsController.h"
#import "ToolsController.h"
#import "MyController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "NetMonitor.h"
#import "YBWelcomeController.h"
#import "PersonalMessageController.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "DVVTabBarController.h"
#import "LeaveApplyRecordController.h"
#import "OverTimeApplyController.h"
#import "CheckWorkController.h"



@interface AppDelegate ()<JPUSHRegisterDelegate>

@property (nonatomic, strong) BMKMapManager *mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 清空签到成功的时间
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:kSignUpTime] isEqualToString:[NSDate dateOfDayWithCurrTime]]) {
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        [def removeObjectForKey:kEmpIdKey];
    }
    // 启动图片延时: 1秒
    [NSThread sleepForTimeInterval:1];

     [self sysConfigWithApplication:application LaunchOptions:launchOptions];
    //  监听网络
    [NetMonitor manager];

    
    BOOL isGetNewTonkey = [MMLoginTool checkCancelAppointmentWithBeginTime];
    if (isGetNewTonkey) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTonkenChangeNotifition object:nil];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 引导页
    if ([YBWelcomeController isShowWelcome]) {
        self.window.rootViewController = [[YBWelcomeController alloc] init];
    }else{
        
        if ([UserInfoModel  isLogin]) {
            DVVTabBarController *taBar = [self homeTabBarView];
            
            self.window.rootViewController = taBar;
            
        }else{
            
            MMLoginController *loginVC = [[MMLoginController alloc] init];
            self.window.rootViewController = loginVC;
        }

    }
    
    
    
    	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self initMapSDk];
    
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}
- (void)initMapSDk{
    
    self.mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [self.mapManager start:@"E5QiVMrWUN85psuPQDoGRCglacIrHlKD" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    } else {
        NSLog(@"初始化成功！！");
    }
    
}
#pragma mark - 系统配置
- (void)sysConfigWithApplication:(UIApplication *)application LaunchOptions:(NSDictionary *)launchOptions
{
    // 配置环信
    EMOptions *options = [EMOptions optionsWithAppkey:@"1187170223115321#payrollpen"];
    options.apnsCertName = @"iOSJPushDev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    
    
    // 配置JPush
    [JPUSHService resetBadge];
    application.applicationIconBadgeNumber = 0;
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Required
    //@param isProduction 是否生产环境. 如果为开发状态,设置为 NO; 如果为生产状态,应改为 YES.
    [JPUSHService setupWithOption:launchOptions appKey:@"16bf989abad0ce9125fb0c73" channel:nil apsForProduction:NO];
    
    
    
    
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    [[EMClient sharedClient] bindDeviceToken:deviceToken];
}

/*

 在前台收到通知时，会调用下面这个方法,可以在这个方法里面实现收到通知时刷新或跳转界面的功能；程序在前台收到推送时通知栏不会弹出推送信息
 */
-(void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo{
    [JPUSHService handleRemoteNotification:userInfo];
}

// 当程序在后台收到推送时，如果info.plist中配置了UIBackgroundModes会调用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
    //推送消息统一处理
#warning YJG APP在前台接受到消息推送，处理消息逻辑
#warning YJG APP在在后台，点击消息提醒，唤醒APP，处理消息逻辑
    
#warning YJG 服务器发送 APP在前台接受到消息推送，处理消息逻辑
    /*
     {
     "_j_msgid" = 1612910701;
     aps =     {
     alert = "\U60a8\U5df2\U6210\U529f\U62a5\U540d\U9a7e\U6821\Uff0c\U8d76\U5feb\U5f00\U542f\U5b66\U8f66\U4e4b\U65c5\U5427";
     badge = 1;
     sound = "sound.caf";
     };
     data =     {
     userid = 5644b9549aedea5c3e02a4ac;
     
     };
     type = userapplysuccess;
     }
     */
    
    /*
     jpush后台自定义消息：
     {
     "_j_msgid" = 927937560;
     aps =     {
     alert = "\U6d4b\U8bd5\U63a8\U9001\U6d88\U606f";
     badge = 1;
     sound = default;
     };
     }
     */
    MMLog(@"userInfo = %@",userInfo);
//#pragma mark - JPush接受推送消息 require
//    [self JPushApplication:application didReceiveRemoteNotification:userInfo];
//#pragma mark - JPush推送消息统一接受
//    [self JPushfetchCompletionHandlerApplication:application didReceiveRemoteNotification:userInfo];
    
    [JPUSHService handleRemoteNotification:userInfo];
    
}
// 注册APNs失败回调
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    MMLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (DVVTabBarController *)homeTabBarView {
    
//    NSArray *controllerArray = @[ @"MMMainController",
//                                  @"BuffetController",
//                                  @"NewsController",
//                                  @"ToolsController",
//                                  @"MyController"];
        
    NSArray *controllerArray = @[ @"MMMainController",
                                  @"ApprovalController",
                                  @"ReimburseController",
                                  @"PhoneListController"];

    
//   NSArray *titleArray = @[ @"工作", @"自助", @"资讯",@"工具",@"我的"];
    
    NSArray *titleArray = @[ @"工作", @"审批", @"报销",@"通讯录"];
    
    DVVTabBarController *tabBarVC = [DVVTabBarController new];
    
    // 循环创建Controller
    for (NSInteger i = 0; i < controllerArray.count; i++) {
        
        Class vcClass = NSClassFromString(controllerArray[i]);
        UIViewController *viewController = [vcClass new];
        HMNagationController *naviVC = [[HMNagationController alloc] initWithRootViewController:viewController];
        viewController.title = titleArray[i];
        if (0 == i) {
            MMMainController *homeVC = (MMMainController *)viewController;
            tabBarVC.homeVC = homeVC;
        }
        if (1 == i) {
            BuffetController *buffetVC = (BuffetController *)viewController;
            tabBarVC.buffetVC = buffetVC;
        }
        if (2 == i) {
            NewsController *newsVC = (NewsController *)viewController;
            tabBarVC.newsVC = newsVC;
        }
        [tabBarVC addChildViewController:naviVC];
        if (3 == i) {
            ToolsController *toolsVC = (ToolsController *)viewController;
            tabBarVC.toolsVC = toolsVC;
        }
        [tabBarVC addChildViewController:naviVC];
        

        if (4 == i) {
            MyController *myVC = (MyController *)viewController;
            tabBarVC.myVC = myVC;
        }
        [tabBarVC addChildViewController:naviVC];
        

    }
    
    return tabBarVC;
}
/*
 * @brief handle UserNotifications.framework [willPresentNotification:withCompletionHandler:]
 * @param center [UNUserNotificationCenter currentNotificationCenter] 新特性用户通知中心
 * @param notification 前台得到的的通知对象
 * @param completionHandler 该callback中的options 请使用UNNotificationPresentationOptions
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

/*
 * @brief handle UserNotifications.framework [didReceiveNotificationResponse:withCompletionHandler:]
 * @param center [UNUserNotificationCenter currentNotificationCenter] 新特性用户通知中心
 * @param response 通知响应对象
 * @param completionHandler
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    [self handleInfoWithDict:userInfo];
}

// 跳转页面的基本处理
- (void)handleInfoWithDict:(NSDictionary *)dic{
  /*  {
        "_j_msgid" = 8560450051;
        aps =     {
            alert = "hello world!";
            badge = 1;
            sound = default;
        };
        extras = { "jumpTo":xxx }
   
   101=休假审批列表
   102=加班审批列表
   103=补签审批列表
   201=休假申请列表
   202=加班申请列表
   203=补签申请列表
   ;
    }
   */
    MMLog(@"推送统一处理消息");
    if (dic == nil) {
        return;
    }
    if ([dic objectForKey:@"extras"]) {
        NSDictionary *extrasDic = [dic objectForKey:@"extras"];
        
        NSInteger code = [[extrasDic objectForKey:@"jumpTo"] integerValue];
        // 审批
        if (code == 101 || code == 102 || code == 103) {
            PersonalMessageController *VC = [[PersonalMessageController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            DVVTabBarController *tbc = (DVVTabBarController *)self.window.rootViewController;
            [tbc seleItemWithIndex:1];
        }
        
        // 休假申请列表
        if (code == 201) {
            LeaveApplyRecordController *leaveVC = [[LeaveApplyRecordController alloc] init];
            leaveVC.hidesBottomBarWhenPushed = YES;
            DVVTabBarController *rootVC = (DVVTabBarController *)self.window.rootViewController;
                UINavigationController *NC = rootVC.selectedViewController;
                [NC pushViewController:leaveVC animated:YES];
        }
        
        // 加班申请列表
        if (code == 202) {
            OverTimeApplyController *overVC = [[OverTimeApplyController alloc] init];
            overVC.hidesBottomBarWhenPushed = YES;
            DVVTabBarController *rootVC = (DVVTabBarController *)self.window.rootViewController;
            UINavigationController *NC = rootVC.selectedViewController;
            [NC pushViewController:overVC animated:YES];
        }

        // 补签申请列表
        if (code == 203) {
            CheckWorkController *checkVC = [[CheckWorkController alloc] init];
            checkVC.hidesBottomBarWhenPushed = YES;
            DVVTabBarController *rootVC = (DVVTabBarController *)self.window.rootViewController;
            UINavigationController *NC = rootVC.selectedViewController;
            [NC pushViewController:checkVC animated:YES];
        }

        
    }
}

@end
