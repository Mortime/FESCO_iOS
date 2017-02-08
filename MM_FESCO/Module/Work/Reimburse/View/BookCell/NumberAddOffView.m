//
//  NumberAddOffView.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/10.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NumberAddOffView.h"

@interface NumberAddOffView ()

@end

@implementation NumberAddOffView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.reduceButton];
    [self addSubview:self.resultLabel];
    [self addSubview:self.unitLabel];
    [self addSubview:self.addButton];
}
- (void)layoutSubviews{
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@20);
    }];
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.reduceButton.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(@40);
    }];
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.resultLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(@20);
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.unitLabel.mas_right).offset(25);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@20);
    }];
}
#pragma mark ---Action
- (void)numberChanage:(UIButton *)btn{
    if (btn.tag == 30001) {
        // 点击添加数量
        _reduceButton.enabled = YES;
        NSInteger number =  [_resultLabel.text integerValue];
        ++number;
        _resultLabel.text = [NSString stringWithFormat:@"%lu",number];
        
        
    }
    if (btn.tag == 30000) {
        // 点击减少数量
        if ([_resultLabel.text integerValue] < 1 || [_resultLabel.text integerValue] == 1) {
            _reduceButton.enabled = NO;
        }else{
            
            NSInteger number =  [_resultLabel.text integerValue];
            --number;
            _resultLabel.text = [NSString stringWithFormat:@"%lu",number];
        }
        if ([_delegate respondsToSelector:@selector(numberAddOffViewDelegateWihtBillNumber:)]) {
            [_delegate numberAddOffViewDelegateWihtBillNumber:_resultLabel.text];
        }
}
}
- (UIButton *)reduceButton{
    if (_reduceButton == nil) {
        _reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_reduceButton setBackgroundImage:[UIImage imageNamed:@"quantity_subtract_off"] forState:UIControlStateNormal];
        [_reduceButton setTitle:@"-" forState:UIControlStateNormal];
        [_reduceButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_reduceButton addTarget:self action:@selector(numberChanage:) forControlEvents:UIControlEventTouchUpInside];
        _reduceButton.tag = 30000;
        _reduceButton.userInteractionEnabled = YES;
        _reduceButton.backgroundColor = [UIColor clearColor];
        
    }
    return _reduceButton;
}

- (UILabel *)resultLabel{
    if (_resultLabel == nil) {
        _resultLabel = [[UILabel alloc] init];
        _resultLabel.text = @"1";
        _resultLabel.font = [UIFont systemFontOfSize:14];
        _resultLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _resultLabel.textAlignment = NSTextAlignmentRight;
    }
    return _resultLabel;
}
- (UILabel *)unitLabel{
    if (_unitLabel == nil) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.text = @"张";
        _unitLabel.font = [UIFont systemFontOfSize:14];
        _unitLabel.textColor = [UIColor grayColor];
        _unitLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _unitLabel;
}


- (UIButton *)addButton{
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_addButton setBackgroundImage:[UIImage imageNamed:@"quantity_add_on"] forState:UIControlStateNormal];
        [_addButton setTitle:@"+" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(numberChanage:) forControlEvents:UIControlEventTouchUpInside];
        _addButton.tag = 30001;
        _addButton.userInteractionEnabled = YES;
        _addButton.backgroundColor = [UIColor clearColor];
        
    }
    return _addButton;
}

@end
