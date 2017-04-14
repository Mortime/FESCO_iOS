//
//  SalaryBarPopCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/4/14.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "SalaryBarPopCell.h"

@interface SalaryBarPopCell ()
@property (nonatomic ,strong) UILabel *salaryTypeLabel;
@property (nonatomic ,strong) UILabel *moneyLabel;

@end

@implementation SalaryBarPopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.salaryTypeLabel];
    [self addSubview:self.moneyLabel];
    
    
    
}
- (void)layoutSubviews{
    [self.salaryTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(20));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(@16);
        
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@((kMMWidth)/2));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(@16);
        
    }];
    _salaryTypeLabel.text = _salaryTypeStr;
    _moneyLabel.text = _moneyStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
#pragma mark ---- Lazy 加载
- (UILabel *)salaryTypeLabel{
    if (_salaryTypeLabel == nil) {
        _salaryTypeLabel = [[UILabel alloc] init];
        _salaryTypeLabel.font = [UIFont systemFontOfSize:11];
        _salaryTypeLabel.textColor = [UIColor whiteColor];
//        _salaryTypeLabel.text = @"工资";
        
    }
    return _salaryTypeLabel;
}
- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:11];
        _moneyLabel.textColor = [UIColor whiteColor];
//        _moneyLabel.text = @"¥ 20000";
        
    }
    return _moneyLabel;
}

@end
