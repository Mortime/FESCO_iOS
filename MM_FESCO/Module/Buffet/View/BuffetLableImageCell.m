//
//  BuffetLableImageCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "BuffetLableImageCell.h"

#define showOffX 8

@interface BuffetLableImageCell ()

@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic, strong) UIView *flagView;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *flagImageView;

@property (nonatomic, strong) UIView *labelBgView;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *bottomLable;

@end

@implementation BuffetLableImageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.flagView];
    [self.bgView addSubview:self.whiteView];
    [self.whiteView addSubview:self.flagImageView];
    [self.whiteView addSubview:self.labelBgView];
    [self.labelBgView addSubview:self.topLabel];
    [self.labelBgView addSubview:self.bottomLable];
    
    
}
- (void)layoutSubviews{
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        
    }];
    
    [self.flagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(showOffX);
        make.left.mas_equalTo(self.bgView.mas_left).offset(showOffX);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(0);
        
    }];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-showOffX);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-showOffX);
        
    }];
    
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.whiteView.mas_right).offset(-40);
        make.centerY.mas_equalTo(self.whiteView.mas_centerY);
        make.width.mas_equalTo(@70);
        make.height.mas_equalTo(@70);
        
    }];
    [self.labelBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.flagImageView.mas_left);
        make.left.mas_equalTo(self.whiteView.mas_left);
        make.centerY.mas_equalTo(self.whiteView.mas_centerY);
        make.height.mas_equalTo(@45);
        
    }];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.labelBgView.mas_top);
        make.centerX.mas_equalTo(self.labelBgView.mas_centerX);
        make.height.mas_equalTo(@17);
        
    }];
    [self.bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.topLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.labelBgView.mas_centerX);
        make.height.mas_equalTo(@15);
        
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
        _bgView.backgroundColor  =  [UIColor clearColor];
        
    }
    return _bgView;
}
- (UIView *)flagView{
    if (_flagView == nil) {
        _flagView = [[UIView alloc] init];
        _flagView.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        _flagView.alpha = 0.2;
        _flagView.layer.masksToBounds = YES;
        _flagView.layer.cornerRadius = 5;
        
    }
    return _flagView;
}
- (UIView *)whiteView{
    if (_whiteView == nil) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.borderWidth = 0.5;
        _whiteView.layer.borderColor = MM_MAIN_FONTCOLOR_BLUE.CGColor;
        _whiteView.layer.masksToBounds = YES;
        _whiteView.layer.cornerRadius = 5;
        
    }
    return _whiteView;
}

- (UIImageView *)flagImageView{
    if (_flagImageView == nil) {
        _flagImageView = [[UIImageView alloc] init];
        _flagImageView.backgroundColor = [UIColor clearColor];
        _flagImageView.layer.masksToBounds = YES;
        _flagImageView.layer.cornerRadius = 35;
        
        
    }
    return _flagImageView;
}
- (UIView *)labelBgView{
    if (_labelBgView == nil) {
        _labelBgView = [[UIView alloc] init];
        _labelBgView.backgroundColor = [UIColor clearColor];
    }
    return _labelBgView;
}


- (UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.font = [UIFont systemFontOfSize:16];
        _topLabel.textColor = [UIColor blackColor];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _topLabel;
}

- (UILabel *)bottomLable{
    if (_bottomLable == nil) {
        _bottomLable = [[UILabel alloc] init];
        _bottomLable.font = [UIFont systemFontOfSize:14];
        _bottomLable.textColor = [UIColor grayColor];
        _bottomLable.textAlignment = NSTextAlignmentCenter;
        
    }
    return _bottomLable;
}
- (void)setTopStr:(NSString *)topStr{
    _topLabel.text = topStr;
    
}
- (void)setBottomStr:(NSString *)bottomStr{
    _bottomLable.text = bottomStr;
}
- (void)setImgStr:(NSString *)imgStr{
    _flagImageView.image = [UIImage imageNamed:imgStr];
}
@end
