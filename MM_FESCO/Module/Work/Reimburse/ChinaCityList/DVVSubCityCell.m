//
//  DVVSubCityCell.m
//  studentDriving
//
//  Created by 大威 on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVSubCityCell.h"

@implementation DVVSubCityCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.cityNameButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _cityNameButton.frame = self.bounds;
}

#pragma mark - 刷新数据

- (void)refreshData:(DVVCityListDMData *)dmData {
    
    [_cityNameButton setTitle:dmData.name forState:UIControlStateNormal];
}

- (UIButton *)cityNameButton {
    if (!_cityNameButton) {
        _cityNameButton = [UIButton new];
        [_cityNameButton setBackgroundImage:[UIImage imageNamed:@"signUpButton_icon"] forState:UIControlStateNormal];
        _cityNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _cityNameButton.userInteractionEnabled = NO;
    }
    return _cityNameButton;
}

@end
