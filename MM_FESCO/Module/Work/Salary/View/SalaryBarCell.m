//
//  SalaryBarCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/4/12.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "SalaryBarCell.h"

@interface SalaryBarCell ()
@property (nonatomic ,strong) UILabel *salaryTypeLabel;
@property (nonatomic ,strong) UILabel *moneyLabel;
@property (nonatomic ,strong) UILabel *addLabel;

@end

@implementation SalaryBarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.salaryTypeLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.addLabel];
    
    
    
}
- (void)layoutSubviews{
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
    [self.addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(@16);
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
        _salaryTypeLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _salaryTypeLabel.text = @"工资";
        
    }
    return _salaryTypeLabel;
}
- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:11];
        _moneyLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _moneyLabel.text = @"¥ 20000";
        
    }
    return _moneyLabel;
}
- (UILabel *)addLabel{
    if (_addLabel == nil) {
        _addLabel = [[UILabel alloc] init];
        _addLabel.font = [UIFont systemFontOfSize:14];
        _addLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _addLabel.text = @"+";
        _addLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _addLabel;
}

@end
