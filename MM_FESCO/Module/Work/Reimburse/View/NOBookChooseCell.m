//
//  NOBookChooseCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NOBookChooseCell.h"

@interface NOBookChooseCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *leftimagView;

@property (nonatomic, strong) UIImageView *flageImageView;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UILabel *moneyLabel;

@end

@implementation NOBookChooseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return  self;
}
- (void)initUI{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.leftimagView];
    [self.bgView addSubview:self.flageImageView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.timeLabel];
    [self.bgView addSubview:self.moneyLabel];
    
}
- (void)layoutSubviews{
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom);
        
        
    }];
    
    [self.leftimagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@15);
        make.height.mas_equalTo(@15);
        
    }];

    
    [self.flageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftimagView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@30);
        
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.flageImageView.mas_top);
        make.left.mas_equalTo(self.flageImageView.mas_right).offset(10);
        make.right.mas_equalTo(self.bgView.mas_right);
        make.height.mas_equalTo(@14);
        
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.height.mas_equalTo(@14);
        
        
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        
        
    }];
    //    _deleBtn.tag = _indexTag;
}

#pragma mark ---- Lazy 加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIImageView *)leftimagView{
    if (_leftimagView == nil) {
        _leftimagView = [[UIImageView alloc] init];
        _leftimagView.backgroundColor = [UIColor clearColor];
        
    }
    return _leftimagView;
}

- (UIImageView *)flageImageView{
    if (_flageImageView == nil) {
        _flageImageView = [[UIImageView alloc] init];
        _flageImageView.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
    }
    return _flageImageView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor grayColor];
        
        
    }
    return _titleLabel;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor grayColor];
        
        
    }
    return _timeLabel;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:16];
        _moneyLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        
        
    }
    return _moneyLabel;
}
- (void)setModel:(NOBookChooseModel *)model{
    _titleLabel.text = model.spendTypeStr;
    
    _flageImageView.image = [UIImage imageNamed:[NSString backPicNameWith:[model.spendTypeStr substringToIndex:2]]];
    
    
    NSString *timeStr = @"";
    timeStr = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss: model.spendBegin];
    if (model.spendEnd) {
        NSString *end = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:model.spendEnd];
        timeStr = [NSString stringWithFormat:@"%@~%@",timeStr,end];
    }
    _timeLabel.text = timeStr;
    _moneyLabel.text = [NSString stringWithFormat:@"¥ %lu",model.moneyAmount];
    
    if (model.isChoose) {
        _leftimagView.image = [UIImage imageNamed:@"NewReimbursePopView_Select"];
        
    }else{
        _leftimagView.image = [UIImage imageNamed:@"Buffet_ChooseNor"];
    }
    
}

@end
