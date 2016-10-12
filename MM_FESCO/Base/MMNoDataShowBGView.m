//
//  JZNoDataShowBGView.m
//  HeiMao_B
//
//  Created by ytzhang on 16/4/7.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "MMNoDataShowBGView.h"

@interface MMNoDataShowBGView ()


//@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *imgView;

//@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MMNoDataShowBGView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = [UIColor clearColor];
        NSLog(@"self.height  = %f",self.height);
    }
    return self;
}
- (void)initUI{

    [self addSubview:self.imgView];
    
}
- (void)layoutSubviews{
    

    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(@23);
        make.width.mas_equalTo(@103);
    }];

   }

- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor clearColor];
        
        
    }
    return _imgView;
}

// 图片赋值
- (void)setImgStr:(NSString *)imgStr{
    self.imgView.image = [UIImage imageNamed:imgStr];
}

@end
