//
//  JZUserLoginManager.m
//  Headmaster
//
//  Created by ytzhang on 16/5/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZUserLoginManager.h"
#import "MMLoginController.h"

@implementation JZUserLoginManager
// 获得登录窗体
+ (UIViewController *)loginController {
    
    static MMLoginController *loginVC = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        loginVC = [MMLoginController new];
    });
    return loginVC;
}

@end
