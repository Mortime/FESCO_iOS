//
//  MMSwitchText.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/3/10.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "MMSwitchText.h"

@interface MMSwitchText ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, assign) BOOL flagMove;

@end

@implementation MMSwitchText
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.rightLabel];
    [self.bgView addSubview:self.leftLabel];
    [self.bgView addSubview:self.topLabel];
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.right.mas_equalTo(self.mas_right);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top);
        make.right.mas_equalTo(self.bgView.mas_right);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        make.width.mas_equalTo(@(self.width/2));
    }];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.bgView.mas_left);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        make.width.mas_equalTo(@(self.width/2));
    }];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *data = [defaults objectForKey:@"kSex"];

    if ([data isEqualToString:@"女"]) {
        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgView.mas_top).offset(2);
            make.left.mas_equalTo(self.bgView.mas_left);
            make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-2);
            make.width.mas_equalTo(@(self.width/2));
        }];
        _topLabel.text = @"女";
        _rightLabel.text = @"男";
        _flagMove = NO;
    }else{
        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgView.mas_top).offset(2);
            make.right.mas_equalTo(self.bgView.mas_right);
            make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-2);
            make.width.mas_equalTo(@(self.width/2));
        }];
        _topLabel.text = @"男";
        _leftLabel.text = @"女";
        _flagMove = YES;
    }
    

}
- (void)didMove:(UIGestureRecognizer *)ges{
    if (_flagMove) {
        CGRect frame = self.topLabel.frame;
        frame.origin.x =  frame.origin.x - (self.width/2);
        [UIView animateWithDuration:0.25 animations:^{
            self.topLabel.frame = frame;
        }];
        _topLabel.text = @"女";
        _rightLabel.text = @"男";
        _flagMove = NO;
        [self storeData:@"女" forKey:@"kSex"];
        
    }else{
        CGRect frame = self.topLabel.frame;
        frame.origin.x =  frame.origin.x + (self.width/2);
        [UIView animateWithDuration:0.25 animations:^{
            self.topLabel.frame = frame;
        }];
        _topLabel.text = @"男";
        _leftLabel.text = @"女";
        [self storeData:@"男" forKey:@"kSex"];
        _flagMove = YES;
    }
}
- (void)storeData:(id)data forKey:(NSString *)key
{
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defults setObject:data forKey:key];
    [defults synchronize];
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 15;
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}
- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.backgroundColor = [UIColor whiteColor];
        _rightLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _rightLabel.text = @"男";
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = [UIFont systemFontOfSize:14];
    }
    return _rightLabel;
}
- (UILabel *)leftLabel{
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.backgroundColor = [UIColor whiteColor];
        _leftLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _leftLabel.text = @"女";
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = [UIFont systemFontOfSize:14];
    }
    return _leftLabel;
}
- (UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.text = @"男";
        _topLabel.layer.masksToBounds = YES;
        _topLabel.layer.cornerRadius = 13;
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont systemFontOfSize:14];
        _topLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didMove:)];
        [_topLabel addGestureRecognizer:tap];
    }
    return _topLabel;
}

@end
