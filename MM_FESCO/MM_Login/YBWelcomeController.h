//
//  YBWelcomeController.h
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBWelcomeController : UIViewController

// 检测是否需要展示引导页
+ (BOOL)isShowWelcome;

// 显示视图的方法
+ (void)show;

// 测试引导页时调用此方法
+ (void)removeSavedVersion;

@end
