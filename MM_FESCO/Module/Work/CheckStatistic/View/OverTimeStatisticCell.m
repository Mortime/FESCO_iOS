//
//  OverTimeStatisticCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "OverTimeStatisticCell.h"


@interface OverTimeStatisticCell ()


@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *timeLabel;





@end

@implementation OverTimeStatisticCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return  self;
}
- (void)initUI{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.numberLabel];
    [self.bgView addSubview:self.iconImageView];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.flageImageView];
    [self.bgView addSubview:self.timeLabel];
    [self.bgView addSubview:self.titleLabel];
    
}
- (void)layoutSubviews{
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.bgView.mas_left);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        make.width.mas_equalTo(@30);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.numberLabel.mas_right);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@40);
    }];
    
   

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        make.width.mas_equalTo(@80);
        
    }];
    
    [self.flageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@23);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).offset(-20);
         make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.height.mas_equalTo(@15);
        
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timeLabel.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.height.mas_equalTo(@13);
        
    }];
   
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        
    }
    return _bgView;
}
- (UILabel *)numberLabel{
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = [UIColor blackColor];
        _numberLabel.font = [UIFont systemFontOfSize:12];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _numberLabel;
}
- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.userInteractionEnabled = NO;
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 5;
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.image = [UIImage imageNamed:@"People_Place_Icon"];
    }
    return _iconImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _nameLabel;
}
- (UIImageView *)flageImageView{
    if (_flageImageView == nil) {
        _flageImageView = [[UIImageView alloc] init];
        _flageImageView.backgroundColor = [UIColor clearColor];
        _flageImageView.hidden = YES;
    }
    return _flageImageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.text = @"累计加班:";
        
    }
    return _titleLabel;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _timeLabel;
}
- (void)setModel:(OverTimeStatisticModel *)model{
    if (model.name) {
        _nameLabel.text = model.name;
    }
    if (model.timeNumber) {
        _timeLabel.text = [NSString stringWithFormat:@"%.2fH",model.timeNumber];
    }
    
}
- (void)setIndex:(NSInteger)index{
    _numberLabel.text = [NSString stringWithFormat:@"%lu",index];
}

@end
