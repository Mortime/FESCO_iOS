//
//  MMChooseTextFile.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/31.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMChooseTextFile.h"

@interface MMChooseTextFile ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UITextField *rightTextFiled;


@end

@implementation MMChooseTextFile
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.rightTextFiled.delegate = self;
    [self addSubview:self.bgView];
    
    [self.bgView addSubview:self.leftLabel];
    [self.bgView addSubview:self.rightTextFiled];
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
    }];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.bgView.centerY);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@60);
        
    }];
    [self.rightTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.leftLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.bgView.centerY);
        make.height.mas_equalTo(self.mas_height);
        make.right.mas_equalTo(self.bgView.mas_right);
        
    }];
    
    
    self.leftLabel.text = self.leftTitle;
    self.rightTextFiled.placeholder = self.placeHold;
    self.rightTextFiled.text = self.textFileStr;
    
}
#pragma mark ----- UIScrollerDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    

    self.leftLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
    self.rightTextFiled.textColor = MM_MAIN_FONTCOLOR_BLUE;
    _bgView.layer.borderColor = MM_MAIN_FONTCOLOR_BLUE.CGColor;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.leftLabel.textColor = [UIColor grayColor];
    self.rightTextFiled.textColor = [UIColor grayColor];
    _bgView.layer.borderColor = [UIColor whiteColor].CGColor;
}
#pragma mark ---- Lazy加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor redColor];
        _bgView.layer.borderWidth = 2;
        _bgView.userInteractionEnabled = YES;
        _bgView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _bgView;
}
- (UILabel *)leftLabel{
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.centerY = self.bgView.centerY;
        _leftLabel.font = [UIFont systemFontOfSize:14];
        _leftLabel.textColor = [UIColor grayColor];
    }
    return _leftLabel;
}
- (UITextField *)rightTextFiled {
    if (_rightTextFiled == nil) {
        _rightTextFiled = [[UITextField alloc] init];
        [_rightTextFiled setValue:[UIColor colorWithHexString:@"666666"] forKeyPath:@"_placeholderLabel.textColor"];
        [_rightTextFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        _rightTextFiled.font = [UIFont systemFontOfSize:14];
        _rightTextFiled.textColor = [UIColor grayColor];
        _rightTextFiled.backgroundColor = [UIColor cyanColor];
    
    }
    return _rightTextFiled;
}
@end
