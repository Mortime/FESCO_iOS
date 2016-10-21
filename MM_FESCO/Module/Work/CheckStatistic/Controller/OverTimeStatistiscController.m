//
//  OverTimeStatistiscController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "OverTimeStatistiscController.h"

@interface OverTimeStatistiscController ()

@end

@implementation OverTimeStatistiscController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"迟到排行";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
//    self.dataArray = [NSMutableArray array];
//    self.tableView.tableHeaderView = [self tableHearderView];
//    [self.view addSubview:self.tableView];
    [self initData];
    
}
- (void)initData{
    
    [NetworkEntity postOverTimeStatisticSuccess:^(id responseObject) {
        
        MMLog(@"OverTimeStatistic  =======responseObject=====%@",responseObject);
    } failure:^(NSError *failure) {
        MMLog(@"OverTimeStatistic  =======failure=====%@",failure);
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
