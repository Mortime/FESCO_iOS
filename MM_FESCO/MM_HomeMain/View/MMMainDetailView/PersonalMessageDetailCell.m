//
//  PersonalMessageDetailCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PersonalMessageDetailCell.h"

@interface PersonalMessageDetailCell ()


@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UITextField *detailFiled;

@property (nonatomic ,strong) UIImageView *lineImageView;

@end

@implementation PersonalMessageDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.detailFiled];
    [self.bgView addSubview:self.lineImageView];
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
        make.height.mas_equalTo(@105);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bgView.mas_top).offset(15);
        make.left.mas_equalTo(self.bgView.mas_left).offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.height.mas_equalTo(@14);
    }];
    [self.detailFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.titleLabel.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-15);
        make.height.mas_equalTo(@40);
    }];

    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView.mas_left).offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-1);
        make.height.mas_equalTo(@0.5);
    }];

}

#pragma mark ---- Lazy 加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor  =  RGB_Color(246, 246, 246);
        
    }
    return _bgView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = RGB_Color(72, 72, 72);
        
    }
    return _titleLabel;
}
- (UITextField *)detailFiled{
    if (_detailFiled == nil ) {
        _detailFiled = [[UITextField alloc] init];
        _detailFiled.backgroundColor = RGB_Color(246, 246, 246);
        _detailFiled.layer.cornerRadius = 5;
        _detailFiled.layer.masksToBounds = YES;
        _detailFiled.layer.borderColor = RGB_Color(72, 72, 72).CGColor;
        _detailFiled.layer.borderWidth = 1.f;
        
    }
    return _detailFiled;
}
- (UIImageView *)lineImageView{
    if (_lineImageView == nil) {
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.backgroundColor = [UIColor blackColor];
    }
    return _lineImageView;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.titleLabel.text = titleStr;
}
@end
