//
//  MMLeaveTitleView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMLeaveTitleView.h"

@interface MMLeaveTitleView ()

@property (nonatomic ,strong) UILabel *topLabel;

@property (nonatomic ,strong) UILabel *bottomLabel;

@end

@implementation MMLeaveTitleView

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
    NSNumber *H = [NSNumber numberWithFloat:(self.height)];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(66);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(H);
        
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-70);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(H);
        
    }];
    
        _bottomLabel.text = self.rightStr;
    
}
- (UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.font = [UIFont systemFontOfSize:14];
        _topLabel.textColor = [UIColor blackColor];
        _topLabel.text = @"假期类型";
        
        
    }
    return _topLabel;
}
- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.font = [UIFont systemFontOfSize:14];
        _bottomLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _bottomLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _bottomLabel;
}

@end
