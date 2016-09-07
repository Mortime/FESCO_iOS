//
//  popOutView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/7.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "popOutView.h"

@interface popOutView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITextField *textFiled;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, strong) MMSignOUtTextFieldDelegateBlock didEndEditingBlock;

@property (nonatomic, strong) MMSignOUtButtonBlock didClickBlock;



@end

@implementation popOutView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.textFiled.delegate = self;
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.textFiled];
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.cancleButton];
    [self.bgView addSubview:self.commitButton];
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(80);
        make.centerY.mas_equalTo (self.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-80);
        make.height.mas_equalTo (@140);
    }];
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.bgView.mas_top).offset(20);
        make.left.mas_equalTo(self.bgView.mas_left).offset(20);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-20);
        make.height.mas_equalTo (@44);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.textFiled.mas_bottom).offset(10);
        make.left.mas_equalTo(self.textFiled.mas_left);
        make.right.mas_equalTo(self.textFiled.mas_right);
        make.height.mas_equalTo (@1);
    }];
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.lineView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.textFiled.mas_left);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo (@44);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.lineView.mas_bottom).offset(10);
        make.right.mas_equalTo(self.textFiled.mas_right);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo (@44);
    }];
}
- (void)didSignButon:(UIButton *)sender{
    if (_didClickBlock) {
        _didClickBlock(sender);
    }
    
}
#pragma mark --- UITextFileDegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (_didEndEditingBlock) {
        _didEndEditingBlock(textField);
    }
}
- (void)dvv_setTextFieldDidEndEditingBlock:(MMSignOUtTextFieldDelegateBlock)handle {
    
    _didEndEditingBlock = handle;
}
- (void)mm_setSignOutSelected:(MMSignOUtButtonBlock)handle{
    _didClickBlock = handle;
}
#pragma mark ---- Lazy 加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 5.;
        
    }
    return _bgView;
}
- (UITextField *)textFiled {
    if (_textFiled == nil) {
        _textFiled = [[UITextField alloc] init];
        [_textFiled setValue:[UIColor colorWithHexString:@"666666"] forKeyPath:@"_placeholderLabel.textColor"];
        [_textFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        _textFiled.font = [UIFont systemFontOfSize:14];
        _textFiled.textColor = [UIColor grayColor];
        _textFiled.backgroundColor = [UIColor clearColor];
        _textFiled.placeholder = @"请输入外勤备注";
        
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        leftView.image = [UIImage imageNamed:@""];
        _textFiled.leftView = leftView;
        _textFiled.leftViewMode = UITextFieldViewModeAlways;

        _textFiled.layer.masksToBounds = YES;
        _textFiled.layer.cornerRadius = 5;
        _textFiled.layer.borderWidth = 1;
        _textFiled.layer.borderColor = [UIColor grayColor].CGColor;
        
        
    }
    return _textFiled;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}
- (UIButton *)cancleButton {
    
    if (_cancleButton == nil) {
        _cancleButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        [_cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancleButton addTarget:self action:@selector(didSignButon:) forControlEvents:UIControlEventTouchUpInside];
        _cancleButton.tag = 900;
    }
    return _cancleButton;
    
}

- (UIButton *)commitButton {
    
    if (_commitButton == nil) {
        _commitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton setTitle:@"确定" forState:UIControlStateNormal];
        _commitButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_commitButton addTarget:self action:@selector(didSignButon:) forControlEvents:UIControlEventTouchUpInside];
        _commitButton.tag = 901;
    }
    return _commitButton;
    
}


@end
