//
//  LeaveApplicationDetailCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/3.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveApplicationDetailCell.h"

@interface LeaveApplicationDetailCell ()


@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UITextField *detailFiled;


@end

@implementation LeaveApplicationDetailCell

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
        make.height.mas_equalTo(@65);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
       
        make.left.mas_equalTo(self.bgView.mas_left).offset(15);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@64);
    }];
    [self.detailFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-30);
        make.height.mas_equalTo(@40);
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

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = RGB_Color(65, 50, 87);
        
    }
    return _titleLabel;
}
- (UITextField *)detailFiled{
    if (_detailFiled == nil ) {
        _detailFiled = [[UITextField alloc] init];
        _detailFiled.backgroundColor = [UIColor clearColor];
        _detailFiled.layer.cornerRadius = 5;
        _detailFiled.layer.masksToBounds = YES;
        _detailFiled.layer.borderColor = RGB_Color(65, 50, 87).CGColor;
        _detailFiled.layer.borderWidth = 1.f;
        
    }
    return _detailFiled;
}

- (void)setTitleStr:(NSString *)titleStr{
    self.titleLabel.text = titleStr;
}
@end
