//
//  MM_MainViewController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/7/27.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMMainController.h"
#import "MMMianCell.h"

@interface MMMainController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) NSArray *dataArray;



@end

@implementation MMMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray  = @[@"个人信息",@"签到签退",@"考勤记录",@"休假申请",@"休假记录",@"休假审批",@"加班申请",@"加班记录",@"加班审批",@"通讯录",@"迟到排行",@"加班排行",@"薪酬列表",@"HRS数据录入",@"HRS数据勘查"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    
    UIView *headerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 80)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    
    [self.view addSubview:self.tableView];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"self.dataArray.count = %lu",self.dataArray.count);
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *mainCellID = @"mainCellID";
    
    MMMianCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellID];
    
    if (!cell) {
        cell = [[MMMianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainCellID];
    }
    
    cell.messageStr = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.row == 0) {
        // 个人信息
        
    }
    if (indexPath.row == 1) {
        // 签到签退
        
    }
    if (indexPath.row == 2) {
        // 考勤记录
        
    }
    if (indexPath.row == 3) {
        // 休假申请
        
    }
    if (indexPath.row == 4) {
        // 休假记录
        
    }
    if (indexPath.row == 5) {
        // 休假审批
        
    }
    if (indexPath.row == 6) {
        // 加班申请
        
    }
    if (indexPath.row == 7) {
        // 加班记录
        
    }
    if (indexPath.row == 8) {
        // 加班审批
        
    }
    if (indexPath.row == 9) {
        // 通讯录
        
    }
    if (indexPath.row == 10) {
        //  迟到排行
        
    }
    
    if (indexPath.row == 11) {
        // 加班排行
        
    }
    if (indexPath.row == 12) {
        //  薪酬列表
        
    }
    if (indexPath.row == 13) {
        // HRS数据录入
        
    }if (indexPath.row == 14) {
        //  HRS数据勘查
                
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;

        
    }
    return _tableView;
}
@end
