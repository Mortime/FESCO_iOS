//
//  CheckRecordCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/31.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "CheckRecordCell.h"


@interface CheckRecordCell ()

@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic ,strong) UILabel *addressLabel;

@property (nonatomic ,strong) UILabel *signUpLabel;

@property (nonatomic ,strong) UILabel *signOutLabel;

@property (nonatomic ,strong) UILabel *remarkLabel;

@property (nonatomic, strong) UIView *lineView;



@end

@implementation CheckRecordCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
        
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.addressLabel];
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.signUpLabel];
    [self.bgView addSubview:self.signOutLabel];
    [self.bgView addSubview:self.remarkLabel];
    
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
        
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(12);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.height.mas_equalTo(@14);
        make.right.mas_equalTo(self.bgView.mas_right);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.bgView.mas_left).offset(5);
        make.height.mas_equalTo(@1);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-5);
        
    }];
    [self.signUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(16);
        make.left.mas_equalTo(self.addressLabel.mas_left);
        make.height.mas_equalTo(@12);
        make.right.mas_equalTo(self.addressLabel.mas_right);
        
    }];
    [self.signOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signUpLabel.mas_bottom).offset(22);
        make.left.mas_equalTo(self.addressLabel.mas_left);
        make.height.mas_equalTo(@12);
        make.right.mas_equalTo(self.addressLabel.mas_right);
        
    }];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signOutLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.addressLabel.mas_left);
        make.height.mas_equalTo(@12);
        make.right.mas_equalTo(self.addressLabel.mas_right);
        
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
- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = [UIColor blackColor];
//        _addressLabel.text = @"Fesco";
        
    }
    return _addressLabel;
}
- (UILabel *)signUpLabel{
    if (_signUpLabel == nil) {
        _signUpLabel = [[UILabel alloc] init];
        _signUpLabel.font = [UIFont systemFontOfSize:12];
        _signUpLabel.textColor = [UIColor grayColor];
//        _signUpLabel.text = @"签到时间: 2016.8.30";
        
    }
    return _signUpLabel;
}

- (UILabel *)signOutLabel{
    if (_signOutLabel == nil) {
        _signOutLabel = [[UILabel alloc] init];
        _signOutLabel.font = [UIFont systemFontOfSize:12];
        _signOutLabel.textColor = [UIColor grayColor];
//        _signOutLabel.text = @"签退时间: 2016.8.31";
        
    }
    return _signOutLabel;
}

- (UILabel *)remarkLabel{
    if (_remarkLabel == nil) {
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.font = [UIFont systemFontOfSize:12];
        _remarkLabel.textColor = [UIColor grayColor];
//        _remarkLabel.text = @"备注: 系统添加";
        
    }
    return _remarkLabel;
}

- (UIView *)lineView{
    if (_lineView== nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB_Color(236, 235, 243);
        
        
    }
    return _lineView;
}
- (void)setListModel:(CheckListModel *)listModel{
    
    // 地址
    if (listModel.signAddress) {
        self.addressLabel.text = listModel.signAddress;
    }
    // 签到时间
    if (listModel.beginTime) {
        
        NSString *dateStr = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd HH:mm" ss:listModel.beginTime];
        self.signUpLabel.text = [NSString stringWithFormat:@"签到时间: %@",dateStr];
    }else{
        self.signUpLabel.text = @"暂无";
    }

    // 签退时间
    if (listModel.endTime) {
        
        NSString *dateStr = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd HH:mm" ss:listModel.endTime];
        self.signOutLabel.text = [NSString stringWithFormat:@"签到时间: %@",dateStr];
        
        self.signOutLabel.text = [NSString stringWithFormat:@"签退时间: %@",dateStr];;
    }else{
        self.signOutLabel.text = @"暂无";
    }
    // 备注信息
    if (listModel.memo) {
        self.remarkLabel.text = [NSString stringWithFormat:@"备注: %@",listModel.memo];
    }else{
        self.remarkLabel.text = @"备注:暂无";
    }

    
}

@end
