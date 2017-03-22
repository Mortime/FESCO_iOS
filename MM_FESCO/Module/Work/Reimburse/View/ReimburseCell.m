//
//  ReimburseCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/7.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ReimburseCell.h"

@interface ReimburseCell ()

@property (nonatomic, strong) UIImageView *flageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *detailLabel;

@property (nonatomic, strong) UIView *statusView;

@property (nonatomic ,strong) UILabel *moneyLabel;



@end

@implementation ReimburseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.flageView];

    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    
    [self addSubview:self.moneyLabel];
    [self addSubview:self.statusView];
    
    
    
}
- (void)layoutSubviews{
    [self.flageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(@16);
        make.height.mas_equalTo(@16);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.flageView.mas_right).offset(10);
        make.height.mas_equalTo(@13);
        
    }];

    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.flageView.mas_right).offset(10);
        make.height.mas_equalTo(@13);
        
    }];

    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(@16);
        
    }];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.moneyLabel.mas_left).offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(@8);
        make.width.mas_equalTo(@8);
        
    }];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
#pragma mark ---- Lazy 加载

- (UIImageView *)flageView{
    if (_flageView == nil) {
        _flageView = [[UIImageView alloc] init];
        _flageView.backgroundColor = [UIColor clearColor];
    }
    return _flageView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor grayColor];
        
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textColor = [UIColor grayColor];
        
    }
    return _detailLabel;
}
- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:14];
        _moneyLabel.textColor = [UIColor grayColor];

    }
    return _moneyLabel;
}
- (UIView *)statusView{
    if (_statusView == nil) {
        _statusView = [[UIView alloc] init];
        _statusView.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        _statusView.layer.masksToBounds = YES;
        _statusView.layer.cornerRadius = 4;
        _statusView.hidden = YES;
    }
    return _statusView;
}
- (void)setModel:(ReimburseModel *)model{
    //报销单状态  // 0待提交，1待审批，2待支付，3未通过，4已支付
    _moneyLabel.textColor  = [UIColor grayColor];
    _statusView.hidden = YES;

    NSString *status = @"";
    if (model.statusReimburse == 0) {
        status = @"待提交";
        
    }
    if (model.statusReimburse == 1) {
        status = @"待审批";
        _moneyLabel.textColor  = MM_MAIN_FONTCOLOR_BLUE;
        _statusView.hidden = NO;
    }
    if (model.statusReimburse == 2) {
        status = @"待支付";
    }
    if (model.statusReimburse == 3) {
        status = @"未通过";
    }
    if (model.statusReimburse == 4) {
        status = @"已支付";
    }
    _flageView.image = [UIImage imageNamed:[NSString backPicNameWith:model.typeStr]];
    _detailLabel.text = [NSString stringWithFormat:@"%@ | %@",[NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:model.applyDate],[NSString stringWithFormat:@"¥ %.2f",model.moneySum]];
    _moneyLabel.text = status;
    _titleLabel.text = model.title;
    
    
}
@end
