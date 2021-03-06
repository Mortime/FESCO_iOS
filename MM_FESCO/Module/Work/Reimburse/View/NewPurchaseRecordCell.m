//
//  NewPurchaseRecordCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/18.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewPurchaseRecordCell.h"

@interface NewPurchaseRecordCell ()

@property (nonatomic, strong) UIView *bgView;



@property (nonatomic, strong) UIButton *btn;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@property (nonatomic ,strong) UILabel *moneyLabel;

@end

@implementation NewPurchaseRecordCell

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
    [self addSubview:self.deleBtn];
    [self.bgView addSubview:self.btn];
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

    [self.deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@20);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(20);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@30);
        
    }];

    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.btn.mas_top);
        make.left.mas_equalTo(self.btn.mas_right).offset(10);
        make.right.mas_equalTo(self.bgView.mas_right);
        make.height.mas_equalTo(@14);
        
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
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
#pragma mark --- Action
- (void)didDeleRecord{
    if ([_delegate respondsToSelector:@selector(newPurchaseRecordCellDelegateWithTag:sectionTag:)]) {
        [_delegate newPurchaseRecordCellDelegateWithTag:_indexTag sectionTag:_sectionTag];
    }
}

#pragma mark ---- Lazy 加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UIButton *)deleBtn{
    if (_deleBtn == nil) {
        _deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleBtn.backgroundColor = [UIColor clearColor];
        [_deleBtn setImage:[UIImage imageNamed:@"NewPurchaseRecordCell_Dele"] forState:UIControlStateNormal];
        [_deleBtn addTarget:self action:@selector(didDeleRecord) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _deleBtn;
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

- (void)setModel:(EditMessageModel *)model{
    if (model.spendType) {
        _titleLabel.text = model.spendType;
    }else{
        _titleLabel.text = @"未知";
    }
    
    // 设置图标
    [self setBtnIconWithIconStr:model.icon];
    
    NSString *timeStr = @"";
    timeStr = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss: model.spendBegin];
    if (model.spendEnd) {
        NSString *end = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:model.spendEnd];
        timeStr = [NSString stringWithFormat:@"%@~%@",timeStr,end];
    }
    _timeLabel.text = timeStr;
    _moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",model.moneyAmount];
}
- (void)setDic:(NSDictionary *)dic{
    
    _titleLabel.text = [dic objectForKey:@"typePurchaseStr"];
    
    // 设置图标
    [self setBtnIconWithIconStr:[dic objectForKey:@"icon"]];
    
    NSString *timeStr = @"";
    timeStr = [dic objectForKey:@"spendBegin"];
    if ([dic objectForKey:@"spendEnd"]) {
        NSString *end = [dic objectForKey:@"spendEnd"];
        timeStr = [NSString stringWithFormat:@"%@~%@",timeStr,end];
    }
    _timeLabel.text = timeStr;
    _moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",[[dic objectForKey:@"moneyAmount"] floatValue]];

    
}
- (void)setChooseModel:(NOBookChooseModel *)chooseModel{
    if (chooseModel.spendTypeStr) {
        _titleLabel.text = chooseModel.spendTypeStr;
    }else{
        _titleLabel.text = @"未知";
    }
    
    // 设置图标
   [self setBtnIconWithIconStr:chooseModel.icon];
    
    NSString *timeStr = @"";
    timeStr = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss: chooseModel.spendBegin];
    if (chooseModel.spendEnd) {
        NSString *end = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:chooseModel.spendEnd];
        timeStr = [NSString stringWithFormat:@"%@~%@",timeStr,end];
    }
    _timeLabel.text = timeStr;
    _moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",chooseModel.moneyAmount];
}
- (void)setBtnIconWithIconStr:(NSString *)iconStr{
    NSArray *iconArray = [iconStr componentsSeparatedByString:@" "];
    FAIcon icon = [NSString fontAwesomeEnumForIconIdentifier:iconArray[1]];
    [_btn.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:20]];
    [_btn setTitle:[NSString fontAwesomeIconStringForEnum:icon] forState:UIControlStateNormal];
}
@end
