//
//  BMJWNagationController.m
//  JewelryApp
//
//  Created by kequ on 15/6/7.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "HMNagationController.h"

@interface HMNagationController()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,assign)BOOL isAnimaiton;
@end

@implementation HMNagationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.delegate = self;
        self.interactivePopGestureRecognizer.delegate = self;
        self.isAnimaiton = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
     bar.barTintColor = [UIColor colorWithHexString:@"00b6d8"];
   [bar setTranslucent:NO];

    [bar setShadowImage:[UIImage new]];
    // 标题字体颜
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.myNavController setNavigationBarHidden:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

{
    if(self.isAnimaiton){
        return;
    }
    @try {
        [super pushViewController:viewController animated:animated];
        [viewController.navigationItem setHidesBackButton:YES];
        NSLog(@"viewController.navigationItem.leftBarButtonItem =  %@ %lu",viewController.navigationItem.leftBarButtonItem,[self.viewControllers count]);
        if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1)
            
        {
            viewController.navigationItem.leftBarButtonItems = @[[self barSpaingItem],[self createBackButton]];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if(self.isAnimaiton){
        return nil;
    }
    @try {
        UIViewController * controller = [super popViewControllerAnimated:animated];
        [controller.navigationItem setHidesBackButton:YES];
        return controller;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

- (BOOL)isAnimaiton
{
    return _isAnimaiton;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if(self.isAnimaiton){
        return nil;
    }
    return [super popToRootViewControllerAnimated:animated];
}

-(void)popself
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SELFBACK" object:nil];
    [self popViewControllerAnimated:YES];
    
}

-(UIBarButtonItem*) createBackButton
{
    
    CGRect backframe= CGRectMake(0, 0, 24, 24);
    
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame = backframe;

    [backButton setImage:[UIImage imageNamed:@"side"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"side"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    
    //定制自己的风格的  UIBarButtonItem
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
    
}

#pragma mark - 
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(animated)
        self.isAnimaiton = YES;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.isAnimaiton = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;//self.childViewControllers.count > 2;
}

@end
