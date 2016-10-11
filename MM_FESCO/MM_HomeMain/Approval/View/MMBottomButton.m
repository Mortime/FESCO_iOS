//
//  MMBottomButton.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMBottomButton.h"

@interface MMBottomButton ()

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) MMBottomButtonDelegateBlock didClickBlock;


@end

@implementation MMBottomButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
    }
    return self;
}
// 按钮点击回调
- (void)didClick:(UIButton *)sender{
    
    if (_didClickBlock) {
        _didClickBlock(sender.tag);
    }
}
- (void)layoutSubviews{
    
}
- (UIButton *)leftButton{
    if (_leftButton == nil) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0, 0, self.width/2, self.height);
        [_leftButton setTitle:@"同意" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        _leftButton.tag = 10010;
        
    }
    return _leftButton;
}
- (UIButton *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(CGRectGetMaxX(self.leftButton.frame), 0, self.width/2, self.height);
        [_rightButton setTitle:@"驳回" forState:UIControlStateNormal];
        [_rightButton setTitleColor:MM_MAIN_LINE_COLOR forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setBackgroundColor:MM_MAIN_BACKGROUND_COLOR];
         _rightButton.tag = 10011;
        
    }
    return _rightButton;
}
- (void)mm_setBottomButtonDelegateBlock:(MMBottomButtonDelegateBlock)handle{
    _didClickBlock = handle;
}
@end
