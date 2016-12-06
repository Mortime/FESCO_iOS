//
//  PurchaseRecordCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PurchaseRecordCell.h"

#import "NSString+FontAwesome.h"

@interface PurchaseRecordCell ()

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation PurchaseRecordCell

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
    [self addSubview:self.btn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.lineView];
    
}
- (void)layoutSubviews{
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(self.mas_left).offset(20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@30);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.btn.mas_right).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(@150);
        
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(@5);
        make.height.mas_equalTo(@9);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(@1);
        
    }];

}
- (UIButton *)btn{
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor clearColor];
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = 15;
    }
    return _btn;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor grayColor];
        //        _titleLabel.text = @"选择报销单模板";
        
        
    }
    return _titleLabel;
}
- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.backgroundColor = [UIColor clearColor];
        _arrowImageView.image = [UIImage imageNamed:@"arrow_next"];
    }
    return _arrowImageView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
        
    }
    return _lineView;
}
- (void)setModel:(PurchaseRecordModel *)model{
    _titleLabel.text = model.typeName;
    MMLog(@"model.icon] = %@",model.icon);
    
    [_btn setImage:[UIImage imageNamed:[NSString backPicNameWith:model.typeName]] forState:UIControlStateNormal];
    
    
    
//    FAIcon icon = [NSString fontAwesomeEnumForIconIdentifier:model.icon];
//    
//    [_btn setTitle:[NSString fontAwesomeIconStringForEnum:icon] forState:UIControlStateNormal];
//    
//    [_btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}
@end
