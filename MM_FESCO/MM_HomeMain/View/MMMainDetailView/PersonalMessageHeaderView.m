//
//  PersonalMessageHeaderView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/19.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PersonalMessageHeaderView.h"

@interface PersonalMessageHeaderView () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIView *nameBG;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UITextField *nameTextFiled;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *sexBG;

@property (nonatomic, strong) UILabel *sexLabel;

@property (nonatomic, strong) UITextField *sexTextFiled;

@property (nonatomic, strong) UIButton *flagButton;

@end

@implementation PersonalMessageHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.nameTextFiled.delegate = self;
        self.sexTextFiled.delegate = self;
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.imageView];
    
    [self.bgView addSubview:self.nameBG];
    [self.nameBG addSubview:self.nameLabel];
    [self.nameBG addSubview:self.nameTextFiled];

    [self.bgView addSubview:self.lineView];

    [self.bgView addSubview:self.sexBG];
    [self.sexBG addSubview:self.sexLabel];
    [self.sexBG addSubview:self.sexTextFiled];
    [self.sexBG addSubview:self.flagButton];

}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height);
        
    }];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@70);
        make.height.mas_equalTo(@70);
        
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerX.mas_equalTo(self.bgImageView.mas_centerX);
        make.centerY.mas_equalTo(self.bgImageView.mas_centerY);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@65);
        
    }];
    [self.nameBG mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.bgImageView.mas_right).offset(20);
        make.right.mas_equalTo(self.bgView.mas_right);
        make.height.mas_equalTo(@65);
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.nameBG.mas_left).offset(0);
        make.centerY.mas_equalTo(self.nameBG.mas_centerY);
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@15);
        
    }];
    [self.nameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(20);
        make.centerY.mas_equalTo(self.nameBG.mas_centerY);
        make.right.mas_equalTo(self.nameBG.mas_right);
        make.height.mas_equalTo(self.nameBG.mas_height);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.bgImageView.mas_right).offset(15);
        make.top.mas_equalTo(self.nameBG.mas_bottom);
        make.right.mas_equalTo(self.bgView.mas_right);
        make.height.mas_equalTo(@1);
        
    }];

    [self.sexBG mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.left.mas_equalTo(self.nameBG.mas_left);
        make.right.mas_equalTo(self.nameBG.mas_right);
        make.height.mas_equalTo(@65);
        
    }];
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.sexBG.mas_left).offset(0);
        make.centerY.mas_equalTo(self.sexBG.mas_centerY);
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@15);
        
    }];
    [self.sexTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.sexLabel.mas_right).offset(20);
        make.centerY.mas_equalTo(self.sexBG.mas_centerY);
        make.right.mas_equalTo(self.sexBG.mas_right).offset(-50);
        make.height.mas_equalTo(self.sexBG.mas_height);
        
    }];
    [self.flagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerY.mas_equalTo(self.sexBG.mas_centerY);
        make.right.mas_equalTo(self.sexBG.mas_right).offset(-50);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@22);
        
    }];


}

#pragma mark ---- UITextFileDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.textColor = MM_MAIN_FONTCOLOR_BLUE;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.textColor = [UIColor whiteColor];
}
#pragma mark ----- icon
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
//        _bgImageView.image = [UIImage imageNamed:@"PersonalMes_BGImage"];
        _bgImageView.backgroundColor = [UIColor whiteColor];
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.layer.cornerRadius = 35;
    }
    return _bgImageView;
}
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor cyanColor];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 32.5;
    }
    return _imageView;
}
#pragma mark ----- name
- (UIView *)nameBG{
    if (_nameBG == nil) {
        _nameBG = [[UIView alloc] init];
        _nameBG.backgroundColor = [UIColor clearColor];
    }
    return _nameBG;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"姓名";
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
    }
    return _nameLabel;
}
- (UITextField *)nameTextFiled{
    if (_nameTextFiled == nil) {
        _nameTextFiled = [[UITextField alloc] init];
        _nameTextFiled.placeholder = @"姓名";
        _nameTextFiled.text = @"王宝强";
        [_nameTextFiled setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_nameTextFiled setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        _nameTextFiled.font = [UIFont systemFontOfSize:15];
        _nameTextFiled.textColor = [UIColor whiteColor];
        _nameTextFiled.backgroundColor = [UIColor clearColor];
        
   
    }
    return _nameTextFiled;
}
#pragma mark ----- Line
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = MM_MAIN_LINE_COLOR;
    }
    return _lineView;
}
#pragma mark ----- sex
- (UIView *)sexBG{
    if (_sexBG == nil) {
        _sexBG = [[UIView alloc] init];
        _sexBG.backgroundColor = [UIColor clearColor];
    }
    return _sexBG;
}

- (UILabel *)sexLabel{
    if (_sexLabel == nil) {
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.text = @"性别";
        _sexLabel.font = [UIFont systemFontOfSize:15];
        _sexLabel.backgroundColor = [UIColor clearColor];
        _sexLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
    }
    return _sexLabel;
}
- (UITextField *)sexTextFiled{
    if (_sexTextFiled == nil) {
        _sexTextFiled = [[UITextField alloc] init];
        _sexTextFiled.placeholder = @"性别";
        _sexTextFiled.text = @"男";
        [_sexTextFiled setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_sexTextFiled setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        _sexTextFiled.font = [UIFont systemFontOfSize:15];
        _sexTextFiled.textColor = [UIColor whiteColor];
        _sexTextFiled.backgroundColor = [UIColor clearColor];
    
        
    }
    return _sexTextFiled;
}
- (UIButton *)flagButton{
    if (_flagButton == nil) {
        _flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flagButton setBackgroundImage:[UIImage imageNamed:@"PersonalMes_FlagButton"] forState:UIControlStateNormal];
        
    }
    return _flagButton;
}
@end
