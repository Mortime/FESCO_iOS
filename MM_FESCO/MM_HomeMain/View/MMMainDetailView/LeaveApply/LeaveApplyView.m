//
//  LeaveApplyView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveApplyView.h"
#import "LeaveApplyCell.h"

@interface LeaveApplyView ()<UITableViewDelegate,UITableViewDataSource,LeaveApplyCellDelegate>

@property (nonatomic, strong) NSArray *leftTitleArray;

@property (nonatomic, strong) NSArray *placeTitleArray;

@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isShowAMPM;

@property (nonatomic, assign) BOOL isShowHourTime;


@end

@implementation LeaveApplyView{
    
    NSArray *_resultArray;
    
     NSMutableArray *_pickDataArray;
    
     NSString *_beginTime;
    
     NSString *_endTime;
    
    NSString *_timeDuring;
    
    NSString *_timeUntiy;
    
    NSString *_applyIdea;
    
    NSString *_applyPeopel;
    
    NSMutableArray *_holTypeArray;
    
    NSArray *_hoeResultArray;
    
    NSArray *_unitsArray;
    
    BOOL _isShowOverpluHolNum; // 是否显示剩余假期数目
    
    NSString *_yearHolNumber; // 剩余年假
    
    NSString *_wearHolNumber; // 剩余调休
    
    NSString *_hourTimeNum; //  调休时以半天为小时单位的小时数
    
    NSString *_beginTimeAMPM;
    
    NSString *_endAMPM;

}

- (instancetype)initWithFrame:(CGRect)frame  {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initData];
    }
    return self;
    
}
- (void)initUI{
    
    self.backgroundColor = [UIColor clearColor];
    _pickDataArray = [NSMutableArray array];
    _holTypeArray = [NSMutableArray array];
    _hoeResultArray = [NSArray array];
    
    [self addSubview:self.tableView];
    [self addSubview:self.commitButton];

}
- (void)initData{
    self.leftTitleArray = @[@"假期类型",@"时间单位",@"开始时间",@"截止时间",@"休假原因",@"审批人",@"剩余假期"];
    self.placeTitleArray = @[@"请选择假期类型",@"请选择时间单位",@"请输入开始时间",@"请选择截止时间",@"请输入休假原因",@"请选择审批人",@" "];
}
#pragma mark - 刷新数据
- (void)refreshUI {
    
    [self.tableView reloadData];
}

#pragma mark - 刷新数据
- (void)networkRequest {
    [NetworkEntity postLeaveApplyMessageSuccess:^(id responseObject) {
        MMLog(@"LeaveApplyMessage ========responseObject=========%@",responseObject);
        // 审批人选择
        NSArray  *applyPeople = [responseObject objectForKey:@"availableApprovalManList"];
        _resultArray =  applyPeople;
        for (NSDictionary *dic in applyPeople) {
            NSString *str = [dic objectForKey:@"emp_Name"];
            [_pickDataArray addObject:str];
        }
        // 假期类型数组
        NSArray  *holTypeArray = [responseObject objectForKey:@"holSetList"];
        _hoeResultArray =  holTypeArray;
        for (NSDictionary *dic in holTypeArray) {
            NSString *str = [dic objectForKey:@"hol_Name"];
            [_holTypeArray addObject:str];
        }
        // 剩余假期数目
        NSArray  *holNumArray = [responseObject objectForKey:@"holPoolList"];
        for (NSDictionary *dic in holNumArray) {
            NSString *str = [dic objectForKey:@"hol_Name"];
            if ([str isEqualToString:@"年假"]) {
                if ([[dic objectForKey:@"time_Unit"] integerValue] == 1) {
                    _yearHolNumber = [NSString stringWithFormat:@"%lu天",[[dic objectForKey:@"availableAllNum"] integerValue]];
                }
            }
            if ([str isEqualToString:@"调休"]) {
                if ([[dic objectForKey:@"time_Unit"] integerValue] == 2) {
                    _wearHolNumber = [NSString stringWithFormat:@"%lu小时",[[dic objectForKey:@"availableAllNum"] integerValue]];
                }
                if ([[dic objectForKey:@"time_Unit"] integerValue] == 1) {
                    _wearHolNumber = [NSString stringWithFormat:@"%lu天",[[dic objectForKey:@"availableAllNum"] integerValue]];
                }
                if ([[dic objectForKey:@"time_Unit"] integerValue] == 3) {
                    _wearHolNumber = [NSString stringWithFormat:@"%lu半天",[[dic objectForKey:@"availableAllNum"] integerValue]];
                }
            }

        }

        
        
        [self refreshUI];

    } failure:^(NSError *failure) {
        MMLog(@"LeaveApplyMessage ========failure============%@",failure);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isShowOverpluHolNum) {
        return 7;
    }
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44 + 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    static NSString *IDCell = @"cellID";
    LeaveApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        
        cell = [[LeaveApplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
    cell.delegate = self;
    cell.index = indexPat.row + 3000;
    cell.pickData = _pickDataArray;
    cell.holTypeArray = _holTypeArray;
    cell.unitsArray = _unitsArray;
    cell.leftTitle = self.leftTitleArray[indexPat.row];
    cell.placeTitle = self.placeTitleArray[indexPat.row];
    if ([_beginTime isEqualToString:@"年假"]) {

        cell.holNumberStr = _yearHolNumber;
        
    }else if ([_beginTime isEqualToString:@"调休"]) {
        cell.holNumberStr = _wearHolNumber;
    }
    [cell.textFile dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
        [self initWithTextFile:textField indexTag:indexTag];
    }];
    
    // 显示上午或下午
    cell.isShowAMPM = _isShowAMPM;
    
    // 是否显示调休小时数
    cell.isShowTimeNum = _isShowHourTime;
    
    return cell;
    
}

#pragma mark ------ LeaveApplyCellDelegate
// 调休时以半天为小时单位的小时数
- (void)leaveApplyCellDelegateWithHourTime:(NSString *)hourtime{
    _hourTimeNum = hourtime;
}
// 选择的上午或者下午  3012 开始时间  ,  3013 结束时间
- (void)leaveApplyCellDelegateWithAMPM:(UITextField *)AMPM{
    if (AMPM.tag == 3012) {
        _beginTime = AMPM.text;
        
    }
    if (AMPM.tag == 3013) {
        _endTime = AMPM.text;
        
    }
}
#pragma mark ---- Action
- (void)didClick:(UIButton *)sender{
    if (_beginTime == nil || [_beginTime isEqualToString:@" "]) {
        [self.parementVC showTotasViewWithMes:@"请选择假期类型"];
        return;
    }
    if (_endTime == nil || [_endTime isEqualToString:@" "]) {
        [self.parementVC showTotasViewWithMes:@"请选择时间单位"];
        return;
    }

    if (_timeDuring == nil || [_timeDuring isEqualToString:@" "]) {
        [self.parementVC showTotasViewWithMes:@"请选择开始时间"];
        return;
    }
//    if (_timeUntiy == nil || [_timeUntiy isEqualToString:@" "]) {
//        [self.parementVC showTotasViewWithMes:@"请选择截止时间"];
//        return;
//    }
    if (_applyIdea == nil || [_applyIdea isEqualToString:@" "]) {
        [self.parementVC showTotasViewWithMes:@"请输入休假原因"];
        return;
    }
    if (_applyPeopel == nil || [_applyPeopel isEqualToString:@" "]) {
        [self.parementVC showTotasViewWithMes:@"请选择审批人"];
        return;
    }
    
    // 审批人ID
    NSInteger applyPeopleID = 0;
    for (NSDictionary *dic in _resultArray) {
        if ([[dic objectForKey:@"emp_Name"] isEqualToString:_applyPeopel]) {
            applyPeopleID =  [[dic objectForKey:@"emp_Id"] integerValue];
        }
    }
    // 假期ID
    NSInteger holSetId = 0;
    for (NSDictionary *dic in _hoeResultArray) {
        if ([[dic objectForKey:@"hol_Name"] isEqualToString:_beginTime]) {
            holSetId =  [[dic objectForKey:@"hol_Set_Id"] integerValue];
        }
    }
    // 时间单位ID
    NSInteger unitID = 0;
    if ([_endTime isEqualToString:@"天"]) {
        unitID = 1;
    }
    if ([_endTime isEqualToString:@"小时"]) {
        unitID = 2;
    }
    if ([_endTime isEqualToString:@"半天"]) {
        unitID = 3;
    }
    
    // holNum  调休时以半天为小时单位的小时数   endTime
    NSString *holNum = @"";
    NSString *endTime = @"";
    if ([_beginTime isEqualToString:@"调休"] && [_endTime isEqualToString:@"小时"]) {
        holNum = _hourTimeNum;
        
    }else{
        endTime = _timeUntiy;
    }
    
    // beginAMPM  endAMPM
    NSString *beginAMPM = @"";
    NSString *endAMPM = @"";
    if ([_endTime isEqualToString:@"半天"]) {
        beginAMPM = _beginTimeAMPM;
        endAMPM = _endAMPM;
    }
    
    
    [NetworkEntity postCommitLeaveApplyWihtHolSetId:holSetId holUnit:unitID holNum:holNum beginTime:_timeDuring endTime:endTime holBeginApm:beginAMPM holEndApm:endAMPM reason:_applyIdea approvalMan:applyPeopleID Success:^(id responseObject) {
        
        MMLog(@"CommitLeaveApply ========responseObject=========%@",responseObject);
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"error"]) {
            [self.parementVC showTotasViewWithMes:@"提交失败"];
        }else
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"success"]) {
            [self.parementVC showTotasViewWithMes:@"提交成功"];
        }else
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"not enough"]) {
            [self.parementVC showTotasViewWithMes:@"没有足够的假期"];
        }else{
            [self.parementVC showTotasViewWithMes:@"提交失败"];
        }
        
    } failure:^(NSError *failure) {
        MMLog(@"CommitLeaveApply ========failure=========%@",failure);
        [self.parementVC showTotasViewWithMes:@"网络错误"];
    }];
    
    
    
    
    
    
    
    
//
//    [NetworkEntity postCommitLeaveApplyWihtTimeUnit:_timeUntiy workDuration:_timeDuring beginTime:_beginTime endTime:_endTime reason:_applyIdea approvalMan:applyPeopleID Success:^(id responseObject) {
//        
//        MMLog(@"CommitLeaveApply ========responseObject=========%@",responseObject);
//        if ([[responseObject objectForKey:@"message"] isEqualToString:@"error"]) {
//            [self.parementVC showTotasViewWithMes:@"提交失败"];
//        }
//        if ([[responseObject objectForKey:@"message"] isEqualToString:@"success"]) {
//            [self.parementVC showTotasViewWithMes:@"提交成功"];
//        }
//    } failure:^(NSError *failure) {
//        MMLog(@"CommitLeaveApply ========failure=========%@",failure);
//        [self.parementVC showTotasViewWithMes:@"网络错误"];
//    }];

}
#pragma mark ----- TextFiledDelegate Block
- (void)initWithTextFile:(UITextField *)textFiled indexTag:(NSInteger )indexTag{
    if (indexTag == 3000) {
        MMLog(@"假期类型");
        _beginTime = textFiled.text;
        // 根据选择的假期类型 动态匹配对应的时间单位
        for (NSDictionary *dic in _hoeResultArray) {
            if ([[dic objectForKey:@"hol_Name"] isEqualToString:textFiled.text]) {
                NSArray *holUnits = [dic objectForKey:@"hol_Units"];
                _unitsArray = holUnits;
            }
        }
        // 根据选择的假期类型 动态匹配是否显示剩余假期
        if ([textFiled.text isEqualToString:@"年假"] || [textFiled.text isEqualToString:@"调休"]) {
            _isShowOverpluHolNum = YES;
        }else{
            _isShowOverpluHolNum = NO;
        }
        
         // 是否显示请假时数  这里为了恢复初始值
        if (![_beginTime isEqualToString:@"调休"]) {
            _isShowHourTime = NO;
        }
        
        
        
        
        [self refreshUI];
    }
    if (indexTag == 3001) {
        MMLog(@"时间单位");
        _endTime = textFiled.text;
        if ([_endTime isEqualToString:@"半天"]) {
            _isShowAMPM = YES;
        }else{
            _isShowAMPM = NO;
        }
        
        // 是否显示请假时数
        MMLog(@"%@=====%@",_beginTime,_endTime);
        if (([_beginTime isEqualToString:@"调休"]) && ([_endTime isEqualToString:@"小时"])) {
            _isShowHourTime = YES;
        }else{
            _isShowHourTime = NO;
        }
        
        [self refreshUI];
        
        
    }
    if (indexTag == 3002) {
        MMLog(@"开始时间");
        _timeDuring = textFiled.text;
    }
    if (indexTag == 3003) {
        MMLog(@"结束时间");
        _timeUntiy = textFiled.text;
    }
    if (indexTag == 3004) {
        MMLog(@"休假原因");
        _applyIdea = textFiled.text;
    }
    if (indexTag == 3005) {
        MMLog(@"审批人");
        _applyPeopel = textFiled.text;
    }
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 50) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}

- (UIButton *)commitButton{
    if (_commitButton == nil) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.frame = CGRectMake(0, self.height - 50, self.width,50);
        [_commitButton setTitle:@"提交申请" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        [_commitButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        
        
    }
    return _commitButton;
}

@end
