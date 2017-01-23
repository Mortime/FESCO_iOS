//
//  YBWelcomeController.m
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBWelcomeController.h"
#import "ViewController.h"
#import "MMLoginController.h"
#import "AppDelegate.h"
#import "JZUserLoginManager.h"

#pragma mark - 给NSString添加一个方法，用来获取当前的版本
@interface NSString(Version)

+ (NSString *)currentVersion;

@end

@implementation NSString(Version)

+ (NSString *)currentVersion {
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
    return currentVersion;
}

@end

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kVersion @"kVersion"


@interface YBWelcomeController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation YBWelcomeController

#pragma mark - 检测是否需要展示引导页
+ (BOOL)isShowWelcome {
    
    NSString *savedVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kVersion];
    if (savedVersion) {
        NSString *currentVersion = [NSString currentVersion];
        if ([savedVersion isEqualToString:currentVersion]) {
            return NO;
        }
    }
    return YES;
}

+ (void)removeSavedVersion {
    // 删除在本地保存的版本信息
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kVersion"];
}

#pragma mark 显示视图的方法
+ (void)show {
    // 不使用静态修饰，在ARC中可能会提前释放
    static UIWindow *window = nil;
    window = [UIWindow new];
    window.windowLevel = UIWindowLevelAlert;
    window.backgroundColor = [UIColor clearColor];
    window.rootViewController = [self new];
    [window makeKeyAndVisible];
}


#pragma mark - 保存当前的版本
- (void)saveVersion {
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString currentVersion] forKey:kVersion];
}

#pragma mark - 显示的内容
- (void)cycleCreateImageView:(NSArray *)nameArray {
    
    for (int i = 0; i < nameArray.count; i++) {
        
        UIImageView *imageView = [UIImageView new];
        imageView.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        imageView.image = [UIImage imageNamed:nameArray[i]];
        imageView.tag = i;
        
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(nameArray.count * SCREEN_WIDTH, 0);
    [self createGoButton:nameArray.count - 1];
}

#pragma mark 创建按钮
- (void)createGoButton:(NSInteger)tag {
    
    CGFloat btnWidth = 100;
    CGFloat btnHeight = 40;
    CGFloat btnBottom = 60;
    UIButton *button = [UIButton new];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:btnHeight / 2.f];
    [button setTitle:@"点击进入" forState:UIControlStateNormal];
    
    button.frame = CGRectMake((SCREEN_WIDTH - btnWidth) / 2, SCREEN_HEIGHT - btnHeight - btnBottom +  28, btnWidth, btnHeight);
    button.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:tag];
    imageView.userInteractionEnabled = YES;
    [imageView addSubview:button];
}

#pragma mark 按钮的点击事件
- (void)buttonAction:(UIButton *)sender {
    MMLoginController *loginVC = (MMLoginController *)[JZUserLoginManager loginController];
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = loginVC;
    
    
//    
//    [UIApplication sharedApplication].keyWindow.rootViewController.navigationController presentViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>
//    CGRect rect = self.view.frame;
//    rect.origin.x = -SCREEN_WIDTH;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.view.frame = rect;
//        self.view.alpha = 0;
//    } completion:^(BOOL finished) {
//        [self.view.window resignKeyWindow];
//        self.view.window.hidden = YES;
//    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger currentPage = scrollView.contentOffset.x / SCREEN_WIDTH;
    self.pageControl.currentPage = currentPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 保存版本号
    [self saveVersion];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    [self cycleCreateImageView:@[ @"one.jpg", @"two.jpg", @"three.jpg" ]];
    self.pageControl.numberOfPages = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - lazy load

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        // 弹簧效果
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.frame = CGRectMake(0, 50, SCREEN_WIDTH, 10);
        _pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.2];
        _pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
