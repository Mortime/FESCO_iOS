//
//  OverTimeStatisticHeaderView.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/10/24.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "OverTimeStatisticHeaderView.h"

@interface OverTimeStatisticHeaderView ()

@property (nonatomic , strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation OverTimeStatisticHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)layoutSubviews{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left).offset(25);
        make.right.mas_equalTo(self.mas_right).offset(-25);
        make.height.mas_equalTo(@(self.width - 50));
        
    }];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@15);
        
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@13);
        
    }];

}
- (void)initUI{
    [self addSubview:self.imageView];
    [self addSubview:self.topLabel];
    [self addSubview:self.bottomLabel];
}
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.userInteractionEnabled = NO;
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 5;
        _imageView.backgroundColor = [UIColor grayColor];
        //        _iconImageView.image = [UIImage imageNamed:@"LaterTime_Flage"];
    }
    return _imageView;
}

- (UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textColor = [UIColor blackColor];
        _topLabel.font = [UIFont systemFontOfSize:14];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.text = @"张三";
        
    }
    return _topLabel;
}
- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _bottomLabel.font = [UIFont systemFontOfSize:11];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.text = @"累计加班";
    }
    return _bottomLabel;
}

- (void)setModel:(OverTimeStatisticModel *)model{
    _topLabel.text = model.name;
    _bottomLabel.text = [NSString stringWithFormat:@"累计加班: %.1fH",model.timeNumber];
}

@end
