//
//  ewPurchaseSubBookCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewPurchaseSubBookCell.h"


@interface NewPurchaseSubBookCell ()<NumberAddOffViewDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLabel;





@end

@implementation NewPurchaseSubBookCell

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
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.addOffView];
    
    
}
- (void)layoutSubviews{
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom);
        
        
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        make.width.mas_equalTo(@60);
        
    }];
    [self.addOffView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        make.right.mas_equalTo(self.bgView.mas_right);
        
    }];
    
}
#pragma mark ---  NumberAddOffViewDelegate
- (void)numberAddOffViewDelegateWihtBillNumber:(NSString *)billNumber{
    if ([_delegate respondsToSelector:@selector(newPurchaseSubBookCellDelegateWithBillNumber:)]) {
        [_delegate newPurchaseSubBookCellDelegateWithBillNumber:billNumber];
    }
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.text = @"发票";
    }
    return _titleLabel;
}
- (NumberAddOffView *)addOffView{
    if (_addOffView == nil) {
        _addOffView = [[NumberAddOffView alloc] init];
        _addOffView.delegate = self;
    }
    return _addOffView;
}

@end
