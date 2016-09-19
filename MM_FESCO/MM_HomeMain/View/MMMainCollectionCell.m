//
//  MMMainCollectionCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/11.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMMainCollectionCell.h"


@interface MMMainCollectionCell ()





@end
@implementation MMMainCollectionCell

- (void)awakeFromNib {
    
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
    [self addSubview:self.flagImageView];
    [self addSubview:self.tittleLabel];
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@33);

        
    }];
    [self.tittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.flagImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo (self.mas_centerX);
        make.width.mas_equalTo(self.width);
        make.height.mas_equalTo(14);
        
    }];
    
    
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
        _tittleLabel.textColor = [UIColor colorWithHexString:@"2f2f2f"];
        _tittleLabel.font = [UIFont systemFontOfSize:14];
        _tittleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tittleLabel;
}



@end
