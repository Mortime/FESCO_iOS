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

@property (nonatomic ,strong) UILabel *detailLabel;

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

    
    [self addSubview:self.detailLabel];
    
    [self addSubview:self.moneyLabel];
    
    
    
}
- (void)layoutSubviews{
    [self.flageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(@16);
        make.height.mas_equalTo(@16);
        
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.flageView.mas_centerY);
        make.left.mas_equalTo(self.flageView.mas_right).offset(10);
        make.height.mas_equalTo(@13);
        
    }];

    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(@16);
        
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
- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:14];
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
- (void)setModel:(ReimburseModel *)model{
    //报销单状态  // 0待提交，1待审批，2待支付，3未通过，4已支付
    _moneyLabel.textColor  = [UIColor grayColor];
    

    NSString *status = @"";
    if (model.statusReimburse == 0) {
        status = @"待提交";
        
    }
    if (model.statusReimburse == 1) {
        status = @"待审批";
        _moneyLabel.textColor  = MM_MAIN_FONTCOLOR_BLUE;
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
    _detailLabel.text = [NSString stringWithFormat:@"%@ | %@",model.typeStr,[NSString stringWithFormat:@"¥ %.2f",model.moneySum]];
    _moneyLabel.text = status;
    
    
}
@end
