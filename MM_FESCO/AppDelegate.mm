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

//#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

//#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

//#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

//#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

//#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

//#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

//#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

//#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件


@interface AppDelegate ()

@property (nonatomic, strong) BMKMapManager *mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 启动图片延时: 1秒
    [NSThread sleepForTimeInterval:1];
    
    // 本地通知
    [self localNotificationWithApplication:application LaunchOptions:launchOptions];
    // 系统配置
     [self sysConfigWithApplication:application LaunchOptions:launchOptions];
    //  监听网络
    [NetMonitor manager];

    
    BOOL isGetNewTonkey = [MMLoginTool checkCancelAppointmentWithBeginTime];
    if (isGetNewTonkey) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTonkenChangeNotifition object:nil];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([UserInfoModel  isLogin]) {
        
//        MMMainController *mainVC = [[MMMainController alloc] init];
//        HMNagationController *NC = [[HMNagationController alloc] initWithRootViewController:mainVC];
        DVVTabBarController *taBar = [self homeTabBarView];
        
        self.window.rootViewController = taBar;

    }else{
        
        MMLoginController *loginVC = [[MMLoginController alloc] init];
        self.window.rootViewController = loginVC;
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
// 注册本地通知
- (void)localNotificationWithApplication:(UIApplication *)application LaunchOptions:(NSDictionary *)launchOptions{
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    // 设置触发通知的时间
//    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
//    NSLog(@"fireDate=%@",fireDate);
//    
//    notification.fireDate = fireDate;
//    // 时区
//    notification.timeZone = [NSTimeZone defaultTimeZone];
//    // 设置重复的间隔
//    notification.repeatInterval = kCFCalendarUnitSecond;
//    
//    // 通知内容
//    notification.alertBody =  @"该签到了";
//    notification.applicationIconBadgeNumber = 1;
//    // 通知被触发时播放的声音
//    notification.soundName = UILocalNotificationDefaultSoundName;
//    // 通知参数
//    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"签到" forKey:@"key"];
//    notification.userInfo = userDict;
//    
//    // ios8后，需要添加这个注册，才能得到授权
//    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
//                                                                                 categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//        // 通知重复提示的单位，可以是天、周、月
//        notification.repeatInterval = NSCalendarUnitDay;
//    } else {
//        // 通知重复提示的单位，可以是天、周、月
//        notification.repeatInterval = NSDayCalendarUnit;
//    }
//    
//    // 执行通知注册
//    [application scheduleLocalNotification:notification];
    
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
    
    UIUserNotificationSettings *seting=[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    
    [application registerUserNotificationSettings:seting];
    
    
    UILocalNotification*local=[[UILocalNotification alloc]init];
    
    //给这些属性赋值才能让通知有特定的内容
    
    local.alertBody=@"亲,该上班了,记得签到哦!";
    
    //特定的时间让显示出来(从现在5秒后显示出来)
    
//    local.fireDate=[NSDate dateWithTimeIntervalSinceNow:10];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    
        NSDate *date = [formatter dateFromString:@"09:22:00"];
        //通知发出的时间
        local.fireDate = date;
    
    if (!(week == 1 || week == 7)) {
        local.repeatInterval = kCFCalendarUnitDay;
    }



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
    
    
    [[UIApplication sharedApplication]scheduleLocalNotification:local];
    
    
    
    
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
    
    NSArray *controllerArray = @[ @"MMMainController",
                                  @"BuffetController",
                                  @"NewsController",
                                  @"ToolsController",
                                  @"MyController"];
    
   NSArray *titleArray = @[ @"工作", @"自助", @"资讯",@"工具",@"我的"];
    
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
