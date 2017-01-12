//
//  ProgressReimburseController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/29.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ProgressReimburseController.h"
#import "ProgressStatusCell.h"
#import "ProgressMessageCell.h"
#import "ProgressPuschaseCell.h"
#import "NewPurchaseRecordModel.h"

@interface ProgressReimburseController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *messageTitleArray;

@property (nonatomic, strong) NSArray *messageContentArray;

@property (nonatomic, strong) NSMutableArray *reimburselistArray;

@end

@implementation ProgressReimburseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"审批进度";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.reimburselistArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self initData];
    
}
- (void)initData{
    self.messageTitleArray = @[@"报销日期",@"收款账号"];
    NSString *time = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:_model.applyDate];
    NSString *bankNumber = [NSString stringWithFormat:@"%lu",_model.accountId];
    self.messageContentArray = @[time,bankNumber];
    for (NSDictionary *dic in _model.details) {
        NewPurchaseRecordModel *model = [NewPurchaseRecordModel yy_modelWithDictionary:dic];
        [_reimburselistArray addObject:model];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
       return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //  一区头部视图
    if (section == 0) {
        UIView *sectionOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
        sectionOne.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0,self.view.width , 30)];
        label.centerY = sectionOne.centerY;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor grayColor];
        label.text = @"审批进度";
        
        [sectionOne addSubview:label];
        return sectionOne;
    }
    // 二区头部视图
    if (section == 1) {
        UIView *sectionTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
        sectionTwo.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0,self.view.width , 30)];
        label.centerY = sectionTwo.centerY;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor grayColor];
        label.text = @"基本信息";
        
        [sectionTwo addSubview:label];
        return sectionTwo;
    }
    // 三区头部视图
    if (section == 2) {
        UIView *sectionThree = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
        sectionThree.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0,100 ,20)];
        label.centerY = sectionThree.centerY + 5;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor grayColor];
        label.text = @"消费明细";
        [sectionThree addSubview:label];
    
        return sectionThree;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1 ;
    }else if (section == 1){
        return 2;
    }else{
        return _model.details.count;
    }
       }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44;
    }
    if (indexPath.section == 1) {
        return 30;
    }
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *cellID = @"ProgressID";
        ProgressStatusCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[ProgressStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.statusTag = _model.statusReimburse;
        return cell;
    }
    
    
    if (indexPath.section == 1) {
        static NSString *cellID = @"MessageID";
        ProgressMessageCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[ProgressMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.titleStr = _messageTitleArray[indexPath.row];
        cell.contentStr = _messageContentArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 2) {
        static NSString *cellID = @"ID";
        ProgressPuschaseCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[ProgressPuschaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.model = _reimburselistArray[indexPath.row];
        return cell;
    }

    
    return nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , self.view.width, self.view.height - 50) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}


@end
