//
//  NewReimbursePopViewCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/8.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewReimbursePopViewCell.h"

@interface NewReimbursePopViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *leftimagView;

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation NewReimbursePopViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
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
    [self addSubview:self.leftimagView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.imgView];
}
- (void)layoutSubviews{
    
    [self.leftimagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.width.mas_equalTo(@11);
        make.height.mas_equalTo(@11);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.left.mas_equalTo(self.leftimagView.mas_right).offset(10);
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftimagView.mas_left);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(@1.5);
    }];
}
- (UIImageView *)leftimagView{
    if (_leftimagView == nil) {
        _leftimagView = [[UIImageView alloc] init];
        _leftimagView.image = [UIImage imageNamed:@"NewReimbursePopView_Normal"];
        
    }
    return _leftimagView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor whiteColor];
//        _titleLabel.text = @"选择报销单模板";
        
        
    }
    return _titleLabel;
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"NewReimbursePopView_Black"];
        
    }
    return _imgView;
}
- (void)setTitleStr:(NSString *)titleStr{
    _titleLabel.text = titleStr;
}
@end
