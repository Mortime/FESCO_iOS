//
//  CheckStatisticController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/12.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "CheckStatisticController.h"
#import "FDCalendar.h"
#import "FlagView.h"

@interface CheckStatisticController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CheckStatisticController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"签到统计";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    FDCalendar *calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    calendar.backgroundColor = [UIColor clearColor];

    FlagView *flagView = [[FlagView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
    flagView.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableHeaderView = calendar;
    self.tableView.tableFooterView = flagView;
     [self.view addSubview:self.tableView];
    
    [self initData];
}
- (void)initData{
    [NetworkEntity postCheckStatisticWithYear:2016 month:10 success:^(id responseObject) {
        MMLog(@"CheckStatistic ===responseObject=========%@",responseObject);
    } failure:^(NSError *failure) {
        MMLog(@"CheckStatistic ===failure=========%@",failure);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
        
        
    }
    return _tableView;
}

@end
