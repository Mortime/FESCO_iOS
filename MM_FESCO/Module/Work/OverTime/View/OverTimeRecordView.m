//
//  OverTimeRecordView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "OverTimeRecordView.h"
#import "OverTimeRecordCell.h"
#import "OverTimeRecordListModel.h"

@interface OverTimeRecordView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;





@end

@implementation OverTimeRecordView

- (instancetype)initWithFrame:(CGRect)frame  {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    
    }
    return self;
    
}
- (void)initUI{
    
    self.backgroundColor = [UIColor clearColor];
    self.dataArray = [NSMutableArray array];
    [self addSubview:self.tableView];
    
}

#pragma mark - 刷新数据
- (void)refreshUI {
    
    [self.tableView reloadData];
}

#pragma mark - 刷新数据
- (void)networkRequest {
    [NetworkEntity postOverTimeRecordListSuccess:^(id responseObject) {
//        MMLog(@"OverTimeRecordList ========responseObject=========%@",responseObject);
        [_dataArray removeAllObjects];
        if ([[responseObject objectForKey:@"list"] count] == 0) {
            [self refreshUI];
            return ;
        }
        for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
            OverTimeRecordListModel *listModel = [OverTimeRecordListModel yy_modelWithDictionary:dic];
            [_dataArray addObject:listModel];
        }
        [self refreshUI];
        
    } failure:^(NSError *failure) {
        MMLog(@"OverTimeRecordList ========failure=========%@",failure);
         [_parementVC showTotasViewWithMes:@"网络错误"];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130 + 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    static NSString *IDCell = @"cellID";
    OverTimeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[OverTimeRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
    cell.listModel = _dataArray[indexPat.row];

    return cell;
    
}
#pragma mark ---- Action
- (void)didClick:(UIButton *)sender{
    
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}

@end
