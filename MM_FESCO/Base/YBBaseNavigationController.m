//
//  YBBaseNavigationController.m
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseNavigationController.h"

@interface YBBaseNavigationController ()

@end

@implementation YBBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // appearance 设置所有的UINavigationBar
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:[UIColor colorWithHexString:@"00b6d8"]];
    [bar setTintColor:[UIColor colorWithHexString:@"fefefe"]];
    // 标题字体颜色
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont italicSystemFontOfSize:16]}];
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
