//
//  FlagBaseView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "FlagBaseView.h"

@interface FlagBaseView ()

@property (nonatomic, strong) UIView *leftView;

@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation FlagBaseView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.leftView];
    [self addSubview:self.rightLabel];
}
- (void)layoutSubviews{
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(@10);
        make.height.mas_equalTo(@10);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(@15);
    }];
    _leftView.backgroundColor = _titleColor;
    _rightLabel.text = _titleStr;

}
- (UIView *)leftView{
    if (_leftView == nil) {
        _leftView = [[UIView alloc] init];
        
    }
    return _leftView;
}
- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _rightLabel;
}

@end
