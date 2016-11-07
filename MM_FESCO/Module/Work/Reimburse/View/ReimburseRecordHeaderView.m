//
//  ReimburseRecordHeaderView.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/4.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ReimburseRecordHeaderView.h"

@interface ReimburseRecordHeaderView ()

@property (nonatomic, strong) UIImageView *flageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation ReimburseRecordHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    
    [self addSubview:self.flageView];
    
    [self addSubview:self.titleLabel];
    
    [self addSubview:self.textView];
    
    
}
- (void)layoutSubviews{
    [self.flageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(@32);
        make.height.mas_equalTo(@32);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.flageView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(@16);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}
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
        _titleLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}
- (UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.editable = NO;
        _textView.textColor = [UIColor grayColor];
        _textView.text = @"2条消费记录\n共369元";
    }
    return _textView;
}
- (void)setTitleStr:(NSString *)titleStr{
    _titleLabel.text = titleStr;
}
- (void)setTextViewStr:(NSString *)textViewStr{
    _textView.text = textViewStr;
}
- (void)setImgStr:(NSString *)imgStr{
    _flageView.image = [UIImage imageNamed:imgStr];
}
@end
