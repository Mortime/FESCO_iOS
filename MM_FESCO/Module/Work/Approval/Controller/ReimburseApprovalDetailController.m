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
#import "ReimburseApprovalRecordCell.h"

#import "TextMainApprovalDetailCell.h"
#import "FileMainApprovalDetailCell.h"
#import "ReimburseApprovalRecordDetailController.h"
@interface ReimburseApprovalDetailController ()<UITableViewDelegate,UITableViewDataSource,fileMainApprovalDetailCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *messageTitleArray;

@property (nonatomic, strong) NSMutableArray *messageContentArray;

@property (nonatomic, strong) NSMutableArray *reimburseInfoArray;

@property (nonatomic, strong) NSMutableArray *reimburselistArray;

@property (nonatomic, strong) MMBottomButton *bottomButton;


@property (nonatomic, strong) NSArray *mightArray;
@property (nonatomic, strong) NSArray *mightDataArray;

@property (nonatomic, strong) NSArray *bottomArray;
@property (nonatomic, strong) NSMutableArray *bottomDataArray;

@property (nonatomic, strong) NSMutableArray *pickDataArray;

@property (nonatomic, assign) BOOL isShowLaterMessage;

@property (nonatomic, assign) BOOL isNOShowAppMan;

@property (nonatomic, strong) NSString *applyIdea;

@property (nonatomic, strong) NSString *applyPeopel;

@property (nonatomic, strong) NSArray *resultArray;


@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *manID;

@end

@implementation ReimburseApprovalDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"报销审批";
    self.messageTitleArray = @[@"报销日期",@"收款账号"];
    
    self.mightArray = @[@"审批意见",@"再次审批"];
    self.mightDataArray = @[@"请输入审批意见",@"请选择再次审批人"];
    
    self.bottomArray = @[@"前次审批",@"审批结果",@"审批意见"];
    self.bottomDataArray = [NSMutableArray array];
    
    self.pickDataArray = [NSMutableArray array];
    
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
            
            
            
            
            // 前次审批
            NSArray *allKey = [responseObject allKeys];
            for (NSString *keyStr in allKey) {
                if ([keyStr isEqualToString:@"lastApprovalStep"]) {
                    _isShowLaterMessage = YES;
                    NSDictionary *dic = [responseObject objectForKey:keyStr];
                    if ([dic objectForKey:@"is_Other_Party"] && ![[dic objectForKey:@"is_Other_Party"] isKindOfClass:[NSNull class]]) {
                        
                        if ([[dic objectForKey:@"is_Other_Party"] integerValue] == 0 ||[[dic objectForKey:@"is_Other_Party"] integerValue]== 1) {
                            _isNOShowAppMan = YES;
                        }
                    }
                    
                    
                    
                    MMLog(@"lastApprovalStep == %@",dic);
                    
                    /*
                     lastApprovalStep =     {
                     "apply_Id" = 183;
                     "approval_Man" = 163;
                     "approval_Man_Str" = "\U80e1\U677e";
                     "approval_Time" = "<null>";
                     "is_Over" = 0;
                     "is_Pass" = 2;
                     "is_Pass_Str" = "\U901a\U8fc7\U5ba1\U6279";
                     memo = "<null>";
                     "next_Approval_Man" = "<null>";
                     "step_Id" = 103;
                     };

                     */
                     NSString *lastDate = @"暂无";
                    if ([dic objectForKey:@"approval_Man_Str"] != nil && ![[dic objectForKey:@"approval_Man_Str"] isKindOfClass:[NSNull class]]) {
                        lastDate = [dic objectForKey:@"approval_Man_Str"];
                        if ([dic objectForKey:@"approval_Time"] != nil && ![[dic objectForKey:@"approval_Time"] isKindOfClass:[NSNull class]]) {
                            lastDate = [NSString stringWithFormat:@"%@ 于 %@",[dic objectForKey:@"approval_Man_Str"],[NSDate dateFromSSWithss:[NSString stringWithFormat:@"%@",[dic objectForKey:@"approval_Time"]]]];
                        }
                        
                    }
                   
                    [_bottomDataArray addObject:lastDate];
                    // 审批状态
                    [_bottomDataArray addObject:[dic objectForKey:@"is_Pass_Str"]];
                    
                    
                    NSString *lastMemo = [dic objectForKey:@"memo"];
                    if (lastMemo == nil  || [lastMemo isKindOfClass:[NSNull class]]) {
                        lastMemo = @"暂无";
                    }
                    [_bottomDataArray addObject:lastMemo];
                    
                    
                }
            }

            // 审批人选择
            NSArray  *applyPeople = [responseObject objectForKey:@"approvalManList"];
            _resultArray =  applyPeople;
            for (NSDictionary *dic in applyPeople) {
                NSString *str = [dic objectForKey:@"emp_Name"];
                [_pickDataArray addObject:str];
            }
            
            [_tableView reloadData];
            
        }
        
    } failure:^(NSError *failure) {
        MMLog(@"ReimburseApprovalInfo ========= failure ============%@",failure);
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1 || section == 3) {
        return 10;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    // 一区头部视图
    if (section == 0) {
        UIView *sectionTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
        sectionTwo.backgroundColor = [UIColor clearColor];
    
        return sectionTwo;
    }
    // 二区头部视图
    if (section == 1) {
        UIView *sectionThree = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
        sectionThree.backgroundColor = [UIColor clearColor];
    
        return sectionThree;
    }
    // 二区头部视图
    if (section == 3) {
        UIView *sectionThree = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
        sectionThree.backgroundColor = [UIColor clearColor];
        
        return sectionThree;
    }

    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isShowLaterMessage) {
        return 4;
    }
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1){
        return 2;
    }
    if (section == 0) {
        ReimburseApprovalInfoModel *model = _reimburseInfoArray.firstObject;
        
        return model.details.count;
    }
    if (section == 2){
                   return 2;
        
    }
    if (section == 3){
        return 3;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
    if (indexPath.section == 0) {
        static NSString *cellID = @"ID";
        ReimburseApprovalRecordCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[ReimburseApprovalRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        ReimburseApprovalInfoModel *model = _reimburseInfoArray.firstObject;
        cell.dic = model.details[indexPath.row];
        return cell;
    }
    
    if (indexPath.section == 2) {
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
            if (_isNOShowAppMan) {
                cell.rightTextFiled.rightTextFiled.userInteractionEnabled = NO;
            }
        }
        cell.textFiledTag = indexPath.row + 1000;
        cell.delegate = self;
        
        
        return cell;
        
    }
    if (indexPath.section == 3) {
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        ReimburseApprovalRecordDetailController *detailVc = [[ReimburseApprovalRecordDetailController alloc] init];
        
        ReimburseApprovalInfoModel *model = _reimburseInfoArray.firstObject;
        NSDictionary *dic = model.details[indexPath.row];
        /*
         "apply_Id" = 108;
         "bill_Num" = 1;
         "cust_Id" = "<null>";
         "detail_Id" = 136;
         "detail_Id_Before_Imported" = "<null>";
         "detail_Memo" = VV;
         "emp_Id" = "<null>";
         "expense_Date" = "<null>";
         icon = "fa fa-car fa-lg";
         "money_Amount" = 55;
         "pic_Ids" = "<null>";
         pics =     (
         {
         "detail_Id" = 136;
         id = 138;
         "pic_Desc" = "<null>";
         "pic_Url" = "F://expensePics/15/15/20161222172610IMG_0003.JPG";
         }
         );
         "spend_Begin" = 1482336000000;
         "spend_Begin_Str" = "<null>";
         "spend_City" = "<null>";
         "spend_End" = "<null>";
         "spend_End_Str" = "<null>";
         "spend_Type" = 18;
         "spend_Type_Str" = "\U4ea4\U901a-\U516c\U4ea4";
         trId = "<null>";
         
         */
        if ([[dic objectForKey:@"spendEnd"] isKindOfClass:[NSNull class]] || ![dic objectForKey:@"spendEnd"]) {
            // 日期类型
            // 不显示结束日期
            detailVc.dateType =  1;
        }else{
            // 显示结束日期
            detailVc.dateType =  2;
            detailVc.endTime = [dic objectForKey:@"spendEnd"];
        }
        if ([[dic objectForKey:@"spendCity"] isKindOfClass:[NSNull class]] || ![dic objectForKey:@"spendCity"]) {
            // 城市名称
            // 不显示x
            detailVc.needCity = 0;
        }else{
            // 显示
            detailVc.needCity = 1;
        }
        detailVc.icon = [dic objectForKey:@"icon"];
        detailVc.title = [dic objectForKey:@"spend_Type_Str"];
        detailVc.dic = dic;
        [self.navigationController pushViewController:detailVc animated:YES];
 
    }
    
}
#pragma mark ---  fileMainApprovalDetailCellDelegate 方法
- (void)fileMainApprovalDetailCellDelegateWithTextFile:(UITextField *)textfile indexTag:(NSInteger)indexTag{
    
    if (indexTag == 1000) {
        // 审批意见
        MMLog(@"审批意见");
        _applyIdea = textfile.text;
    }
    if (indexTag == 1001) {
        // 审批人
        MMLog(@"审批人");
        _applyPeopel = textfile.text;
    }
    
}

#pragma mark ---- 底部按钮点击回调
- (void)didClick:(NSInteger)sender{
    _type = @"";
    
    // 审批意见
    NSString *applyIdea = @"";
    if (_applyIdea) {
        applyIdea = _applyIdea;
    }
    
    // 审批人
    _manID = @"";
    if (_applyPeopel) {
        for (NSDictionary *dic in _resultArray) {
            if ([[dic objectForKey:@"emp_Name"] isEqualToString:_applyPeopel]) {
                _manID = [dic objectForKey:@"emp_Id"];
            }
        }
    }


    NSInteger tagFlag = 0;
    
    NSString *msgSuccess = @"";
    NSString *msgError = @"";
    
    if (sender == 10010) {
        // 同意
        tagFlag =  1;
        msgSuccess = @"审批成功";
        msgError = @"审批失败";
        
        // 选择了审批人
        if (_applyPeopel && ![_applyPeopel isEqualToString:@" "] && ![_applyPeopel isEqualToString:@""] ) {

                // 同意
                tagFlag =  1;
                msgSuccess = @"审批成功";
                msgError = @"审批失败";
            
                [NetworkEntity postCommitReimburseApprovalWithApplyId:_applyId result:tagFlag memo:applyIdea nextApprovalMan:_manID type:_type Success:^(id responseObject) {
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
            
        }else{
            // 没有选择审批人
            [NetworkEntity postCommitReimburseApprovalBeforeSuccess:^(id responseObject) {
                
                MMLog(@"CommitReimburseApprovalBefore ========= responseObject ============%@",responseObject);
                
                /*
                 
                 checkMan =     {
                 "cust_Id" = 29;
                 id = 22;
                 title = "\U7b2c\U4e09\U65b9";
                 type = 2;
                 "type_Id" = 61;
                 "type_Name" = "\U62a5\U9500\U5ba1\U5355";
                 };
                 errcode = 0;
                 message = success;
                 */
                
                if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
                    // 请求成功
                    NSDictionary *dic = [responseObject objectForKey:@"checkMan"];
                    if ([dic allKeys].count) {
                        
                        if ([[dic objectForKey:@"type_Id"] integerValue] == 0) {
                            _manID =@"";
                            _type = @"";
                        }else{
                            _manID =  [NSString stringWithFormat:@"%lu",[[dic objectForKey:@"type_Id"] integerValue]];
                            _type = [NSString stringWithFormat:@"%lu",[[dic objectForKey:@"type"] integerValue]];

                        }
}
                    
                    [NetworkEntity postCommitReimburseApprovalWithApplyId:_applyId result:tagFlag memo:applyIdea nextApprovalMan:_manID type:_type Success:^(id responseObject) {
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
                
            } failure:^(NSError *failure) {
                
                MMLog(@"CommitReimburseApprovalBefore ========= responseObject ============%@",failure);
            }];
            
        }

        

    }
    

    
    
    
    if (sender == 10011) {
        // 驳回
        tagFlag = 0;
        msgSuccess = @"驳回成功";
        msgError = @"驳回失败";

        
        [NetworkEntity postCommitReimburseApprovalWithApplyId:_applyId result:0 memo:applyIdea nextApprovalMan:@"" type:@"" Success:^(id responseObject) {
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
    
    
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , self.view.width, self.view.height - 50 - 64) style:UITableViewStylePlain];
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

