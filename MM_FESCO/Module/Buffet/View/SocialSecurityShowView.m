//
//  SocialSecurityShowView.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/23.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "SocialSecurityShowView.h"

#define showOffX 8

#define MarginW 10

#define kBttonW   (kMMWidth - showOffX - MarginW) / 2

#define kBttonW2   (kMMWidth - showOffX - MarginW - 1) / 2

@interface SocialSecurityShowView ()

@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic, strong) UIView *flagBgView;

@property (nonatomic, strong) UIView *whiteBgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *forkButton;

@property (nonatomic, strong) UIView *mightBgView;

@property (nonatomic, strong) UIView *leftBgView;
@property (nonatomic, strong) UIImageView *leftFlageView;
@property (nonatomic, strong) UILabel *leftTitleLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *rightBgView;
@property (nonatomic, strong) UIImageView *rightFlageView;
@property (nonatomic, strong) UILabel *rightTitleLabel;



@property (nonatomic, strong) UIView *bottomBgView;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIView *VLineView;
@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, assign) NSInteger tapViewTag;

@end

@implementation SocialSecurityShowView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        _tapViewTag = 9004;
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self addSubview:self.flagBgView];
    [self addSubview:self.whiteBgView];
    [self.whiteBgView addSubview:self.titleLabel];
    [self addSubview:self.forkButton];
    
    // might
    [self.whiteBgView addSubview:self.mightBgView];
    
    [self.mightBgView addSubview:self.leftBgView];
    [self.leftBgView addSubview:self.leftFlageView];
    [self.leftBgView addSubview:self.leftTitleLabel];
    
    [self.mightBgView addSubview:self.rightBgView];
    [self.leftBgView addSubview:self.rightFlageView];
    [self.leftBgView addSubview:self.rightTitleLabel];
    
    [self.mightBgView addSubview:self.lineView];
    
    // bottom
    [self.whiteBgView addSubview:self.bottomBgView];
    [self.bottomBgView addSubview:self.cancleButton];
    [self.bottomBgView addSubview:self.VLineView];
    [self.bottomBgView addSubview:self.commitButton];
    
    
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
        
    }];
    
    [self.flagBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(showOffX + MarginW);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-MarginW);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.height.mas_equalTo(@160);
        
    }];
    
    [self.whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(MarginW);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-MarginW-showOffX);
        make.centerY.mas_equalTo(self.bgView.mas_centerY).offset(-10);
        make.height.mas_equalTo(@160);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.whiteBgView.mas_top).offset(20);
        make.left.mas_equalTo(self.whiteBgView.mas_left).offset(20);
        make.right.mas_equalTo(self.whiteBgView.mas_right);
        make.height.mas_equalTo(@16);
        
    }];
    [self.forkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.whiteBgView.mas_top).offset(-10);
        make.right.mas_equalTo(self.whiteBgView.mas_right).offset(10);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@30);
        
    }];
    
    [self.mightBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.left.mas_equalTo(self.whiteBgView.mas_left);
        make.right.mas_equalTo(self.whiteBgView.mas_right);
        make.height.mas_equalTo(@80);
        
    }];
    
    [self.leftBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mightBgView.mas_top);
        make.left.mas_equalTo(self.mightBgView.mas_left);
        make.bottom.mas_equalTo(self.mightBgView.mas_bottom).offset(-2);
        make.width.mas_equalTo(@(kBttonW));
        
    }];

    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftBgView.mas_top);
        make.right.mas_equalTo(self.leftBgView.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.leftBgView.mas_bottom);
        make.width.mas_equalTo(@16);
        
    }];
    [self.leftFlageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.leftTitleLabel.mas_left).offset(-15);
        make.centerY.mas_equalTo(self.leftBgView.mas_centerY);
        make.width.mas_equalTo(@16);
        make.height.mas_equalTo(@16);
        
    }];
    
    [self.rightBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mightBgView.mas_top);
        make.left.mas_equalTo(self.leftBgView.mas_right);
        make.bottom.mas_equalTo(self.mightBgView.mas_bottom).offset(-2);
        make.width.mas_equalTo(@(kBttonW));
        
    }];
    
    [self.rightFlageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rightBgView.mas_left).offset(15);
        make.centerY.mas_equalTo(self.rightBgView.mas_centerY);
        make.width.mas_equalTo(@16);
        make.height.mas_equalTo(@16);
        
    }];
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rightBgView.mas_top);
        make.left.mas_equalTo(self.rightFlageView.mas_right).offset(15);
        make.bottom.mas_equalTo(self.rightBgView.mas_bottom);
        make.width.mas_equalTo(@16);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftBgView.mas_bottom);
        make.left.mas_equalTo(self.mightBgView.mas_left).offset(25);
        make.right.mas_equalTo(self.mightBgView.mas_right).offset(-25);
        make.height.mas_equalTo(@1);
        
    }];
    
    [self.bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mightBgView.mas_bottom);
        make.left.mas_equalTo(self.whiteBgView.mas_left);
        make.right.mas_equalTo(self.whiteBgView.mas_right);
        make.bottom.mas_equalTo(self.whiteBgView.mas_bottom);
        
    }];
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomBgView.mas_top);
        make.left.mas_equalTo(self.bottomBgView.mas_left);
        make.bottom.mas_equalTo(self.bottomBgView.mas_bottom);
        make.width.mas_equalTo(@(kBttonW2));
        
    }];
    [self.VLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomBgView.mas_top).offset(15);
        make.left.mas_equalTo(self.cancleButton.mas_right);
        make.bottom.mas_equalTo(self.bottomBgView.mas_bottom).offset(-15);
        make.width.mas_equalTo(@1);
        
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomBgView.mas_top);
        make.left.mas_equalTo(self.VLineView.mas_right);
        make.bottom.mas_equalTo(self.bottomBgView.mas_bottom);
        make.width.mas_equalTo(@(kBttonW2));
        
    }];


    




}
#pragma mark --- Action
- (void)didSignButon:(UIButton *)sender{
    // sender.tag == 9000 取消
    
    
    //  sender.tag == 9001 确定
    
    // sender.tag == 9003  ❎
    if ([_delegate respondsToSelector:@selector(socialSecurityShowViewDelegateWithMessageTag:viewTag:)]) {
        [_delegate socialSecurityShowViewDelegateWithMessageTag:_tapViewTag viewTag:sender.tag];
    }
    
}
- (void)tapView:(UIGestureRecognizer *)ges{

    _leftFlageView.image = [UIImage imageNamed:@"Buffet_ChooseNor"];
    _rightFlageView.image = [UIImage imageNamed:@"Buffet_ChooseNor"];
    UIView *view = (UIView *)ges.view;
    if (view.tag == 9004) {
        _leftFlageView.image = [UIImage imageNamed:@"NewReimbursePopView_Select"];
    }
    if (view.tag == 9005) {
        _rightFlageView.image = [UIImage imageNamed:@"NewReimbursePopView_Select"];
    }
 _tapViewTag = view.tag;
    
    
    
}
#pragma mark ---- Lazy 加载

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor  =  [UIColor whiteColor];
        _bgView.alpha = 0.8;
    }
    return _bgView;
}
- (UIView *)flagBgView{
    if (_flagBgView == nil) {
        _flagBgView = [[UIView alloc] init];
        _flagBgView.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        _flagBgView.alpha = 0.2;
        _flagBgView.layer.masksToBounds = YES;
        _flagBgView.layer.cornerRadius = 5;
        
    }
    return _flagBgView;
}
- (UIView *)whiteBgView{
    if (_whiteBgView == nil) {
        _whiteBgView = [[UIView alloc] init];
        _whiteBgView.backgroundColor = [UIColor whiteColor];
        _whiteBgView.layer.borderWidth = 0.5;
        _whiteBgView.layer.borderColor = MM_MAIN_FONTCOLOR_BLUE.CGColor;
        _whiteBgView.layer.masksToBounds = YES;
        _whiteBgView.layer.cornerRadius = 5;
        
    }
    return _whiteBgView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.text = @"是否参加过社保";
    }
    return _titleLabel;
}
- (UIButton *)forkButton {
    
    if (_forkButton == nil) {
        _forkButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forkButton setBackgroundImage:[UIImage imageNamed:@"Buffer_Fork_BG"] forState:UIControlStateNormal];
        [_forkButton addTarget:self action:@selector(didSignButon:) forControlEvents:UIControlEventTouchUpInside];
        _forkButton.tag = 9003;
    }
    return _forkButton;
    
}

- (UIView *)mightBgView{
    if (_mightBgView == nil) {
        _mightBgView = [[UIView alloc] init];
        _mightBgView.backgroundColor  =  [UIColor clearColor];
        
    }
    return _mightBgView;
}
- (UIView *)leftBgView{
    if (_leftBgView == nil) {
        _leftBgView = [[UIView alloc] init];
        _leftBgView.backgroundColor  =  [UIColor clearColor];
        _leftBgView.tag = 9004;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [_leftBgView addGestureRecognizer:tap];
        _leftBgView.userInteractionEnabled = YES;
        
    }
    return _leftBgView;
}
- (UIImageView *)leftFlageView{
    if (_leftFlageView == nil) {
        _leftFlageView = [[ UIImageView alloc] init];
        _leftFlageView.image = [UIImage imageNamed:@"NewReimbursePopView_Select"];
    }
    return _leftFlageView;
}
- (UILabel *)leftTitleLabel{
    if (_leftTitleLabel == nil) {
        _leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel.font = [UIFont systemFontOfSize:14];
        _leftTitleLabel.text = @"是";
        _leftTitleLabel.textColor = [UIColor grayColor];
    }
    return _leftTitleLabel;
}

- (UIView *)rightBgView{
    if (_rightBgView == nil) {
        _rightBgView = [[UIView alloc] init];
        _rightBgView.backgroundColor  =  [UIColor clearColor];
        _rightBgView.tag = 9005;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [_rightBgView addGestureRecognizer:tap];
        _rightBgView.userInteractionEnabled = YES;

        
    }
    return _rightBgView;
}
- (UIImageView *)rightFlageView{
    if (_rightFlageView == nil) {
        _rightFlageView = [[ UIImageView alloc] init];
        _rightFlageView.image = [UIImage imageNamed:@"Buffet_ChooseNor"];
    }
    return _rightFlageView;
}
- (UILabel *)rightTitleLabel{
    if (_rightTitleLabel == nil) {
        _rightTitleLabel = [[UILabel alloc] init];
        _rightTitleLabel.font = [UIFont systemFontOfSize:14];
        _rightTitleLabel.textColor = [UIColor grayColor];
        _rightTitleLabel.text = @"否";
    }
    return _rightTitleLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor  =  [UIColor grayColor];
        
    }
    return _lineView;
}
- (UIView *)bottomBgView{
    if (_bottomBgView == nil) {
        _bottomBgView = [[UIView alloc] init];
        _bottomBgView.backgroundColor  =  [UIColor clearColor];
        
    }
    return _bottomBgView;
}
- (UIButton *)cancleButton {
    
    if (_cancleButton == nil) {
        _cancleButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.backgroundColor = [UIColor clearColor];
        [_cancleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancleButton addTarget:self action:@selector(didSignButon:) forControlEvents:UIControlEventTouchUpInside];
        _cancleButton.tag = 9000;
    }
    return _cancleButton;
    
}
- (UIView *)VLineView{
    if (_VLineView == nil) {
        _VLineView = [[UIView alloc] init];
        _VLineView.backgroundColor  =  [UIColor grayColor];
    }
    return _VLineView;
}
- (UIButton *)commitButton {
    
    if (_commitButton == nil) {
        _commitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.backgroundColor = [UIColor clearColor];
        [_commitButton setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        [_commitButton setTitle:@"确定" forState:UIControlStateNormal];
        _commitButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_commitButton addTarget:self action:@selector(didSignButon:) forControlEvents:UIControlEventTouchUpInside];
        _commitButton.tag = 9001;
    }
    return _commitButton;
    
}

@end
