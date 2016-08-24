//
//  PhoneListController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/24.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PhoneListController.h"

@interface PhoneListController ()

@end

@implementation PhoneListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"通讯录";
    [self initData];
    
}
- (void)initData{
    [NetworkEntity postPhoneNumberListWithCustId:[UserInfoModel defaultUserInfo].custId success:^(id responseObject) {
        MMLog(@"PhoneListController =====responseObject =============%@",responseObject);
    } failure:^(NSError *failure) {
        MMLog(@"PhoneListController =====failure ==========%@",failure);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
