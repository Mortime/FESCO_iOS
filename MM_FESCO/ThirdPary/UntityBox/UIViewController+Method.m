//
//  UIViewController+DivideAssett.m
//  SohuPhotoAlbum
//
//  Created by sohu on 13-4-27.
//  Copyright (c) 2013年 Qu. All rights reserved.
//

#import "UIViewController+Method.h"
#import <Accelerate/Accelerate.h>
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "ToastAlertView.h"

@implementation UIViewController(Tips)
- (MBProgressHUD *)waitForMomentsWithTitle:(NSString*)str withView:(UIView *)view
{
    if (!view) {
        view = [[[UIApplication sharedApplication] delegate] window];
    }
    MBProgressHUD * progressView = [[MBProgressHUD alloc] initWithView:view];
    progressView.animationType = MBProgressHUDAnimationZoomOut;
    progressView.labelText = str;
    [view addSubview:progressView];
    [progressView show:YES];
    return progressView;
}
-(void)stopWaitProgressView:(MBProgressHUD *)view
{
    if (view){
        [view removeFromSuperview];
    }
    else{
        for (UIView * view in self.view.subviews) {
            if ([view isKindOfClass:[MBProgressHUD class]]) {
                [view removeFromSuperview];
            }
        }
        for (UIView * view in [[[UIApplication sharedApplication] delegate] window].subviews) {
            if ([view isKindOfClass:[MBProgressHUD class]]) {
                [view removeFromSuperview];
            }
        }
    }
        
}

- (void)showPopAlerViewWithMes:(NSString *)message withDelegate:(id<UIAlertViewDelegate>)delegate cancelButton:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIAlertView * popA = [[UIAlertView alloc] initWithTitle:nil message:message delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherButtonTitles, nil];
    [popA show];
}

- (void)showTotasViewWithMes:(NSString *)message
{
    if(!message || ![message isKindOfClass:[NSString class]] || ![message length]) return;
//    if (self.tabBarController) {
//        if([self.myNavController topViewController] != self.tabBarController) return;
//    }else{
//        if([self.myNavController topViewController] != self) return;
//    }

    ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:message];
    [alertView show];
}

- (void)showPopAlerViewWithMes:(NSString *)message
{
    [self showPopAlerViewWithMes:message withDelegate:nil cancelButton:@"确定" otherButtonTitles:nil];
}

@end

@implementation UIViewController(NavTab)

- (UINavigationItem *)myNavigationItem
{
    if (self.tabBarController) {
        return self.tabBarController.navigationItem;
    }
    return self.navigationItem;
}

- (UINavigationController *)myNavController
{
    if (self.tabBarController) {
//           [bar setShadowImage:[UIImage new]];
        
        return self.tabBarController.navigationController;
    }
    return self.navigationController;
}

- (void)resetNavBar
{
    self.myNavigationItem.title = nil;
    self.myNavigationItem.titleView = nil;
    
//    self.myNavigationItem.rightBarButtonItem = nil;
//    self.myNavigationItem.rightBarButtonItems = nil;
    
}


- (UIButton *)getBarButtonWithTitle:(NSString *)title
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [[button titleLabel] setFont:[UIFont systemFontOfSize:15.f]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    return button;
}

- (UIBarButtonItem*)barSpaingItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       
                                       target:nil action:nil];
    negativeSpacer.width = -0;
    return negativeSpacer;
}

- (UIButton *)myLeftButton
{
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 60, 34);
    backButton.tag = 200;
    return backButton;
}

-(UIButton*) createBackButton
{
    
    CGRect backframe= CGRectMake(0, 0, 16, 16);
    
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame = backframe;
    
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];    
    //定制自己的风格的  UIBarButtonItem
//    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return backButton;
    
}

- (void)navigationBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

@implementation UIViewController(MesList)

- (UITabBarController *)myTabBarcontroller
{
    NSArray * controllers = [self.myNavController viewControllers];
    if (controllers.count >= 2) {
        UITabBarController * tabBarController = [controllers objectAtIndex:1];
        if ([tabBarController isKindOfClass:[UITabBarController class]]) {
            return tabBarController;
        }
    }
    return nil;

}
- (void)jumpToMessageList
{
    NSArray * controllers = [self.myNavController viewControllers];
    if (controllers.count >= 2) {
        UITabBarController * tabBarController = [controllers objectAtIndex:1];
        if ([tabBarController isKindOfClass:[UITabBarController class]]) {
            [tabBarController setSelectedIndex:2];
        }
    }
}
@end


