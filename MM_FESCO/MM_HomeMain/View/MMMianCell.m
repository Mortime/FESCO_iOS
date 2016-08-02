//
//  MMMianCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMMianCell.h"

@implementation MMMianCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.leftImageView];
    [self.bgView addSubview:self.messageLabel];
}
- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(@60);
    }];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(self.bgView.mas_left).offset(20);
        make.centerY.mas_equalTo (self.bgView.mas_centerY);
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@30);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
         make.centerY.mas_equalTo (self.bgView.mas_centerY);
        make.height.mas_equalTo(@16);
    }];
}

#pragma mark ---- Lazy 加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        CGFloat hue = arc4random() % 100 / 100.0; //色调：0.0 ~ 1.0
        CGFloat saturation = (arc4random() % 50 / 100) + 0.5; //饱和度：0.5 ~ 1.0
        CGFloat brightness = (arc4random() % 50 / 100) + 0.5; //亮度：0.5 ~ 1.0
        _bgView.backgroundColor  =  [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];

    }
    return _bgView;
}
- (UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = [UIColor cyanColor];
    }
    return _leftImageView;
}

- (UILabel *)messageLabel{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textColor = [UIColor whiteColor];
        
    }
    return _messageLabel;
}
- (void)setMessageStr:(NSString *)messageStr{
    NSLog(@"=000000000000000  ==============  %@",messageStr);
    self.messageLabel.text = messageStr;
}
@end
