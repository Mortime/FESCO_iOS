//
//  ReimburseApprovalCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/4.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "ReimburseApprovalCell.h"


#define kLabelH  15
@interface ReimburseApprovalCell ()

@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *flagView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *applyTime;

@property (nonatomic ,strong) UILabel *biaotiLabel;

@property (nonatomic ,strong) UILabel *memoLabel;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic ,strong) UILabel *name;

@property (nonatomic, strong) UILabel *moneyLabel;


@end

@implementation ReimburseApprovalCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.flagView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.applyTime];
    [self.bgView addSubview:self.biaotiLabel];
    [self.bgView addSubview:self.memoLabel];
    [self.bgView addSubview:self.iconView];
    [self.bgView addSubview:self.name];
    [self.bgView addSubview:self.moneyLabel];
    
    
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
        
    }];
    
    [self.flagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(20);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.width.mas_equalTo(@16);
        make.height.mas_equalTo(@16);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.flagView.mas_centerY);
        make.left.mas_equalTo(self.flagView.mas_right).offset(10);
        make.height.mas_equalTo(@kLabelH);
        
    }];
    
    [self.applyTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.flagView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.height.mas_equalTo(@kLabelH);
        
    }];
    
    [self.biaotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.applyTime.mas_bottom).offset(10);
        make.left.mas_equalTo(self.applyTime.mas_left);
        make.height.mas_equalTo(@kLabelH);
        
        
    }];
    [self.memoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.biaotiLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.applyTime.mas_left);
        make.height.mas_equalTo(@kLabelH);
        
        
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(20);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-20);
        make.width.mas_equalTo(@43);
        make.height.mas_equalTo(@43);
        
    }];
    
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.iconView.mas_centerX);
        make.height.mas_equalTo(@17);
        
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.name.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.name.mas_centerX);
        make.height.mas_equalTo(@17);
        make.width.mas_equalTo(@100);
        
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
#pragma mark ---- Lazy 加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor  =  [UIColor whiteColor];
        
    }
    return _bgView;
}
- (UIImageView *)flagView{
    if (_flagView == nil) {
        _flagView = [[UIImageView alloc] init];
    }
    return _flagView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        
    }
    return _titleLabel;
}

- (UILabel *)applyTime{
    if (_applyTime == nil) {
        _applyTime = [[UILabel alloc] init];
        _applyTime.font = [UIFont systemFontOfSize:14];
        _applyTime.textColor = [UIColor blackColor];
        _applyTime.text = @"申请时间: 2016-8-30 20:34";
        
    }
    return _applyTime;
}
- (UILabel *)biaotiLabel{
    if (_biaotiLabel == nil) {
        _biaotiLabel = [[UILabel alloc] init];
        _biaotiLabel.font = [UIFont systemFontOfSize:14];
        _biaotiLabel.textColor = [UIColor grayColor];
        
    }
    return _biaotiLabel;
}
- (UILabel *)memoLabel{
    if (_memoLabel == nil) {
        _memoLabel = [[UILabel alloc] init];
        _memoLabel.font = [UIFont systemFontOfSize:14];
        _memoLabel.textColor = [UIColor grayColor];
        
    }
    return _memoLabel;
}



- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image  = [UIImage imageNamed:@"People_placehode"];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 21.5;
    }
    return _iconView;
}

- (UILabel *)name{
    if (_name == nil) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:16];
        _name.textColor = [UIColor blackColor];
        _name.text = @"Paco Xiao";
        
    }
    return _name;
}
- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:14];
        _moneyLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _moneyLabel;
}

- (void)setModel:(ReimburseApprovalListModel *)model{
    _flagView.image = [UIImage imageNamed:[NSString backPicNameWith:model.typeStr]];
    
    _titleLabel.text = model.typeStr;
    _applyTime.text = [NSString stringWithFormat:@"报销时间: %@",[NSDate dateFromSSWithDateType:@"yyyy-MM-dd HH:mm" ss:model.applyDate]];
    
    _biaotiLabel.text = @"标题: 暂无";
    if (model.title != nil) {
        _biaotiLabel.text = [NSString stringWithFormat:@"标题: %@",model.title];
    }
    _memoLabel.text = @"描述: 暂无";
    if (model.memo != nil) {
        _memoLabel.text = [NSString stringWithFormat:@"描述: %@",model.memo];
    }

    _moneyLabel.text = [NSString stringWithFormat:@"￥ %.2f",model.moneySum];
    
    _name.text = @"暂无";
    if (model.empName != nil) {
        _name.text = model.empName;
    }
    
    
}

@end
