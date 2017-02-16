//
//  MMTitleLabel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMTitleLabel.h"

@interface MMTitleLabel ()

@property (nonatomic ,strong) UILabel *topLabel;

@property (nonatomic ,strong) UILabel *bottomLabel;

@end

@implementation MMTitleLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.topLabel];
    [self addSubview:self.bottomLabel];
}
- (void)layoutSubviews{
    NSNumber *W = [NSNumber numberWithFloat:self.width];
    NSNumber *H = [NSNumber numberWithFloat:((self.height - 20) / 2)];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
//        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(W);
        make.height.mas_equalTo(H);
        
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLabel.mas_bottom);
//        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(W);
        make.height.mas_equalTo(H);
        
    }];
    
    _topLabel.text = self.topStr;
    _bottomLabel.text = self.bottomStr;
    
}
- (UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.font = [UIFont systemFontOfSize:14];
        _topLabel.textColor = [UIColor blackColor];
        _topLabel.text = @"签到类型";
        _topLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _topLabel;
}
- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.font = [UIFont systemFontOfSize:12];
        _bottomLabel.textColor = [UIColor grayColor];
        _bottomLabel.text = @"申请时间: 2016-8-30 20:34";
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _bottomLabel;
}

@end
