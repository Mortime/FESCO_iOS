//
//  LaterTimeStatisticController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LaterTimeStatisticController.h"
#import "LaterTimeStatisticCell.h"
#import "LaterTimeStatisticModel.h"
@interface LaterTimeStatisticController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong)  NSMutableArray *dataArray;

@end

@implementation LaterTimeStatisticController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"迟到排行";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.dataArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self initData];
    
}
- (void)initData{
    [NetworkEntity postLaterTimeStatisticSuccess:^(id responseObject) {
        MMLog(@"laterTimeStatistic  =======responseObject=====%@",responseObject);
        if ([[responseObject objectForKey:@"rankList"] count]) {
            NSArray *array =  [responseObject objectForKey:@"rankList"];
            for (NSDictionary *dic in array) {
                LaterTimeStatisticModel *model = [LaterTimeStatisticModel yy_modelWithDictionary:dic];
                [self.dataArray addObject:model];
                
            }
            [_tableView reloadData];
        }
    } failure:^(NSError *failure) {
        MMLog(@"laterTimeStatistic  =======failure=====%@",failure);
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *cellID = @"cellID";
        LaterTimeStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[LaterTimeStatisticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
    // 从数组最后倒序取值
    NSInteger arrayCount = _dataArray.count - indexPath.row - 1;
    cell.model = _dataArray[arrayCount];
    
        return cell;
        
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
