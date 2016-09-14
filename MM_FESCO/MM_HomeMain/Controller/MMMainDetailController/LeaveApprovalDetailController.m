//
//  LeaveApprovalDetailController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveApprovalDetailController.h"
#import "TextMainApprovalDetailCell.h"
#import "FileMainApprovalDetailCell.h"
#import "MMBottomButton.h"
#import "MMTitleLabel.h"
#import "MMLeaveTitleView.h"


#define kHeaderH  144 - 42

#define kTitleLableW ((self.view.width - 1) / 2)

#define kTitleLableH ((kHeaderH - 1) / 2)

@interface LeaveApprovalDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) NSArray *topArray;

@property (nonatomic, strong) NSArray *bottomArray;

@property (nonatomic, strong) NSArray *mightArray;


@property (nonatomic, strong) NSArray *topDataArray;

@property (nonatomic, strong) NSArray *bottomDataArray;

@property (nonatomic, strong) NSArray *mightDataArray;

@property (nonatomic, strong) NSArray *pickDataArray;


@property (nonatomic, strong) MMBottomButton *bottomButton;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) NSArray *headerTopArray;

@property (nonatomic, strong) NSArray *headerBottomArray;

@end

@implementation LeaveApprovalDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请假审批";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomButton];
    self.topArray = @[@"请假原因"];
    self.topDataArray = @[@"地铁故障"];
    
    self.mightArray = @[@"审批意见",@"再次审批"];
    self.mightDataArray = @[@"请输入审批意见",@"请选择再次审批人"];
    
    self.bottomArray = @[@"前次审批",@"审批结果",@"审批意见"];
    self.bottomDataArray = @[@"2016年8月29",@"2016年8月90日",@"dlllll"];
    
    self.pickDataArray = @[@"小明",@"小红",@"小张",@"小赵",@"小孙"];
    
    self.headerTopArray = @[@"开始时间",@"截止时间"];
    
    self.headerBottomArray = @[@"2016年8月90日",@"2016年8月90日"];
    
    self.tableView.tableHeaderView = self.headerView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (0 == section) {
        return 1;
    }else if (1 == section) {
        return 2;
    }else{
        return 3;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.height, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellID = @"cellID";
        TextMainApprovalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[TextMainApprovalDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.leftTitle = self.topArray[indexPath.row];
        cell.rightTitle = self.topDataArray[indexPath.row];
        return cell;
        
    }
    if (indexPath.section == 1) {
        static NSString *cellID = @"cellID";
        FileMainApprovalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[FileMainApprovalDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.leftTitle = self.mightArray[indexPath.row];
        cell.rightTitle = self.mightDataArray[indexPath.row];
        // pickView的数据源
        if (indexPath.row == 1) {
            cell.pickDataArray = self.pickDataArray;
            cell.isExist = NO;
        }
        cell.textFiledTag = indexPath.row + 1000;
        
        
        return cell;
        
    }
    if (indexPath.section == 2) {
        static NSString *cellID = @"cellID";
        TextMainApprovalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[TextMainApprovalDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.leftTitle = self.bottomArray[indexPath.row];
        cell.rightTitle = self.bottomDataArray[indexPath.row];
        return cell;
        
    }
    
    
    
    return nil;
    
    
}
#pragma  mark ----- Lazy 加载
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 50) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}
- (MMBottomButton *)bottomButton{
    if (_bottomButton == nil) {
        _bottomButton = [[MMBottomButton alloc] initWithFrame:CGRectMake(0, self.view.height - 64 - 50, self.view.width, 50)];
    }
    return _bottomButton;
}

- (UIView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.height, kHeaderH)];
        _headerView.backgroundColor = [UIColor clearColor];
        MMLeaveTitleView *leaverView = [[MMLeaveTitleView alloc] initWithFrame:CGRectMake(0, 10, self.view.width, 40)];
        leaverView.backgroundColor = [UIColor whiteColor];
        leaverView.rightStr = @"年假";
        [_headerView addSubview:leaverView];
        
        for (int i=0; i < 2; i++) {
            MMTitleLabel *titleLabel = [[MMTitleLabel alloc] init];
            titleLabel.frame = CGRectMake(i * (kTitleLableW + 1), CGRectGetMaxY(leaverView.frame) + 1, kTitleLableW, kTitleLableH);
            titleLabel.topStr = self.headerTopArray[i];
            titleLabel.bottomStr = self.headerBottomArray[i];
            titleLabel.backgroundColor = [UIColor whiteColor];
            [_headerView addSubview:titleLabel];
            
        }
    }
    return _headerView;
}

@end