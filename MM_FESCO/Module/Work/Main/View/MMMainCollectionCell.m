//
//  MMMainCollectionCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/11.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMMainCollectionCell.h"


@interface MMMainCollectionCell ()


@property (nonatomic ,strong) UIView *bgView;


@end
@implementation MMMainCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.flagImageView];
    [self addSubview:self.tittleLabel];
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(@62);
        make.height.mas_equalTo(@62);
        
        
    }];

    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@36);
        make.height.mas_equalTo(@32);

        
    }];
    [self.tittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_bottom).offset(10);
        make.centerX.mas_equalTo (self.bgView.mas_centerX);
        make.width.mas_equalTo(self.width);
        make.height.mas_equalTo(15);
        
    }];
    
    
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = RGB_Color(41, 53, 68);
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 31;
    }
    return _bgView;
}
- (UIImageView *)flagImageView{
    if (_flagImageView == nil) {
        _flagImageView = [[UIImageView alloc] init];
        _flagImageView.backgroundColor = [UIColor clearColor];
    }
    return _flagImageView;
}
- (UILabel *)tittleLabel{
    if (_tittleLabel == nil) {
        _tittleLabel = [[UILabel alloc] init];
        _tittleLabel.text = @"个人信息";
        _tittleLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _tittleLabel.font = [UIFont systemFontOfSize:14];
        _tittleLabel.textAlignment = NSTextAlignmentCenter;
    
    }
    return _tittleLabel;
}



@end
