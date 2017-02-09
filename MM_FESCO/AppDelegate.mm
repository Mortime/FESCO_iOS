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
#import "AppDelegate+DealJPushMessage.h"



@interface AppDelegate ()

@property (nonatomic, strong) BMKMapManager *mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 启动图片延时: 1秒
    [NSThread sleepForTimeInterval:1];
    
   [self JPushApplication:application didFinishLaunchingWithOptions:launchOptions];    // 系统配置
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
    BOOL ret = [self.mapManager start:@"2u47gtqm2SsIW5fdsDRd0pnRQ2fG2LqO" generalDelegate:nil];
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
    EMOptions *options = [EMOptions optionsWithAppkey:@"1172160923115122#mm"];
//    options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

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
#pragma mark - JPush推送消息统一接受
    [self JPushfetchCompletionHandlerApplication:application didReceiveRemoteNotification:userInfo];
#pragma mark - JPush接受推送消息 require
    [self JPushApplication:application didReceiveRemoteNotification:userInfo];
    
}
// 注册APNs失败回调
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    MMLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// 注册本地通知
- (void)localNotificationWithApplication:(UIApplication *)application LaunchOptions:(NSDictionary *)launchOptions{

    NSDate *now = [NSDate date];
    

    //取得系统时间
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    components = [calendar components:unitFlags fromDate:now];
    NSInteger hour = [components hour];
    NSInteger min = [components minute];
    NSInteger sec = [components second];
    NSInteger week = [components weekday];
    MMLog(@"week = %lu",week);
    if (week <= 6) {
        [self newLocalNotifitionWithApplication:application LaunchOptions:launchOptions];
    }
    
}
     
- (void)newLocalNotifitionWithApplication:(UIApplication *)application LaunchOptions:(NSDictionary *)launchOptions{
    UIUserNotificationSettings *seting=[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    
    [application registerUserNotificationSettings:seting];
    
    
    UILocalNotification*local=[[UILocalNotification alloc]init];
    
    //给这些属性赋值才能让通知有特定的内容
    
    
    local.alertBody=@"亲,该上班了,记得签到哦!";
    
    local.timeZone = [NSTimeZone defaultTimeZone];
    
    //特定的时间让显示出来(从现在5秒后显示出来)
    
    //    local.fireDate=[NSDate dateWithTimeIntervalSinceNow:10];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    
    NSDate *date = [formatter dateFromString:@"08:20:00"];
    //通知发出的时间
    local.fireDate = date;
    local.repeatInterval = kCFCalendarUnitWeekday;
    
    
    
    //滑动解锁的文字(在推送通知信息的下面一小行字)
    
    local.alertAction =@"签到";
    
    //有声音给声音,没声音用默认的
    local.soundName = UILocalNotificationDefaultSoundName;
    //    local.soundName=@"UILocalNotificationDefaultSoundName";
    
    //        local.repeatInterval = kCFCalendarUnitSecond;
    
    //设置图标右上角数字
    
    local.applicationIconBadgeNumber = -1;
    
    //用户信息
    
    local.userInfo=@{@"name":@"亲",@"content":@"该签到了哦!",@"time":@"20180101"};
    
    //3:定制一个通知
    [UIApplication sharedApplication].applicationIconBadgeNumber = -1;
    
    
    [application scheduleLocalNotification:local];


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

@end
