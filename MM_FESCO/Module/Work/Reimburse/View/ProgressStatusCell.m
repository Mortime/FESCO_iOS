//
//  ProgressStatusCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/29.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ProgressStatusCell.h"

@interface ProgressStatusCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *cycleView;

@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation ProgressStatusCell

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
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.cycleView];
    [self.bgView addSubview:self.statusLabel];
    
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.bgView.mas_left).offset(40);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        make.width.mas_equalTo(@1);
       
        
    }];
    
    [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.lineView.mas_centerX);
        make.centerY.mas_equalTo(self.lineView.mas_centerY);
        make.width.mas_equalTo(@5);
        make.height.mas_equalTo(@5);
        
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView.mas_left).offset(20);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.right.mas_equalTo(self.bgView.mas_right);
        make.height.mas_equalTo(@15);
        
    }];

    
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        
    }
    return _bgView;
}


- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
        
    }
    return _lineView;
}

- (UIView *)cycleView{
    if (_cycleView == nil) {
        _cycleView = [[UIView alloc] init];
        _cycleView.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        _cycleView.layer.masksToBounds = YES;
        _cycleView.layer.cornerRadius = 2.5;
        
    }
    return _cycleView;
}

- (UILabel *)statusLabel{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:14];
        _statusLabel.textColor = [UIColor blackColor];
        
    }
    return _statusLabel;
}
- (void)setShowModel:(ProgressShowModel *)showModel{
    // 0待提交，1待审批，2待支付，3未通过，4已支付
    _statusLabel.text = [NSString stringWithFormat:@"%@ %@",showModel.approvalManStr,showModel.isPassStr];
    if (_memo) {
        _statusLabel.text = [NSString stringWithFormat:@"%@ %@ %@",showModel.approvalManStr,showModel.isPassStr,showModel.memo];
    }
}

@end

