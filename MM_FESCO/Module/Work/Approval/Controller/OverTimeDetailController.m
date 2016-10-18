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
#import "MMBottomButton.h"

@interface OverTimeDetailController ()<UITableViewDataSource,UITableViewDelegate,fileMainApprovalDetailCellDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) NSArray *topArray;

@property (nonatomic, strong) NSArray *bottomArray;

@property (nonatomic, strong) NSArray *mightArray;


@property (nonatomic, strong) NSArray *topDataArray;

@property (nonatomic, strong) NSMutableArray *bottomDataArray;

@property (nonatomic, strong) NSArray *mightDataArray;

@property (nonatomic, strong) NSMutableArray *pickDataArray;

@property (nonatomic, strong) MMBottomButton *bottomButton;

@property (nonatomic, strong) NSArray *resultArray;

@property (nonatomic, strong) NSString *applyIdea;

@property (nonatomic, strong) NSString *applyPeopel;

@property (nonatomic, assign) BOOL isShowLaterMessage;


@end

@implementation OverTimeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加班审批";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomButton];
    self.topArray = @[@"开始时间",@"截止时间",@"加班原因"];
    
    
    self.mightArray = @[@"审批意见",@"再次审批"];
    self.mightDataArray = @[@"请输入审批意见",@"请选择再次审批人"];
    
    self.bottomArray = @[@"前次审批",@"审批结果",@"审批意见"];
    self.bottomDataArray = [NSMutableArray array];
    
    self.pickDataArray = [NSMutableArray array];
    [self initData];
}
- (void)initData{
    [NetworkEntity postOverTimeApproalMessageWithApply:_overTimeModel.applyid Success:^(id responseObject) {
        
//                 MMLog(@"OverTimeMessage ====== responseObject====%@",responseObject);
        NSArray *allKey = [responseObject allKeys];
        for (NSString *keyStr in allKey) {
            if ([keyStr isEqualToString:@"lastApprovalStep"]) {
                _isShowLaterMessage = YES;
                NSDictionary *dic = [responseObject objectForKey:keyStr];
                
                MMLog(@"lastApprovalStep == %@",dic);
                
                
                
                NSString *lastDate = [NSDate dateFromSSWithss:[NSString stringWithFormat:@"%@",[dic objectForKey:@"approval_Time"]]];
                [_bottomDataArray addObject:lastDate];
                NSString *lastRelutt = @"";
                NSInteger result = [[dic objectForKey:@"is_Pass"] integerValue];
                if (result == 0) {
                    lastRelutt = @"不通过";
                }
                if (result == 1) {
                    lastRelutt = @"通过";
                }
                
                [_bottomDataArray addObject:lastRelutt];
                
                
                NSString *lastMemo = [dic objectForKey:@"memo"];
                if (lastMemo == nil  || [lastMemo isKindOfClass:[NSNull class]]) {
                    lastMemo = @"暂无";
                }
                [_bottomDataArray addObject:lastMemo];
                
                
            }
        }
        if (!_isShowLaterMessage) {
            _isShowLaterMessage = NO;
        }
        
        NSDictionary *applyMessage = [responseObject objectForKey:@"extraWorkApply"];
        // 基本信息展示
        NSString *beginTime = [NSDate dateFromSSWithss:[applyMessage objectForKey:@"begin_Time"]];
        NSString *endTime = [NSDate dateFromSSWithss:[applyMessage objectForKey:@"end_Time"]];
        NSString *reason = [applyMessage objectForKey:@"reason"];
        self.topDataArray = @[beginTime,endTime,reason];
        
        // 审批人选择
        NSArray  *applyPeople = [responseObject objectForKey:@"availableApprovalManList"];
        _resultArray =  applyPeople;
        for (NSDictionary *dic in applyPeople) {
            NSString *str = [dic objectForKey:@"emp_Name"];
            [_pickDataArray addObject:str];
        }
        
        [_tableView reloadData];
        
        
        
    } failure:^(NSError *failure) {
        MMLog(@"OverTimeMessage ====== failure====%@",failure);
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isShowLaterMessage) {
        return 3;
    }else{
        return 2;
    }
    
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
        cell.delegate = self;
        
    
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
    
    
    // 审批意见
    NSString *applyIdea = @"";
    if (_applyIdea) {
        applyIdea = _applyIdea;
    }
    
    // 审批人
    NSString *applyPeople = @"";
    if (_applyPeopel) {
        for (NSDictionary *dic in _resultArray) {
            if ([[dic objectForKey:@"emp_Name"] isEqualToString:_applyPeopel]) {
                applyPeople = [dic objectForKey:@"emp_Id"];
            }
        }
    }
    
    // 同意或者驳回
    NSInteger isPass = 2;
    NSString *msgSuccess = @"";
    NSString *msgError = @"";
    
    if (sender == 10010) {
        // 同意
        isPass = 1;
        msgSuccess = @"审批成功";
        msgError = @"审批失败";
    }
    if (sender == 10011) {
        // 驳回
        isPass = 0;
        msgSuccess = @"驳回成功";
        msgError = @"驳回失败";
    }
    
    [NetworkEntity postCommitOverTimeWithApply:_overTimeModel.applyid isPass:isPass nextApprovalManId:applyPeople memo:applyIdea Success:^(id responseObject) {
        MMLog(@"CommitOverTime ========= responseObject ============%@",responseObject);
        
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"success"]) {
            
            [self showTotasViewWithMes:msgSuccess];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if ([[responseObject objectForKey:@"message"] isEqualToString:@"error"]){
            
            [self showTotasViewWithMes:msgError];
        }


    } failure:^(NSError *failure) {
        MMLog(@"CommitOverTime ========= failure ============%@",failure);
        [self showTotasViewWithMes:@"网络错误"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [_bottomButton mm_setBottomButtonDelegateBlock:^(NSInteger indexTag) {
            [self didClick:indexTag];
        }];
    }
    return _bottomButton;
}
@end
