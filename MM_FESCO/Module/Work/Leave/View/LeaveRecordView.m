//
//  LeaveRecordView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveRecordView.h"
#import "LeaveRecordCell.h"
#import "LeavaRecordListModel.h"
#import "MMNoDataShowBGView.h"
@interface LeaveRecordView ()<UITableViewDelegate,UITableViewDataSource,LeaveRecordCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) MMNoDataShowBGView *noDataShowBGView;


@end

@implementation LeaveRecordView

- (instancetype)initWithFrame:(CGRect)frame  {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    
    }
    return self;
    
}
- (void)initUI{
    
    self.backgroundColor = [UIColor clearColor];
    self.dataArray = [NSMutableArray array];
    [self addSubview:self.tableView];
    [self addSubview:self.noDataShowBGView];
    
}
#pragma mark - 刷新数据
- (void)refreshUI {
    
    [self.tableView reloadData];
}

#pragma mark - 刷新数据
- (void)networkRequest {
    [NetworkEntity postLeaveRecordListSuccess:^(id responseObject) {
        MMLog(@"LeaveRecordList ========responseObject=========%@",responseObject);
        [_dataArray removeAllObjects];
        if ([[responseObject objectForKey:@"list"] count] == 0) {
            [self refreshUI];
            return ;
        }
        for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
            LeavaRecordListModel *listModel = [LeavaRecordListModel yy_modelWithDictionary:dic];
            [_dataArray addObject:listModel];
        }
        [self refreshUI];

    } failure:^(NSError *failure) {
        MMLog(@"LeaveRecordList ========failure=========%@",failure);
        [_parementVC showTotasViewWithMes:@"网络错误"];
    }];
    
}
- (void)leaveRecordCellDelegatewithLeaveID:(NSInteger )index{
    MMLog(@"indexindex == %lu",index);
   
    LeavaRecordListModel *model = _dataArray[index];
     MMLog(@"indexindex == %@",[NSDate dateFromSSWithss:model.endTime]);
    NSString *leaveID = [NSString stringWithFormat:@"%lu",model.leaveID];
    [NetworkEntity postDelLeaveRecordWithHolEmpExamId:leaveID Success:^(id responseObject) {
        MMLog(@"DelLeaveRecord ========responseObject=========%@",responseObject);
        
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"error"]) {
            [_parementVC showTotasViewWithMes:@"删除失败"];
        }else{
            
        }
        
        [self refreshUI];
    } failure:^(NSError *failure) {
        MMLog(@"DelLeaveRecord ========failure=========%@",failure);
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (_dataArray.count == 0) {
        _noDataShowBGView.hidden = NO;
    }else{
        _noDataShowBGView.hidden = YES;

    }
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150 + 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    static NSString *IDCell = @"cellID";
    LeaveRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[LeaveRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
    
        cell.listModel = _dataArray[indexPat.row];
    cell.delegate = self;
    cell.tableView = self.tableView;
    
    return cell;
    
}

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath{
    
    
    //如果是删除
    if(editingStyle==UITableViewCellEditingStyleDelete){
        
        
        LeavaRecordListModel *model = _dataArray[indexPath.row];
        MMLog(@"indexindex == %@",[NSDate dateFromSSWithss:model.applyDate]);
        
        // 判断是否为本月数据
        NSString *applyDate = [NSDate dateFromSSWithss:model.applyDate];
        BOOL isCurMonth = [self isCurrentMonth:applyDate];
        
        if (!isCurMonth) {
            [_parementVC showTotasViewWithMes:@"只能删除本月数据"];
//            [self refreshUI];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            return;
        }
        
    
        NSString *leaveID = [NSString stringWithFormat:@"%lu",model.leaveID];
        [NetworkEntity postDelLeaveRecordWithHolEmpExamId:leaveID Success:^(id responseObject) {
            MMLog(@"DelLeaveRecord ========responseObject=========%@",responseObject);
            
            if ([[responseObject objectForKey:@"message"] isEqualToString:@"error"]) {
                [_parementVC showTotasViewWithMes:@"删除失败"];
            }else if([[responseObject objectForKey:@"message"] isEqualToString:@"success"]){
                 [_parementVC showTotasViewWithMes:@"删除成功"];
                // 删除数据
                [_dataArray removeObjectAtIndex:indexPath.row];
                // 删除UI
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
//            [self refreshUI];
        } failure:^(NSError *failure) {
            MMLog(@"DelLeaveRecord ========failure=========%@",failure);
        }];

    }
    
    
}
#pragma mark ---- Action
- (void)didClick:(UIButton *)sender{
    
}
 // 判断是否为本月数据
- (BOOL)isCurrentMonth:(NSString *)dateStr{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    // 当前时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    // 申请时间
    NSDate *applyDate = [fmt dateFromString:dateStr];
    
    
    MMLog(@"nowString===%@==%@===applyStr===%@ ==%@ ",nowString,nowDate,dateStr,applyDate);
    
    NSDate *dat = [[NSDate alloc] init];
    BOOL Is = [dat isSameMonthAsDate:applyDate];
    MMLog(@"isSameMonthAsDate = %d",Is);
   
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 想比较哪些元素
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *cmps = [calendar components:unit fromDate:nowDate toDate:applyDate options:0];
    MMLog(@"cmps.year,cmps.month==%lu==%lu",cmps.year,cmps.month);
    return Is;
}


- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}


- (MMNoDataShowBGView *)noDataShowBGView{
    if (_noDataShowBGView == nil) {
        _noDataShowBGView = [[MMNoDataShowBGView alloc] initWithFrame:CGRectMake(0, 0,self.width,self.height)];
        _noDataShowBGView.imgStr = @"MM_NO_Recorder";
        _noDataShowBGView.hidden = YES;
    }
    return _noDataShowBGView;
}

@end
