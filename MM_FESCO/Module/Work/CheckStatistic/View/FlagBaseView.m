//
//  FlagBaseView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "FlagBaseView.h"

@interface FlagBaseView ()

@property (nonatomic, strong) UIImageView *leftView;

@end

@implementation FlagBaseView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.leftView];
}
- (void)layoutSubviews{
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(@15);
        make.height.mas_equalTo(@15);
    }];
    _leftView.image = [UIImage imageNamed:_imgStr];

}
- (UIImageView *)leftView{
    if (_leftView == nil) {
        _leftView = [[UIImageView alloc] init];
        
    }
    return _leftView;
}

@end
