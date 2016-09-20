//
//  LeaveApplyView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveApplyView.h"
#import "LeaveApplyCell.h"

@interface LeaveApplyView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *leftTitleArray;

@property (nonatomic, strong) NSArray *placeTitleArray;

@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) UITableView *tableView;


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
    [self addSubview:self.tableView];
    [self addSubview:self.commitButton];

}
- (void)initData{
    self.leftTitleArray = @[@"开始时间",@"截止时间",@"加班时长",@"时长单位",@"加班原因",@"审批人"];
    self.placeTitleArray = @[@"请选择开始时间",@"请选择截止时间",@"请输入加班时长",@"请选择时长单位",@"请输入加班原因",@"请选择审批人"];
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
        [self refreshUI];

    } failure:^(NSError *failure) {
        MMLog(@"LeaveApplyMessage ========failure============%@",failure);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
    
    cell.index = indexPat.row + 3000;
    cell.pickData = _pickDataArray;
    
    cell.leftTitle = self.leftTitleArray[indexPat.row];
    cell.placeTitle = self.placeTitleArray[indexPat.row];
    [cell.textFile dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
        [self initWithTextFile:textField indexTag:indexTag];
    }];
    
    return cell;
    
}
#pragma mark ---- Action
- (void)didClick:(UIButton *)sender{
    if (_beginTime == nil || [_beginTime isEqualToString:@" "]) {
        [self.parementVC showTotasViewWithMes:@"请选择开始时间"];
        return;
    }
    if (_endTime == nil || [_endTime isEqualToString:@" "]) {
        [self.parementVC showTotasViewWithMes:@"请选择截止时间"];
        return;
    }

    if (_timeDuring == nil || [_timeDuring isEqualToString:@" "]) {
        [self.parementVC showTotasViewWithMes:@"请输入加班时长"];
        return;
    }
    if (_timeUntiy == nil || [_timeUntiy isEqualToString:@" "]) {
        [self.parementVC showTotasViewWithMes:@"请选择时长单位"];
        return;
    }
    if (_applyIdea == nil || [_applyIdea isEqualToString:@" "]) {
        [self.parementVC showTotasViewWithMes:@"请输入加班原因"];
        return;
    }
    if (_applyPeopel == nil || [_applyPeopel isEqualToString:@" "]) {
        [self.parementVC showTotasViewWithMes:@"请选择审批人"];
        return;
    }
    
    NSInteger applyPeopleID = 0;
    for (NSDictionary *dic in _resultArray) {
        if ([[dic objectForKey:@"emp_Name"] isEqualToString:_applyPeopel]) {
            applyPeopleID =  [[dic objectForKey:@"emp_Id"] integerValue];
        }
    }

    [NetworkEntity postCommitLeaveApplyWihtTimeUnit:_timeUntiy workDuration:_timeDuring beginTime:_beginTime endTime:_endTime reason:_applyIdea approvalMan:applyPeopleID Success:^(id responseObject) {
        
        MMLog(@"CommitLeaveApply ========responseObject=========%@",responseObject);
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"error"]) {
            [self.parementVC showTotasViewWithMes:@"提交失败"];
        }
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"success"]) {
            [self.parementVC showTotasViewWithMes:@"提交成功"];
        }
    } failure:^(NSError *failure) {
        MMLog(@"CommitLeaveApply ========failure=========%@",failure);
        [self.parementVC showTotasViewWithMes:@"网络错误"];
    }];

}
#pragma mark ----- TextFiledDelegate Block
- (void)initWithTextFile:(UITextField *)textFiled indexTag:(NSInteger )indexTag{
    if (indexTag == 3000) {
        MMLog(@"开始时间");
        _beginTime = textFiled.text;
    }
    if (indexTag == 3001) {
        MMLog(@"截止时间");
        _endTime = textFiled.text;
    }
    if (indexTag == 3002) {
        MMLog(@"加班时长");
        _timeDuring = textFiled.text;
    }
    if (indexTag == 3003) {
        MMLog(@"时长单位");
        _timeUntiy = textFiled.text;
    }
    if (indexTag == 3004) {
        MMLog(@"加班原因");
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
