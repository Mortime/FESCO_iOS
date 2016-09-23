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
    
     [self sysConfigWithApplication:application LaunchOptions:launchOptions];
    
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
