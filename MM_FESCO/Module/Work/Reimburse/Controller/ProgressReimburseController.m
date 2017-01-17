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
#import "ProgressReimburseModel.h"


@interface ProgressReimburseController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *messageTitleArray;

@property (nonatomic, strong) NSArray *messageContentArray;

@property (nonatomic, strong) NSMutableArray *reimburselistArray;

@property (nonatomic, strong) NSDictionary *lastTepDic;

@property (nonatomic, strong) UIButton *editButton;

@end

@implementation ProgressReimburseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"审批进度";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.reimburselistArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.editButton];
    [self initData];
    
}
- (void)initData{
    
    self.messageTitleArray = @[@"报销日期",@"收款账号"];
    
    [NetworkEntity postReimburseApprovalInfoWithForEmpApplyId:_model.applyId Success:^(id responseObject) {
        MMLog(@"ReimburseApprovalInfoWithForEmp  =======responseObject=====%@",responseObject);
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"success"]) {
            /*
             
             lastApprovalStep =     {
             "apply_Id" = 285;
             approvalTime = "<null>";
             "approval_Man" = 163;
             "approval_Man_Str" = "\U80e1\U677e";
             "approval_Time" = 1484546923000;
             "is_Other_Party" = "<null>";
             "is_Over" = 1;
             "is_Pass" = 1;
             "is_Pass_Str" = "\U901a\U8fc7\U5ba1\U6279";
             memo = "<null>";
             "next_Approval_Man" = 4399;
             "step_Id" = 223;
             };

             */
            
            _lastTepDic  = [responseObject objectForKey:@"lastApprovalStep"];
            
            
            
            NSDictionary *dic = [responseObject objectForKey:@"apply"];
            NSString *time = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:[dic objectForKey:@"apply_Date"]];
            NSString *bankNumber = [NSString stringWithFormat:@"%lu",[[dic objectForKey:@"account_Id"] integerValue]];
            self.messageContentArray = @[time,bankNumber];
            NSArray *array = [dic objectForKey:@"details"];
            for (NSDictionary *dic in array) {
                ProgressReimburseModel *model = [ProgressReimburseModel yy_modelWithDictionary:dic];
                [_reimburselistArray addObject:model];
            }
            [self.tableView reloadData];
        }

    } failure:^(NSError *failure) {
        MMLog(@"ReimburseApprovalInfoWithForEmp  =======failure=====%@",failure);
        
    }];
    
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
        return _reimburselistArray.count;
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
        cell.appleMan = [_lastTepDic objectForKey:@"approval_Man_Str"];
        cell.statusTag = _model.statusReimburse;
        cell.memo = [_lastTepDic objectForKey:@"memo"];
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
        cell.progressModel = _reimburselistArray[indexPath.row];
        return cell;
    }

    
    return nil;
    
}
- (void)didClick:(UIButton *)sender{
    [NetworkEntity postEditReimburseOfNOBassWithApplyID:_model.applyId Success:^(id responseObject) {
        
        MMLog(@"EditReimburseOfNOBass  =======responseObject=====%@",responseObject);
    } failure:^(NSError *failure) {
        MMLog(@"EditReimburseOfNOBass  =======failure=====%@",failure);
    }];
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
- (UIButton *)editButton{
    if (_editButton == nil) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame = CGRectMake(0, self.view.height - 64 - 50, self.view.width, 50);
        [_editButton setTitle:@"重新编辑" forState:UIControlStateNormal];
        [_editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        [_editButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        _editButton.tag = 10011;
        
    }
    return _editButton;
}
@end
