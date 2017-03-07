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

@interface LeaveApprovalDetailController ()<UITableViewDataSource,UITableViewDelegate,fileMainApprovalDetailCellDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) NSArray *topArray;

@property (nonatomic, strong) NSArray *bottomArray;

@property (nonatomic, strong) NSArray *mightArray;


@property (nonatomic, strong) NSArray *topDataArray;

@property (nonatomic, strong) NSMutableArray *bottomDataArray;

@property (nonatomic, strong) NSArray *mightDataArray;

@property (nonatomic, strong) NSMutableArray *pickDataArray;


@property (nonatomic, strong) MMBottomButton *bottomButton;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) NSArray *headerTopArray;

@property (nonatomic, strong) NSArray *headerBottomArray;


@property (nonatomic, strong) NSArray *resultArray;

@property (nonatomic, strong) NSString *applyIdea;

@property (nonatomic, strong) NSString *applyPeopel;

@property (nonatomic, assign) BOOL isShowLaterMessage; // 是否显示前次审批信息


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
    
    self.mightArray = @[@"审批意见",@"再次审批"];
    self.mightDataArray = @[@"请输入审批意见",@"请选择再次审批人"];
    
    self.bottomArray = @[@"前次审批",@"审批结果",@"审批意见"];
    self.bottomDataArray = [NSMutableArray array];
    
    self.pickDataArray = [NSMutableArray array];
    
    self.headerTopArray = @[@"开始时间",@"截止时间"];
    
     [self initData];
    
}
- (void)initData{
    
    [NetworkEntity postLeaveApproalMessageWithApply:_listModel.applyId Success:^(id responseObject) {
        MMLog(@"LeaveApproalMessage ====== responseObject====%@",responseObject);
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

        
        
        
        NSDictionary *applyMessage = [responseObject objectForKey:@"holEmpExam"];
        // 基本信息展示
        NSString *beginTime = @"暂无";
        NSString *endTime = @"暂无";
        NSString *reason = @"暂无";
        if (![[applyMessage objectForKey:@"hol_Begin"] isEqual:[NSNull null]]) {
        beginTime = [NSDate dateFromSSWithss:[applyMessage objectForKey:@"hol_Begin"]];
        }
        if (![[applyMessage objectForKey:@"hol_End"] isEqual:[NSNull null]]) {
            endTime = [NSDate dateFromSSWithss:[applyMessage objectForKey:@"hol_End"]];
        }
        if (![[applyMessage objectForKey:@"momo"] isEqual:[NSNull null]]) {
            reason = [applyMessage objectForKey:@"momo"];
        }

        self.headerBottomArray = @[beginTime,endTime];
        self.topDataArray = @[reason];
        
        // 审批人选择
        NSArray  *applyPeople = [responseObject objectForKey:@"availableApprovalManList"];
        _resultArray =  applyPeople;
        for (NSDictionary *dic in applyPeople) {
            NSString *str = [dic objectForKey:@"emp_Name"];
            [_pickDataArray addObject:str];
        }
        
        // 网络请求成功后添加头部视图
        self.tableView.tableHeaderView = self.headerView;
        
        [_tableView reloadData];

    } failure:^(NSError *failure) {
         MMLog(@"LeaveApproalMessage ====== failure====%@",failure);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    
    
    
    return [UITableViewCell new];
    
    
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
    
    
    
    [NetworkEntity postCommitLeaveApproalWithApply:_listModel.applyId isPass:isPass nextApprovalManId:applyPeople memo:applyIdea Success:^(id responseObject) {
        MMLog(@"CommitLeaveApproal ========= responseObject ============%@",responseObject);
        
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"success"]) {
            
            [self showTotasViewWithMes:msgSuccess];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if ([[responseObject objectForKey:@"message"] isEqualToString:@"error"]){
            
            [self showTotasViewWithMes:msgError];
        }
        
        
    } failure:^(NSError *failure) {
        MMLog(@"CommitLeaveApproal ========= failure ============%@",failure);
        [self showTotasViewWithMes:@"网络错误"];
    }];
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

- (UIView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.height, kHeaderH)];
        _headerView.backgroundColor = [UIColor clearColor];
        MMLeaveTitleView *leaverView = [[MMLeaveTitleView alloc] initWithFrame:CGRectMake(0, 10, self.view.width, 40)];
        leaverView.backgroundColor = [UIColor whiteColor];
        leaverView.rightStr = _listModel.name;
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
