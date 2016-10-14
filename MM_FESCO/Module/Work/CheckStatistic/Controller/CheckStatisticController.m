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
#import "CheckStatisticFooterView.h"

@interface CheckStatisticController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *footView;

@property (nonatomic, strong) NSMutableArray *holidayNameArray;

@property (nonatomic, strong) CheckStatisticFooterView *checkStatisticView;

@end

@implementation CheckStatisticController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"签到统计";
    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    self.holidayNameArray = [NSMutableArray array];
    
    

    FDCalendar *calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    calendar.backgroundColor = [UIColor clearColor];
    calendar.paramentVC = self;
    
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 160)];
    _footView.backgroundColor = [UIColor clearColor];


    FlagView *flagView = [[FlagView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
    flagView.backgroundColor = [UIColor clearColor];
    [self.footView addSubview:flagView];
    
    _checkStatisticView = [[CheckStatisticFooterView alloc] initWithFrame:CGRectMake(20, flagView.height + 20, self.view.width, 80)];
    _checkStatisticView.backgroundColor = [UIColor clearColor];
    [self.footView addSubview:_checkStatisticView];
    
    self.tableView.tableHeaderView = calendar;
    self.tableView.tableFooterView = self.footView;
     [self.view addSubview:self.tableView];
    
    [self initData];
}
- (void)initData{
    
    
    
    // 获取剩余假期
    [NetworkEntity postHolidayNumberSuccess:^(id responseObject) {
        
        MMLog(@"HolidayNumber ===responseObject=========%@",responseObject);
        if ([responseObject allKeys].count) {
            for (NSDictionary *dic in [responseObject objectForKey:@"holPoolList"]) {
                NSString *holidayName = [dic objectForKey:@"hol_Name"];
                NSString *holidayNumber = [dic objectForKey:@"availableAllNum"];
                NSString *relult = [NSString stringWithFormat:@"%@: %@",holidayName,holidayNumber];
                [_holidayNameArray addObject:relult];
            }
            NSString *result = @"";
            
            for (int i = 0; i < _holidayNameArray.count; i++) {
                if (i == 0) {
                    result = _holidayNameArray[i];
                }else{
                     result = [NSString stringWithFormat:@"%@天  %@小时",result,_holidayNameArray[i]];
                }
            }
//            for (NSString *str in _holidayNameArray) {
//               
//            }
            MMLog(@"checkStatisticView.holidayStr ==%@",result);
            _checkStatisticView.holidayStr = result;
            _checkStatisticView.recodeStr = @"kk";
            
            
        }
    } failure:^(NSError *failure) {
         MMLog(@"HolidayNumber ===failure=========%@",failure);
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
