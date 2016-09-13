//
//  OverTimeDetailController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "OverTimeDetailController.h"
#import "TextMainApprovalDetailCell.h"
#import "FileMainApprovalDetailCell.h"

@interface OverTimeDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) NSArray *topArray;

@property (nonatomic, strong) NSArray *bottomArray;

@property (nonatomic, strong) NSArray *mightArray;


@property (nonatomic, strong) NSArray *topDataArray;

@property (nonatomic, strong) NSArray *bottomDataArray;

@property (nonatomic, strong) NSArray *mightDataArray;



@end

@implementation OverTimeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加班审批";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    [self.view addSubview:self.tableView];
    self.topArray = @[@"开始时间",@"截止时间",@"加班原因"];
    self.topDataArray = @[@"2016年8月29",@"2016年8月90日",@"证书配置"];
    
    self.bottomArray = @[@"前次审批",@"审批结果",@"审批意见"];
    self.bottomDataArray = @[@"2016年8月29",@"2016年8月90日",@"dlllll"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (0 == section) {
        return 3;
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
//        cell.index = indexPath.row;
//        cell.detailFiled.tag = 100 + indexPath.row;
//        cell.personalMessageModel = self.personalMessageModel;
        return cell;

    }
    if (indexPath.section == 1) {
        static NSString *cellID = @"cellID";
        FileMainApprovalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[FileMainApprovalDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
//        cell.leftTitle = self.topArray[indexPath.row];
//        cell.rightTitle = self.topDataArray[indexPath.row];
        //        cell.index = indexPath.row;
        //        cell.detailFiled.tag = 100 + indexPath.row;
        //        cell.personalMessageModel = self.personalMessageModel;
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
        //        cell.index = indexPath.row;
        //        cell.detailFiled.tag = 100 + indexPath.row;
        //        cell.personalMessageModel = self.personalMessageModel;
        return cell;
        
    }

    
    
    return nil;
    
    
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark ----- Lazy 加载
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}

@end
