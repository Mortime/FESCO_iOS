//
//  NewReimbursePopView.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/8.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewReimbursePopView.h"
#import "NewReimbursePopViewCell.h"

#define kBottomH  50

#define kButtonW  ((kMMWidth - 40 - 1) / 2)

#define kMargin  220

@interface NewReimbursePopView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *bgView;  // 白色背景

@property (nonatomic, strong) UIView *bottomView;  // 底部阴影

@property (nonatomic, strong) UIView *topView;  // 主背景

@property (nonatomic, strong) UILabel *titleLabel;  // title

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong)  NSArray *typeArray;

// 取消和确定按钮

@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) UIView *lineView;



@end
@implementation NewReimbursePopView

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
    [self.topView addSubview:self.titleLabel];
    [self.topView addSubview:self.tableView];
    
     [self.topView addSubview:self.cancleButton];
     [self.topView addSubview:self.lineView];
     [self.topView addSubview:self.commitButton];
    
    self.typeArray = @[@"差旅报销单",@"付款申请单",@"日常报销单"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    NewReimbursePopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[NewReimbursePopViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.titleStr = _typeArray[indexPath.row];
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MMLog(@"SelectRowAtIndexPath = %lu",indexPath.row);
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 17)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"选择报销单模板";
        
        
    }
    return _titleLabel;
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,(CGRectGetHeight(self.titleLabel.frame) + 10) , self.topView.width, self.topView.height - CGRectGetHeight(self.titleLabel.frame) - kBottomH) style:UITableViewStylePlain];
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
- (UIButton *)cancleButton{
    if (_cancleButton == nil) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.frame = CGRectMake(0, kMargin - kBottomH , kButtonW, kBottomH);
        _cancleButton.backgroundColor = [UIColor clearColor];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }
    return _cancleButton;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(kButtonW, kMargin - kBottomH + 15, 1, 20)];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}
- (UIButton *)commitButton{
    if (_commitButton == nil) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.frame = CGRectMake(kButtonW + 1, kMargin - kBottomH, kButtonW, kBottomH);
        _commitButton.backgroundColor = [UIColor clearColor];
        [_commitButton setTitle:@"确定" forState:UIControlStateNormal];
        _commitButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_commitButton setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        
        
    }
    return _commitButton;
}


@end
