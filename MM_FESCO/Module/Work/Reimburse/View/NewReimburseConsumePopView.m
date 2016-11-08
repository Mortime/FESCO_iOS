//
//  NewReimburseConsumePopView.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/8.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewReimburseConsumePopView.h"

#import "NewReimburseConsumePopViewCell.h"

#define kBottomH  50

#define kButtonW  ((kMMWidth - 40 - 1) / 2)

#define kMargin  132

@interface NewReimburseConsumePopView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *bgView;  // 白色背景

@property (nonatomic, strong) UIView *bottomView;  // 底部阴影

@property (nonatomic, strong) UIView *topView;  // 主背景

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong)  NSArray *typeArray;



@end
@implementation NewReimburseConsumePopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self addSubview:self.bottomView];
    [self addSubview:self.topView];
    [self.topView addSubview:self.tableView];
    
    self.typeArray = @[@"新建消费记录",@"导入已有消费",@"取消"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    NewReimburseConsumePopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[NewReimburseConsumePopViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.titleStr = _typeArray[indexPath.row];
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_delegate respondsToSelector:@selector(newReimburseConsumePopViewDelegatWithRow:)]) {
        [_delegate newReimburseConsumePopViewDelegatWithRow:indexPath.row];
    }
    
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , self.topView.width, self.topView.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.alpha = 0.2;
    }
    return _bgView;
}
- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(30, 0, self.width - (30 + 10), kMargin)];
        _bottomView.centerY = self.centerY + 20;
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = 0.2;
        _bottomView.layer.masksToBounds = YES;
        _bottomView.layer.cornerRadius = 5;
    }
    return _bottomView;
}
- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, self.width - (20 * 2), kMargin)];
        _topView.centerY = self.centerY;
        _topView.backgroundColor = MM_MAIN_LINE_COLOR;
        _topView.layer.masksToBounds = YES;
        _topView.layer.cornerRadius = 5;
        _topView.layer.borderColor = MM_MAIN_FONTCOLOR_BLUE.CGColor;
        _topView.layer.borderWidth = 2;
    }
    return _topView;
}

@end
