//
//  FillRecordCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/31.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "FillRecordCell.h"


@interface FillRecordCell ()

@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *applyTimeLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic ,strong) UILabel *signUpLabel;

@property (nonatomic ,strong) UILabel *addressLabel;

@property (nonatomic ,strong)  UILabel *nameLabel;

@property (nonatomic ,strong) UIButton *statusButton;




@end

@implementation FillRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = RGB_Color(236, 235, 243);
        
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    
    [self.bgView addSubview:self.applyTimeLabel];
    
    [self.bgView addSubview:self.lineView];
    
    [self.bgView addSubview:self.signUpLabel];
    
    [self.bgView addSubview:self.addressLabel];
    
    [self.bgView addSubview:self.nameLabel];
    
    [self.bgView addSubview:self.statusButton];
    
    
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(5);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.height.mas_equalTo(@16);
        make.width.mas_equalTo(@40);
        
    }];
    [self.applyTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_top);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-5);
        make.height.mas_equalTo(@14);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.applyTimeLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.bgView.mas_left).offset(5);
        make.height.mas_equalTo(@1);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-5);
        
    }];

    [self.signUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.bgView.mas_left).offset(5);
        make.height.mas_equalTo(@14);
        make.right.mas_equalTo(self.bgView.mas_right);
        
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signUpLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.signUpLabel.mas_left);
        make.height.mas_equalTo(@14);
        make.right.mas_equalTo(self.bgView.mas_right);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.signUpLabel.mas_left);
        make.height.mas_equalTo(@14);
        make.right.mas_equalTo(self.bgView.mas_right);
        
    }];
    [self.statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.bgView.mas_left);
        make.height.mas_equalTo(@30);
        make.right.mas_equalTo(self.bgView.mas_right);
        
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
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
//        _titleLabel.text = @"签退";
        
    }
    return _titleLabel;
}

- (UILabel *)applyTimeLabel{
    if (_applyTimeLabel == nil) {
        _applyTimeLabel = [[UILabel alloc] init];
        _applyTimeLabel.font = [UIFont systemFontOfSize:14];
        _applyTimeLabel.textColor = [UIColor blackColor];
//        _applyTimeLabel.text = @"申请时间: 2016-08-09 12:09";
        
    }
    return _applyTimeLabel;
}

- (UILabel *)signUpLabel{
    if (_signUpLabel == nil) {
        _signUpLabel = [[UILabel alloc] init];
        _signUpLabel.font = [UIFont systemFontOfSize:14];
        _signUpLabel.textColor = [UIColor grayColor];
//        _signUpLabel.text = @"签到时间: 2016.8.30";
        
    }
    return _signUpLabel;
}

- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = [UIColor blackColor];
//        _addressLabel.text = @"签到地点: Fesco";
        
    }
    return _addressLabel;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor grayColor];
//        _nameLabel.text = @"当前审批人: 松哥";
        
    }
    return _nameLabel;
}

- (UIButton *)statusButton{
    if (_statusButton == nil) {
        _statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_statusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_statusButton setTitle:@"同意" forState:UIControlStateNormal];
//        _statusButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        
    }
    return _statusButton;
}

- (UIView *)lineView{
    if (_lineView== nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB_Color(236, 235, 243);
        
        
    }
    return _lineView;
}
- (void)setListModel:(FillListModel *)listModel{
    
    // 补签类型
    if (listModel.checkType == 1) {
        // 签到
        _titleLabel.text = @"签到";
    }else if (listModel.checkType == 2){
        // 签退
        _titleLabel.text = @"签退";
    }else if (listModel.checkType == 3){
        // 外勤
        _titleLabel.text = @"外勤";
    }
    
    // 申请时间  yyyy-MM-dd HH:mm
    if (listModel.applyDate) {
        NSString *dateStr = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd HH:dd" ss:listModel.applyDate];
        _applyTimeLabel.text = [NSString stringWithFormat:@"申请时间: %@",dateStr];
    }
    // 签到时间
    if (listModel.checkTime) {
        NSString *dateStr = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd HH:dd" ss:listModel.checkTime];
        _signUpLabel.text = [NSString stringWithFormat:@"签到时间: %@",dateStr];
    }
    // 签到地点
    if (listModel.custAddress) {
        _addressLabel.text = [NSString stringWithFormat:@"签到地点: %@",listModel.custAddress];
    }
    // 当前审批人
    if (listModel.applePeople) {
        _nameLabel.text = [NSString stringWithFormat:@"当前审批人: %@",listModel.applePeople];
    }
    
    // 审批状态
    
    if (listModel.applyResult == 0) {
        //  未通过
        [_statusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_statusButton setTitle:@"未同意" forState:UIControlStateNormal];
        _statusButton.backgroundColor = [UIColor grayColor];
        
        
    }
    if (listModel.applyResult == 1) {
        //  通过
        [_statusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_statusButton setTitle:@"已同意" forState:UIControlStateNormal];
        _statusButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;

        
    }
    if (listModel.applyResult == 2) {
        //  审批中
        [_statusButton setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        [_statusButton setTitle:@"审批中..." forState:UIControlStateNormal];
        _statusButton.backgroundColor = MM_MAIN_BACKGROUND_COLOR;
        
        
    }

    
}
@end
