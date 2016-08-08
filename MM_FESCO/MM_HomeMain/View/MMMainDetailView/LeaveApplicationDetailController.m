//
//  LeaveApplicationDetailController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/3.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveApplicationDetailController.h"
#import "LeaveApplicationDetailCell.h"

#define kBottomButtonW       (((kMMWidth) - 20 - 20 ))

@interface LeaveApplicationDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UIButton *submitButton;




@end

@implementation LeaveApplicationDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"休假申请";
    self.dataArray  = @[@"假期类型",@"时间单位",@"开始时间",@"截止时间",@"休假原因",@"审批人"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建头部视图
    UIView *headerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
     headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *headerLaber = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 16)];
    headerLaber.centerX = self.view.centerX;
    headerLaber.textAlignment = NSTextAlignmentCenter;
    headerLaber.text = @"休假申请";
    headerLaber.textColor = RGB_Color(65, 50, 87);
    headerLaber.font = [UIFont systemFontOfSize:16];
    
    UIView *lineHeader = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(headerView.frame) - 1, self.view.width, 1)];
    lineHeader.backgroundColor = RGB_Color(230, 229, 231);
    
    [headerView addSubview:headerLaber];
    [headerView addSubview:lineHeader];

    
    
    // 创建尾部视图
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 25)];
    footView.backgroundColor = [UIColor clearColor];
    
    UIView *lineFootView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(footView.frame) + 1, self.view.width, 1)];
    lineFootView.backgroundColor = RGB_Color(230, 229, 231);
    [footView addSubview:lineFootView];
    
    

    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = footView;
    [self.view addSubview:self.submitButton];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *mainCellID = @"messageCellID";
    
    LeaveApplicationDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellID];
    
    if (!cell) {
        cell = [[LeaveApplicationDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainCellID];
    }
    
    cell.titleStr = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark --- Action Targaet
// 提交申请
- (void)didSubmit:(UIButton *)btn{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma  mark ----- Lazy 加载
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}


- (UIButton *)submitButton{
    if (_submitButton == nil) { 
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.frame = CGRectMake(20, self.view.height - 10 - 40, kBottomButtonW, 40);
        [_submitButton setTitle:@"提交申请" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(didSubmit:) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton setBackgroundColor:RGB_Color(65, 50, 87)];
        
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.cornerRadius = 5 ;
    }
    return _submitButton;
}





@end
