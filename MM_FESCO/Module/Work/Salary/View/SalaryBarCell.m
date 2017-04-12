//
//  SalaryBarCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/4/12.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "SalaryBarCell.h"

@interface SalaryBarCell ()

@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *cycleView;
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic ,strong) UILabel *salaryTypeLabel;
@property (nonatomic ,strong) UILabel *moneyLabel;


@end

@implementation SalaryBarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithHexString:@"1abddc"];
        
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.cycleView];
    [self addSubview:self.topLineView];
    [self addSubview:self.bottomLineView];
    [self addSubview:self.monthLabel];
    [self addSubview:self.salaryTypeLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.flagButton];
    
    
    
}
- (void)layoutSubviews{
    [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.width.mas_equalTo(@5);
        make.height.mas_equalTo(@5);
        
    }];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.cycleView.mas_top);
        make.centerX.mas_equalTo(self.cycleView.mas_centerX);
        make.width.mas_equalTo(@0.5);
        
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cycleView.mas_bottom);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.centerX.mas_equalTo(self.cycleView.mas_centerX);
        make.width.mas_equalTo(@0.5);
        
    }];
    
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cycleView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(@16);
        
    }];
    
    [self.salaryTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(kMMWidth/3));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(@16);
        
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@((kMMWidth * 2)/3));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(@16);
        
    }];
    [self.flagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(@5);
        make.width.mas_equalTo(@9);
        
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
#pragma mark ---- Lazy 加载

- (UIView *)topLineView{
    if (_topLineView == nil) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor whiteColor];
    }
    return _topLineView;
}
- (UIView *)cycleView{
    if (_cycleView == nil) {
        _cycleView = [[UIView alloc] init];
        _cycleView.backgroundColor = [UIColor whiteColor];
        _cycleView.layer.masksToBounds = YES;
        _cycleView.layer.cornerRadius = 2.5;
    }
    return _cycleView;
}

- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomLineView;
}
- (UILabel *)monthLabel{
    if (_monthLabel == nil) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.font = [UIFont systemFontOfSize:11];
        _monthLabel.textColor = [UIColor whiteColor];
        _monthLabel.text = @"6th";
        
    }
    return _monthLabel;
}
- (UILabel *)salaryTypeLabel{
    if (_salaryTypeLabel == nil) {
        _salaryTypeLabel = [[UILabel alloc] init];
        _salaryTypeLabel.font = [UIFont systemFontOfSize:11];
        _salaryTypeLabel.textColor = [UIColor whiteColor];
        _salaryTypeLabel.text = @"工资";
        
    }
    return _salaryTypeLabel;
}
- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:11];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.text = @"¥ 20000";
        
    }
    return _moneyLabel;
}
- (UIButton *)flagButton{
    if (_flagButton == nil) {
        _flagButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _flagButton.backgroundColor = [UIColor clearColor];
        [_flagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_flagButton setBackgroundImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];

}
    return _flagButton;
}
@end
