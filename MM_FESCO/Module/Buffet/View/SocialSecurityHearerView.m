//
//  SocialSecurityHearerView.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/23.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "SocialSecurityHearerView.h"
#import "SocialSecurityCellView.h"

@interface SocialSecurityHearerView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) SocialSecurityCellView *nameView;

@property (nonatomic, strong) SocialSecurityCellView *sexView;

@property (nonatomic, strong) SocialSecurityCellView *nationView;

@property (nonatomic, strong) UIImageView *iconView;


@end

@implementation SocialSecurityHearerView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.nameView];
    [self.bgView addSubview:self.sexView];
    [self.bgView addSubview:self.nationView];
    [self.bgView addSubview:self.iconView];
    
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        
    }];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-100);
        make.height.mas_equalTo(@44);
        
    }];
    [self.sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameView.mas_bottom);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-100);
        make.height.mas_equalTo(@44);
        
    }];
    [self.nationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sexView.mas_bottom);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-100);
        make.height.mas_equalTo(@44);
        
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@100);
        
    }];
    
}
- (void)taps:(UIGestureRecognizer *)ges{
    
    SocialSecurityCellView *view = (SocialSecurityCellView *)ges.view;
    if ([_delegate respondsToSelector:@selector(socialSecurityHearerViewDelegateWithTag:)]) {
        [_delegate socialSecurityHearerViewDelegateWithTag:view.tag];
    }
    
    
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (SocialSecurityCellView *)nameView {
    if (_nameView == nil) {
        _nameView = [[SocialSecurityCellView alloc] init];
        _nameView.leftTitle = @"姓名";
        _nameView.placeHold = @"请输入姓名";
        _nameView.isExist = YES;
        _nameView.backgroundColor = [UIColor clearColor];
        [_nameView MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            //            [self initHourTime:textField.text];
        }];
    }
    return _nameView;
}
- (SocialSecurityCellView *)sexView {
    if (_sexView == nil) {
        _sexView = [[SocialSecurityCellView alloc] init];
        _sexView.leftTitle = @"性别";
        _sexView.placeHold = @"请选择性别";
        _sexView.backgroundColor = [UIColor clearColor];
        _sexView.dataArray = @[@"男",@"女"];
        [_sexView MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            //            [self initHourTime:textField.text];
        }];
    }
    return _sexView;
}
- (SocialSecurityCellView *)nationView {
    if (_nationView == nil) {
        _nationView = [[SocialSecurityCellView alloc] init];
        _nationView.leftTitle = @"民族";
        _nationView.placeHold = @"请选择民族";
        _nationView.backgroundColor = [UIColor clearColor];
        _nationView.rightTextFiled.enabled = NO;
        [_nationView MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            //            [self initHourTime:textField.text];
        }];
        _nationView.userInteractionEnabled = YES;
        _nationView.tag = 12301;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taps:)];
        [_nationView addGestureRecognizer:tap];
    }
    return _nationView;
}
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"Buffer_Icon"];
    }
    return _iconView;
}
@end
