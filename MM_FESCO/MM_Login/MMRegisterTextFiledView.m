//
//  MMRegisterTextFiledView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMRegisterTextFiledView.h"

@interface MMRegisterTextFiledView ()<UITextFieldDelegate,UIPickerViewDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *leftLabel;



@property (nonatomic, strong) MMRegisterTextFiledViewDelegateBlock didEndEditingBlock;


@end

@implementation MMRegisterTextFiledView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.rightTextFiled.delegate = self;
    [self addSubview:self.bgView];
    
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightTextFiled];
    
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
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@90);
        
    }];
    [self.rightTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.leftLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.height.mas_equalTo(self.mas_height);
        make.right.mas_equalTo(self.bgView.mas_right);
        
    }];
    
    self.leftLabel.text = self.leftTitle;
    self.rightTextFiled.placeholder = self.placeHold;
    
}
#pragma mark ----- UIScrollerDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    _bgView.backgroundColor = [UIColor blackColor];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
     _bgView.backgroundColor = [UIColor whiteColor];
    if (_didEndEditingBlock) {
            _didEndEditingBlock(self.rightTextFiled,self.tag);
        }
}
- (void)MM_setTextFieldDidEndEditingBlock:(MMRegisterTextFiledViewDelegateBlock)handle {
    _didEndEditingBlock = handle;
}

#pragma mark ---- Lazy加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.alpha = 0.2;
        _bgView.layer.masksToBounds = YES;
//        _bgView.userInteractionEnabled = YES;
        _bgView.layer.cornerRadius = 5.f;
    }
    return _bgView;
}
- (UILabel *)leftLabel{
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font = [UIFont systemFontOfSize:14];
        _leftLabel.textColor = [UIColor whiteColor];
        
    }
    return _leftLabel;
}
- (UITextField *)rightTextFiled {
    if (_rightTextFiled == nil) {
        _rightTextFiled = [[UITextField alloc] init];
        [_rightTextFiled setValue:[UIColor colorWithHexString:@"666666"] forKeyPath:@"_placeholderLabel.textColor"];
        [_rightTextFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        _rightTextFiled.font = [UIFont systemFontOfSize:14];
        _rightTextFiled.textColor = [UIColor whiteColor];
        _rightTextFiled.backgroundColor = [UIColor clearColor];
        
    }
    return _rightTextFiled;
}


@end
