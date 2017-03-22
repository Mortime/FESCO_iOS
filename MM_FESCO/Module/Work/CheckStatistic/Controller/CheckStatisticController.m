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

@property (nonatomic, strong) NSMutableArray *checkRecodeArray;

@property (nonatomic, strong) CheckStatisticFooterView *checkStatisticView;

@end

@implementation CheckStatisticController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"签到统计";
    self.view.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
    self.holidayNameArray = [NSMutableArray array];
    self.checkRecodeArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recodeDate) name:kDateChangeNotifition object:nil];
    

    FDCalendar *calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    calendar.backgroundColor = [UIColor clearColor];
    calendar.paramentVC = self;
    
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
    _footView.backgroundColor = [UIColor clearColor];


    FlagView *flagView = [[FlagView alloc] initWithFrame:CGRectMake(20, 0, self.view.width, 20)];
    flagView.backgroundColor = [UIColor clearColor];
    [self.footView addSubview:flagView];
    
    _checkStatisticView = [[CheckStatisticFooterView alloc] initWithFrame:CGRectMake(10, flagView.height + 10, self.view.width, 200)];
    _checkStatisticView.backgroundColor = [UIColor clearColor];
    [self.footView addSubview:_checkStatisticView];
    
    self.tableView.tableHeaderView = calendar;
    self.tableView.tableFooterView = self.footView;
     [self.view addSubview:self.tableView];
    
    [self initCheckData];
}
- (void)initCheckData{
    // 把选中的日期转化为字符串
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSString *dateStr = [dateFormat stringFromDate:[NSDate date]];
    MMLog(@"dateStr  ==== dateStr   ======= %@",dateStr);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dateStr forKey:kSignStatisticDate];
    [self recodeDate];

}
- (void)recodeDate{
    MMLog(@"我被通知了");
    NSString *dateStr = [[NSUserDefaults standardUserDefaults] objectForKey:kSignStatisticDate];
    [NetworkEntity postCheckCheckWithDate:dateStr success:^(id responseObject) {
                MMLog(@"CheckWithDate ===responseObject=========%@",responseObject);
                
        if ([[responseObject objectForKey:@"ceds"] count]) {
            [_checkRecodeArray removeAllObjects];
            for (NSDictionary *dic in [responseObject objectForKey:@"ceds"]) {
                NSString *checkTime = [NSDate dateFromSSWithDateType:@"HH:mm    yyyy-MM-dd" ss:[dic objectForKey:@"check_Time"]];
                NSString *checkType = @"";
                if ([[dic objectForKey:@"check_Type"] integerValue] == 1) {
                    checkType = @"签到";
                }else if ([[dic objectForKey:@"check_Type"] integerValue] == 2){
                    checkType = @"签退";
                }else if ([[dic objectForKey:@"check_Type"] integerValue] == 3){
                    checkType = @"外勤";
                }
                 NSString *checkAddress = [dic objectForKey:@"cust_Addr"];
                NSString *relult = [NSString stringWithFormat:@"%@    %@    %@",checkTime,checkType,checkAddress];
                [_checkRecodeArray addObject:relult];
            }
            NSString *result = @"";
            
            for (int i = 0; i < _checkRecodeArray.count; i++) {
                if (i == 0) {
                    result = _checkRecodeArray[i];
                }else{
                    result = [NSString stringWithFormat:@"%@\n%@",result,_checkRecodeArray[i]];
                }
            }
            

            _checkStatisticView.recodeStr = result;
        }else{
            _checkStatisticView.recodeStr = nil;
        }
        
        
        
    } failure:^(NSError *failure) {
        MMLog(@"CheckWithDate ===failure=========%@",failure);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
        
        
    }
    return _tableView;
}

@end
