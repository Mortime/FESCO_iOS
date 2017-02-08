//
//  SocialSecurityCardIDView.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/27.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "SocialSecurityCardIDView.h"

@interface SocialSecurityCardIDView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *cardIDImageView;


@end
@implementation SocialSecurityCardIDView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.cardIDImageView];
    
}

- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        
    }];
    [self.cardIDImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-10);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        
    }];
    
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UIImageView *)cardIDImageView{
    if (_cardIDImageView == nil) {
        _cardIDImageView = [[UIImageView alloc] init];
        _cardIDImageView.image = [UIImage imageNamed:@"Buffer_CardIDBg"];
    }
    return _cardIDImageView;
}
- (void)setImgStr:(NSString *)imgStr{
    _cardIDImageView.image =  [UIImage imageNamed:imgStr];

}
@end

