//
//  ReimburseApprovalCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/4.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "ReimburseApprovalCell.h"

@interface ReimburseApprovalCell ()

@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic ,strong) UILabel *name;

@property (nonatomic ,strong) UILabel *applyTime;

@property (nonatomic ,strong) UILabel *startTime;

@property (nonatomic ,strong) UILabel *endTime;


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
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.iconView];
    [self.bgView addSubview:self.name];
    [self.bgView addSubview:self.applyTime];
    [self.bgView addSubview:self.startTime];
    [self.bgView addSubview:self.endTime];
    
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.height.mas_equalTo(@1);
        
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(15);
        make.left.mas_equalTo(self.bgView.mas_left).offset(20);
        make.height.mas_equalTo(@43);
        make.width.mas_equalTo(@43);
        
        
    }];
    
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(20);
        make.left.mas_equalTo(self.iconView.mas_right).offset(10);
        make.height.mas_equalTo(@14);
        make.right.mas_equalTo(self.bgView.mas_right);
        
    }];
    
    [self.applyTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.name.mas_bottom).offset(10);
        make.left.mas_equalTo(self.name.mas_left);
        make.height.mas_equalTo(@14);
        make.right.mas_equalTo(self.name.mas_right);
        
    }];
    [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(15);
        make.left.mas_equalTo(self.iconView.mas_left);
        make.height.mas_equalTo(@12);
        make.right.mas_equalTo(self.name.mas_right);
        
    }];
    [self.endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startTime.mas_bottom).offset(15);
        make.left.mas_equalTo(self.startTime.mas_left);
        make.height.mas_equalTo(@12);
        make.right.mas_equalTo(self.startTime.mas_right);
        
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
- (UIView *)lineView{
    if (_lineView== nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB_Color(236, 235, 243);
        
        
    }
    return _lineView;
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
        _name.font = [UIFont systemFontOfSize:14];
        _name.textColor = [UIColor blackColor];
        _name.text = @"Paco Xiao";
        
    }
    return _name;
}
- (UILabel *)applyTime{
    if (_applyTime == nil) {
        _applyTime = [[UILabel alloc] init];
        _applyTime.font = [UIFont systemFontOfSize:12];
        _applyTime.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _applyTime.text = @"申请时间: 2016-8-30 20:34";
        
    }
    return _applyTime;
}

- (UILabel *)startTime{
    if (_startTime == nil) {
        _startTime = [[UILabel alloc] init];
        _startTime.font = [UIFont systemFontOfSize:12];
        _startTime.textColor = [UIColor grayColor];
        _startTime.text = @"开始时间: 2016-8-31 20:56";
        
    }
    return _startTime;
}

- (UILabel *)endTime{
    if (_endTime == nil) {
        _endTime = [[UILabel alloc] init];
        _endTime.font = [UIFont systemFontOfSize:12];
        _endTime.textColor = [UIColor grayColor];
        _endTime.text = @"结束时间: 2016-8-31 20:56";
        
    }
    return _endTime;
}
- (void)setModel:(ReimburseApprovalListModel *)model{
    _name.text = model.typeStr;
    _applyTime.text = [NSString stringWithFormat:@"报销时间: %@",[NSDate dateFromSSWithDateType:@"yyyy-MM-dd HH:mm" ss:model.applyDate]];
    
    _startTime.text = @"标题: 暂无";
    if (model.title != nil) {
        _startTime.text = [NSString stringWithFormat:@"标题: %@",model.title];
    }
    _endTime.text = @"描述: 暂无";
    if (model.memo != nil) {
        _endTime.text = [NSString stringWithFormat:@"描述: %@",model.memo];
    }
    

    
}

@end
