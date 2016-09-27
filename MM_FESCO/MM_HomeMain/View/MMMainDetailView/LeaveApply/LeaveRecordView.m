//
//  LeaveRecordView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveRecordView.h"
#import "LeaveRecordCell.h"
#import "LeavaRecordListModel.h"
#import "MMNoDataShowBGView.h"

@interface LeaveRecordView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MMNoDataShowBGView *noDataShowBGView;





@end

@implementation LeaveRecordView

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
    [self addSubview:self.noDataShowBGView];
    
}
#pragma mark - 刷新数据
- (void)refreshUI {
    
    [self.tableView reloadData];
}

#pragma mark - 刷新数据
- (void)networkRequest {
    [NetworkEntity postLeaveRecordListSuccess:^(id responseObject) {
        MMLog(@"LeaveRecordList ========responseObject=========%@",responseObject);
        [_dataArray removeAllObjects];
        if ([[responseObject objectForKey:@"list"] count] == 0) {
            [self refreshUI];
            return ;
        }
        for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
            LeavaRecordListModel *listModel = [LeavaRecordListModel yy_modelWithDictionary:dic];
            [_dataArray addObject:listModel];
        }
        [self refreshUI];

    } failure:^(NSError *failure) {
        MMLog(@"LeaveRecordList ========failure=========%@",failure);
        [_parementVC showTotasViewWithMes:@"网络错误"];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_dataArray.count == 0) {
        _noDataShowBGView.hidden = NO;
    }else{
        _noDataShowBGView.hidden = YES;

    }
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150 + 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    static NSString *IDCell = @"cellID";
    LeaveRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[LeaveRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
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


- (MMNoDataShowBGView *)noDataShowBGView{
    if (_noDataShowBGView == nil) {
        _noDataShowBGView = [[MMNoDataShowBGView alloc] initWithFrame:CGRectMake(0, 0,self.width,self.height)];
        _noDataShowBGView.imgStr = @"MM_NO_Recorder";
        _noDataShowBGView.hidden = YES;
    }
    return _noDataShowBGView;
}

@end
