//
//  ReimburseApprovalRecordCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/10.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "ReimburseApprovalRecordCell.h"

@interface ReimburseApprovalRecordCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UILabel *moneyLabel;

@end

@implementation ReimburseApprovalRecordCell

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
    [self.bgView addSubview:self.btn];
//    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.timeLabel];
    [self.bgView addSubview:self.moneyLabel];
    
}
- (void)layoutSubviews{
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        
        
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@30);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        
        
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
- (UIButton *)btn{
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
    }
    return _btn;
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
        _timeLabel.font = [UIFont systemFontOfSize:14];
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
- (void)setDic:(NSDictionary *)dic{
    _titleLabel.text = [dic objectForKey:@"spend_Type_Str"];
    
    NSArray *iconArray = [[dic objectForKey:@"icon"] componentsSeparatedByString:@" "];
    FAIcon icon = [NSString fontAwesomeEnumForIconIdentifier:iconArray[1]];
    
    [_btn.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:20]];
    [_btn setTitle:[NSString fontAwesomeIconStringForEnum:icon] forState:UIControlStateNormal];
    
    
    NSString *timeStr = @"";
    timeStr = [NSDate dateFromSSWithDateType:@"yyyy年MM月dd日" ss: [dic objectForKey:@"spend_Begin"]];
    if (![[dic objectForKey:@"spend_End"] isEqual:[NSNull null]]) {
        NSString *end = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:[dic objectForKey:@"spend_End"]];
        timeStr = [NSString stringWithFormat:@"%@~%@",timeStr,end];
    }
    _timeLabel.text = timeStr;
    _moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",[[dic objectForKey:@"money_Amount"] floatValue]];
    
}
@end
