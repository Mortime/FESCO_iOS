//
//  PhoneListTableCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/25.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PhoneListTableCell.h"

@interface PhoneListTableCell ()

@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic ,strong) UIImageView *leftImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *phoneLabel;

@property (nonatomic ,strong) UILabel *mobileLabel;




@end

@implementation PhoneListTableCell

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
    [self.bgView addSubview:self.leftImageView];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.mobileLabel];
    [self.bgView addSubview:self.phoneLabel];
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
        
    }];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView.mas_left).offset(16);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@40);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(16);
        make.centerY.mas_equalTo(self.leftImageView.mas_centerY);
        make.height.mas_equalTo(@14);
        
    }];
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.leftImageView.mas_top);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-16);
        make.height.mas_equalTo(@14);
        
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mobileLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self.mobileLabel.mas_right);
        make.height.mas_equalTo(@14);
        
    }];



}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark ---- Lazy 加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor  =  [UIColor whiteColor];
        
    }
    return _bgView;
}
- (UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = [UIColor cyanColor];
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.layer.cornerRadius = 20;
        
    }
    return _leftImageView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.text = @"奥巴马";
        
    }
    return _nameLabel;
}
- (UILabel *)mobileLabel{
    if (_mobileLabel == nil) {
        _mobileLabel = [[UILabel alloc] init];
        _mobileLabel.font = [UIFont systemFontOfSize:14];
        _mobileLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _mobileLabel.text = @"13522535090";
        
    }
    return _mobileLabel;
}

- (UILabel *)phoneLabel{
    if (_phoneLabel == nil) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textColor = [UIColor grayColor];
        _phoneLabel.text = @"010--110";
        
    }
    return _phoneLabel;
}



@end
