//
//  NewPurchaseRecordController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/8.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewPurchaseRecordController.h"

@interface NewPurchaseRecordController ()

@end

@implementation NewPurchaseRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"新建消费记录";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    [self initData];
}
- (void)initData{
    
    [NetworkEntity postEditReimburseBookSuccess:^(id responseObject) {
                MMLog(@"EditReimburseBook  =======responseObject=====%@",responseObject);
    } failure:^(NSError *failure) {
                MMLog(@"EditReimburseBook  =======failure=====%@",failure);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
