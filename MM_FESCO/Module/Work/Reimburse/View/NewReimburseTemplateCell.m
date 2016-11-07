//
//  NewReimburseTemplateCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/7.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewReimburseTemplateCell.h"

@interface NewReimburseTemplateCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *detailLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;



@end

@implementation NewReimburseTemplateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.bgView];

    [self.bgView addSubview:self.titleLabel];
    
    [self.bgView addSubview:self.detailLabel];
    
    [self.bgView addSubview:self.arrowImageView];
    
    
    
    
}
- (void)layoutSubviews{
    
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
        
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        make.width.mas_offset(@150);
    
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
    
        
    }];

    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@5);
        make.height.mas_equalTo(@9);
        
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
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor grayColor];
    
        
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = [UIColor blackColor];
    
        
    }
    return _detailLabel;
}

- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.backgroundColor = [UIColor clearColor];
        _arrowImageView.image = [UIImage imageNamed:@"arrow_next"];
    }
    return _arrowImageView;
}
- (void)setTitleStr:(NSString *)titleStr{
    _titleLabel.text = titleStr;
}
- (void)setDetailStr:(NSString *)detailStr{
    _detailLabel.text = detailStr;
}
@end
