//
//  OverTimeStatistiscController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "OverTimeStatistiscController.h"
#import "OverTimeStatisticCell.h"
#import "OverTimeStatisticModel.h"

@interface OverTimeStatistiscController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong)  NSMutableArray *dataArray;

@end

@implementation OverTimeStatistiscController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"加班排行";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.dataArray = [NSMutableArray array];
//    self.tableView.tableHeaderView = [self tableHearderView];
    [self.view addSubview:self.tableView];  
    [self initData];
    
}
- (void)initData{
    
    [NetworkEntity postOverTimeStatisticSuccess:^(id responseObject) {
        
        MMLog(@"OverTimeStatistic  =======responseObject=====%@",responseObject);
        if ([[responseObject objectForKey:@"rankList"] count]) {
            
            NSArray *array = [self sortDurationWith:[responseObject objectForKey:@"rankList"]];
            for (NSDictionary *dic in array) {
                OverTimeStatisticModel *model = [OverTimeStatisticModel yy_modelWithDictionary:dic];
                [_dataArray addObject:model];
                
            }

        }
        [_tableView reloadData];
    } failure:^(NSError *failure) {
        MMLog(@"OverTimeStatistic  =======failure=====%@",failure);
    }];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return (_dataArray.count - 3);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    OverTimeStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[OverTimeStatisticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    // 从数组最后倒序取值
    NSInteger arrayCount = _dataArray.count - 3 - indexPath.row - 1;
    cell.model = _dataArray[arrayCount];
    
    return cell;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}
//  冒泡排序按照加班时长升序排序
- (NSArray *)sortDurationWith:(NSArray *)array{
    for (int i = 0; i < array.count - 1; i ++) {
        for (int j = 0 ; j < array.count - 1 - i; j ++) {
            if ([[array[j] objectForKey:@"duration"] floatValue] > [[array[j + 1] objectForKey:@"duration"] floatValue]) {
                NSDictionary *dic = array[j];
                array[j][@"duration"]  =  array[j + 1][@"duration"];
                array[j][@"emp_Name"]  =  array[j + 1][@"emp_Name"];
                array[j][@"counts"]  =  array[j + 1][@"counts"];
                
                array[j + 1][@"duration"] = dic[@"duration"];
                array[j + 1][@"emp_Name"] = dic[@"emp_Name"];
                array[j + 1][@"counts"] = dic[@"counts"];
                
            }
            
        }
    }
    
    MMLog(@"array排序后  ==  %@",array);
    return array;
}
@end
