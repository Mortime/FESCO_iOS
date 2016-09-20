//
//  LeaveRecordView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveRecordView.h"
#import "LeaveApplyCell.h"

@interface LeaveRecordView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *leftTitleArray;

@property (nonatomic, strong) NSArray *placeTitleArray;

@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) UITableView *tableView;





@end

@implementation LeaveRecordView

- (instancetype)initWithFrame:(CGRect)frame  {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initData];
    }
    return self;
    
}
- (void)initUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.tableView];
    [self addSubview:self.commitButton];
    
}
- (void)initData{
    self.leftTitleArray = @[@"开始时间",@"截止时间",@"加班时长",@"时长单位",@"加班原因",@"审批人"];
    self.placeTitleArray = @[@"请选择开始时间",@"请选择截止时间",@"请输入加班时长",@"请选择时长单位",@"请输入加班原因",@"请选择审批人"];
}
#pragma mark - 刷新数据
- (void)refreshUI {
    
    [self.tableView reloadData];
}

#pragma mark - 刷新数据
- (void)networkRequest {
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44 + 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    static NSString *IDCell = @"cellID";
    LeaveApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[LeaveApplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
    
    //    cell.index = indexPat.row + 1;
    //    cell.listModel = self.viewModel.LeaveListArray[indexPat.row];
    
    cell.leftTitle = self.leftTitleArray[indexPat.row];
    cell.placeTitle = self.placeTitleArray[indexPat.row];
    
    return cell;
    
}
#pragma mark ---- Action
- (void)didClick:(UIButton *)sender{
    
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 50) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}

- (UIButton *)commitButton{
    if (_commitButton == nil) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.frame = CGRectMake(0, self.height - 50, self.width,50);
        [_commitButton setTitle:@"提交申请" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        [_commitButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        
        
    }
    return _commitButton;
}

@end
