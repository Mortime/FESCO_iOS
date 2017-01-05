//
//  ReimburseApprovalDetailController.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/5.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "ReimburseApprovalDetailController.h"
#import "MMBottomButton.h"
#import "ProgressStatusCell.h"
#import "ProgressMessageCell.h"
#import "ProgressPuschaseCell.h"
#import "NewPurchaseRecordModel.h"
#import "ReimburseApprovalInfoModel.h"

@interface ReimburseApprovalDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *messageTitleArray;

@property (nonatomic, strong) NSMutableArray *messageContentArray;

@property (nonatomic, strong) NSMutableArray *reimburseInfoArray;

@property (nonatomic, strong) NSMutableArray *reimburselistArray;

@property (nonatomic, strong) MMBottomButton *bottomButton;

@end

@implementation ReimburseApprovalDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"审批进度";
    self.messageTitleArray = @[@"报销日期",@"收款账号"];
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.reimburseInfoArray = [NSMutableArray array];
    self.reimburselistArray = [NSMutableArray array];
    self.messageContentArray = [NSMutableArray arrayWithObjects:@" ",@" ", nil];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomButton];
    [self initData];
    
}
- (void)initData{
    
    [NetworkEntity postReimburseApprovalInfoWithApplyId:_applyId Success:^(id responseObject) {
        
        MMLog(@"ReimburseApprovalInfo ========= responseObject ============%@",responseObject);
        if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
            // 请求成功
            NSDictionary *dic = [responseObject objectForKey:@"apply"];
                ReimburseApprovalInfoModel *model = [ReimburseApprovalInfoModel yy_modelWithDictionary:dic];
                [_reimburseInfoArray addObject:model];
            [_messageContentArray replaceObjectAtIndex:0 withObject:[NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:model.applyDate]];
            [_messageContentArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%lu",model.accountId]];
            [_tableView reloadData];
            
        }
        
    } failure:^(NSError *failure) {
        MMLog(@"ReimburseApprovalInfo ========= failure ============%@",failure);
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    // 一区头部视图
    if (section == 0) {
        UIView *sectionTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
        sectionTwo.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0,self.view.width , 20)];
        label.centerY = sectionTwo.centerY;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor grayColor];
        label.text = @"基本信息";
        
        [sectionTwo addSubview:label];
        return sectionTwo;
    }
    // 三区头部视图
    if (section == 1) {
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return 2;
    }
    ReimburseApprovalInfoModel *model = _reimburseInfoArray.firstObject;
    
    return model.details.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44;
    }
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        static NSString *cellID = @"MessageID";
        ProgressMessageCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[ProgressMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.titleStr = _messageTitleArray[indexPath.row];
        cell.contentStr = _messageContentArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *cellID = @"ID";
        ProgressPuschaseCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[ProgressPuschaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        ReimburseApprovalInfoModel *model = _reimburseInfoArray.firstObject;
        cell.dic = model.details[indexPath.row];
        return cell;
    }
    
    
    return nil;
    
}
#pragma mark ---- 底部按钮点击回调
- (void)didClick:(NSInteger)sender{

    NSInteger tagFlag = 0;
    
    NSString *msgSuccess = @"";
    NSString *msgError = @"";
    
    if (sender == 10010) {
        // 同意
        tagFlag =  1;
        msgSuccess = @"审批成功";
        msgError = @"审批失败";
       
    }
    if (sender == 10011) {
        // 驳回
        tagFlag = 0;
        msgSuccess = @"驳回成功";
        msgError = @"驳回失败";

    }
    [NetworkEntity postCommitReimburseApprovalWithApplyId:_applyId result:tagFlag Success:^(id responseObject) {
        MMLog(@"CommitReimburseApproval ========= responseObject ============%@",responseObject);
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"success"]) {
            
            [self showTotasViewWithMes:msgSuccess];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if ([[responseObject objectForKey:@"message"] isEqualToString:@"error"]){
            
            [self showTotasViewWithMes:msgError];
        }

    } failure:^(NSError *failure) {
        MMLog(@"CommitReimburseApproval ========= responseObject ============%@",failure);
        [self showTotasViewWithMes:@"网络错误"];
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
- (MMBottomButton *)bottomButton{
    if (_bottomButton == nil) {
        _bottomButton = [[MMBottomButton alloc] initWithFrame:CGRectMake(0, self.view.height - 64 - 50, self.view.width, 50)];
        [_bottomButton mm_setBottomButtonDelegateBlock:^(NSInteger indexTag) {
            [self didClick:indexTag];
        }];
        
    }
    return _bottomButton;
}


@end

