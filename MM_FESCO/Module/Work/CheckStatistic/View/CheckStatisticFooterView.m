//
//  CheckStatisticFooterView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "CheckStatisticFooterView.h"

@interface CheckStatisticFooterView ()
@property (nonatomic, strong) UITextView *checkContentView;


@end
@implementation CheckStatisticFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self ) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.checkContentView];

}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.checkContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(@50);

        
    }];

}
- (UITextView *)checkContentView{
    if (_checkContentView == nil) {
        _checkContentView = [[UITextView alloc] init];
        _checkContentView.font = [UIFont systemFontOfSize:12];
        _checkContentView.textColor = [UIColor whiteColor];
        _checkContentView.backgroundColor = [UIColor clearColor];
        
        
        
        
    }
    return _checkContentView;
}
- (void)setRecodeStr:(NSString *)recodeStr{
    
_checkContentView.text = recodeStr;
    

}
@end
