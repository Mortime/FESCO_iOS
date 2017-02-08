//
//  ReimburseWorkHeaderView.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/4.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ReimburseWorkHeaderView.h"

@interface ReimburseWorkHeaderView ()

@property (nonatomic, strong) UIImageView *flageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ReimburseWorkHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    
    [self addSubview:self.flageView];
    
    [self addSubview:self.titleLabel];
}
- (UIImageView *)flageView{
    if (_flageView == nil) {
        _flageView = [[UIImageView alloc] init];
        _flageView.backgroundColor = [UIColor clearColor];
    }
    return _flageView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}
@end
