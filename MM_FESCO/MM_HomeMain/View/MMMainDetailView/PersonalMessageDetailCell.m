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

@property (nonatomic ,strong) UIImageView *lineImageView;

@property (nonatomic ,strong) UIImageView *leftImageView;

@property (nonatomic ,strong) UITextField *detailFiled;



@end

@implementation PersonalMessageDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor clearColor];
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.lineImageView];
    [self.bgView addSubview:self.leftImageView];
    [self.bgView addSubview:self.detailFiled];
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
        make.height.mas_equalTo(@75);
    }];
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bgView.mas_top).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.height.mas_equalTo(@1);
    }];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.bgView.mas_left).offset(35);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@22);
    }];

    [self.detailFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(44);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.height.mas_equalTo(self.bgView.mas_height);
    }];

}

#pragma mark ---- Lazy 加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor  =  [UIColor clearColor];
        
    }
    return _bgView;
}

- (UIImageView *)lineImageView{
    if (_lineImageView == nil) {
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.backgroundColor = MM_MAIN_LINE_COLOR;
    }
    return _lineImageView;
}
- (UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = [UIColor clearColor];
    }
    return _leftImageView;
}
- (UITextField *)detailFiled{
    if (_detailFiled == nil ) {
        _detailFiled = [[UITextField alloc] init];
        _detailFiled.placeholder = @"姓名";
        _detailFiled.text = @"王宝强";
        [_detailFiled setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_detailFiled setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        _detailFiled.font = [UIFont systemFontOfSize:15];
        _detailFiled.textColor = [UIColor whiteColor];
        _detailFiled.backgroundColor = [UIColor clearColor];

        
    }
    return _detailFiled;
}
#pragma mark ---- 
- (void)setImgStr:(NSString *)imgStr{
    self.leftImageView.image = [UIImage imageNamed:imgStr];
}
- (void)setDataStr:(NSString *)dataStr{
    self.detailFiled.text = dataStr;
}
@end
