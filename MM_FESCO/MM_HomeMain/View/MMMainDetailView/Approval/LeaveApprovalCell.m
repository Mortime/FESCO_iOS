//
//  LeaveApprovalCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveApprovalCell.h"

#define fontSize 12

@interface LeaveApprovalCell ()

@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic ,strong) UILabel *name;

@property (nonatomic ,strong) UILabel *applyTime;

@property (nonatomic, strong) UIView *leftLineView;

@property (nonatomic, strong) UILabel *leaveTypeLabel;

@property (nonatomic, strong) UIView *rightLineView;

@property (nonatomic ,strong) UILabel *startTime;

@property (nonatomic ,strong) UILabel *signType;

@property (nonatomic, strong) UIButton *flagButon;



@end

@implementation LeaveApprovalCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.name];
    [self.bgView addSubview:self.applyTime];
    [self.bgView addSubview:self.leftLineView];
    [self.bgView addSubview:self.leaveTypeLabel];
    [self.bgView addSubview:self.rightLineView];
    [self.bgView addSubview:self.startTime];
    [self.bgView addSubview:self.signType];
    [self.bgView addSubview:self.flagButon];
    
}
- (void)layoutSubviews{
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.height.mas_equalTo(@14);
//        make.right.mas_equalTo(self.bgView.mas_right);
        
    }];
    
    [self.applyTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(12);
        make.left.mas_equalTo(self.name.mas_right).offset(10);
        make.height.mas_equalTo(@fontSize);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        
    }];

    
    [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.name.mas_bottom).offset(15);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-56);
        make.height.mas_equalTo(@1);
        
    }];
    
    [self.leaveTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftLineView.mas_right).offset(8);
        make.height.mas_equalTo(@14);
        make.centerY.mas_equalTo(self.leftLineView.mas_centerY);
        
    }];
    [self.rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftLineView.mas_top);
        make.left.mas_equalTo(self.leaveTypeLabel.mas_right).offset(5);
        make.height.mas_equalTo(@1);
        make.right.mas_equalTo(self.bgView.mas_right);
        
    }];
    
    [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftLineView.mas_bottom).offset(15);
        make.left.mas_equalTo(self.name.mas_left);
        make.height.mas_equalTo(@fontSize);
        
    }];
    [self.signType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startTime.mas_bottom).offset(10);
        make.left.mas_equalTo(self.name.mas_left);
        make.height.mas_equalTo(@fontSize);
        
    }];
    [self.flagButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leaveTypeLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-20);
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@30);
        
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
#pragma mark ---- Lazy 加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor  =  [UIColor whiteColor];
        
    }
    return _bgView;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:14];
        _name.textColor = [UIColor blackColor];
        _name.text = @"Paco Xiao";
        
    }
    return _name;
}
- (UILabel *)applyTime{
    if (_applyTime == nil) {
        _applyTime = [[UILabel alloc] init];
        _applyTime.font = [UIFont systemFontOfSize:12];
        _applyTime.textColor = [UIColor grayColor];
        _applyTime.text = @"申请时间: 2016-8-30 20:34";
        
    }
    return _applyTime;
}

- (UIView *)leftLineView{
    if (_leftLineView == nil) {
        _leftLineView = [[UIView alloc] init];
        _leftLineView.backgroundColor = [UIColor grayColor];
    }
    return _leftLineView;
}
- (UILabel *)leaveTypeLabel{
    if (_leaveTypeLabel == nil) {
        _leaveTypeLabel = [[UILabel alloc] init];
        _leaveTypeLabel.font = [UIFont systemFontOfSize:14];
        _leaveTypeLabel.textColor = [UIColor blackColor];
        _leaveTypeLabel.text = @"年假";
        
    }
    return _leaveTypeLabel;
}
- (UIView *)rightLineView{
    if (_rightLineView == nil) {
        _rightLineView = [[UIView alloc] init];
        _rightLineView.backgroundColor = [UIColor grayColor];
    }
    return _rightLineView;
}


- (UILabel *)startTime{
    if (_startTime == nil) {
        _startTime = [[UILabel alloc] init];
        _startTime.font = [UIFont systemFontOfSize:12];
        _startTime.textColor = [UIColor grayColor];
        _startTime.text = @"签到时间: 2016-8-31 20:56";
        
    }
    return _startTime;
}
- (UILabel *)signType{
    if (_signType == nil) {
        _signType = [[UILabel alloc] init];
        _signType.font = [UIFont systemFontOfSize:12];
        _signType.textColor = [UIColor grayColor];
        _signType.text = @"签到类型: 签到";
        
    }
    return _signType;
}


- (UIButton *)flagButon{
    if (_flagButon == nil) {
        _flagButon = [UIButton buttonWithType:UIButtonTypeCustom];
        _flagButon.backgroundColor = RGB_Color(238, 133, 10);
        [_flagButon setTitle:@"1" forState:UIControlStateNormal];
        [_flagButon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    return _flagButon;
}

@end
