//
//  CheckStatisticFooterView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "CheckStatisticFooterView.h"

@interface CheckStatisticFooterView ()

@property (nonatomic, strong) UILabel *checkTitleLabel;
@property (nonatomic, strong) UITextView *checkContentView;
@property (nonatomic, strong) UILabel *holidayTitelLabel;
@property (nonatomic, strong) UILabel *holidayContentLabel;

@end
@implementation CheckStatisticFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.checkTitleLabel];
    [self addSubview:self.checkContentView];
    [self addSubview:self.holidayTitelLabel];
    [self addSubview:self.holidayContentLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.checkTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(@16);
        
        
    }];
    [self.checkContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.checkTitleLabel.mas_bottom);
        make.left.mas_equalTo(self.checkTitleLabel.mas_left);
        make.right.mas_equalTo(self.checkTitleLabel.mas_right);
        make.height.mas_equalTo(@50);
        
        
    }];
    [self.holidayTitelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.checkContentView.mas_bottom);
        make.left.mas_equalTo(self.checkTitleLabel.mas_left);
        make.right.mas_equalTo(self.checkTitleLabel.mas_right);
        make.height.mas_equalTo(@16);
        
    }];
    [self.holidayContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.holidayTitelLabel.mas_bottom);
        make.left.mas_equalTo(self.checkTitleLabel.mas_left);
        make.right.mas_equalTo(self.checkTitleLabel.mas_right);
//        make.height.mas_equalTo(@16);
        
        
        
    }];
    
//    _checkContentLabel.text = _recodeStr;
   

}
- (UILabel *)checkTitleLabel{
    if (_checkTitleLabel == nil) {
        _checkTitleLabel = [[UILabel alloc] init];
        _checkTitleLabel.font = [UIFont systemFontOfSize:14];
        _checkTitleLabel.text = @"打卡记录";
        _checkTitleLabel.textColor = [UIColor blackColor];
        
    }
    return _checkTitleLabel;
}
- (UITextView *)checkContentView{
    if (_checkContentView == nil) {
        _checkContentView = [[UITextView alloc] init];
        _checkContentView.font = [UIFont systemFontOfSize:12];
        _checkContentView.textColor = [UIColor grayColor];
//        _checkContentLabel.text = @"2018-89--8888";
        _checkContentView.backgroundColor = [UIColor clearColor];
    }
    return _checkContentView;
}
- (UILabel *)holidayTitelLabel{
    if (_holidayTitelLabel == nil) {
        _holidayTitelLabel = [[UILabel alloc] init];
        _holidayTitelLabel.font = [UIFont systemFontOfSize:14];
        _holidayTitelLabel.textColor = [UIColor blackColor];
        _holidayTitelLabel.text = @"剩余假期";
    }
    return _holidayTitelLabel;
}
- (UILabel *)holidayContentLabel{
    if (_holidayContentLabel == nil) {
        _holidayContentLabel = [[UILabel alloc] init];
        _holidayContentLabel.font = [UIFont systemFontOfSize:12];
        _holidayContentLabel.textColor = [UIColor grayColor];
//        _holidayContentLabel.text = @"2018-89--8888";
//        _holidayContentLabel.backgroundColor = [UIColor cyanColor];
        
    }
    return _holidayContentLabel;
}
- (void)setRecodeStr:(NSString *)recodeStr{
    
    NSNumber *H = [NSNumber numberWithFloat:[self getLabelWidthWithString:recodeStr]];
    [self.checkContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.checkTitleLabel.mas_bottom);
        make.left.mas_equalTo(self.checkTitleLabel.mas_left);
        make.right.mas_equalTo(self.checkTitleLabel.mas_right);
        make.height.mas_equalTo(50);
    }];
     MMLog(@"recodeStr  ==%@",recodeStr);
    _checkContentView.text = recodeStr;

}
- (void)setHolidayStr:(NSString *)holidayStr{
    MMLog(@"holidayStr  ==%@%@",holidayStr,_holidayContentLabel);
    
    NSNumber *H = [NSNumber numberWithFloat:[self getLabelWidthWithString:holidayStr]];
    [self.holidayContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.holidayTitelLabel.mas_bottom);
        make.left.mas_equalTo(self.checkTitleLabel.mas_left);
        make.right.mas_equalTo(self.checkTitleLabel.mas_right);
        make.height.mas_equalTo(H);
    }];
    
    MMLog(@"holidayStr  ==%@%@",holidayStr,_holidayContentLabel);
    _holidayContentLabel.text = holidayStr;
    
    }

- (CGFloat)getLabelWidthWithString:(NSString *)string {
      CGRect bounds = [string boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} context:nil];
        
    return bounds.size.height + 10;
}
@end
