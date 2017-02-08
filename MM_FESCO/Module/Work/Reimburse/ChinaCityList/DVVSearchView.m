//
//  DVVSearchView.m
//  studentDriving
//
//  Created by 大威 on 16/1/6.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVSearchView.h"



typedef void(^DVVSearchViewUITextFieldDelegateBlock)(UITextField *textField);

@interface DVVSearchView ()

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, copy) DVVSearchViewUITextFieldDelegateBlock didBeginEditingBlock;
@property (nonatomic, strong) DVVSearchViewUITextFieldDelegateBlock didEndEditingBlock;
@property (nonatomic, strong) DVVSearchViewUITextFieldDelegateBlock textChangeBlock;

@end
@implementation DVVSearchView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.textField];
        [self addSubview:self.cancelButton];
        
        [_textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat radius = viewHeight / 2.f;
    CGFloat searchButtonWidth = 40;
    _backgroundImageView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    _textField.frame = CGRectMake(radius, 0, viewWidth - radius - searchButtonWidth + 8, viewHeight);
    // 搜索按钮在中心显示
    _cancelButton.frame = CGRectMake((viewWidth - searchButtonWidth) / 2.f, 0, searchButtonWidth, viewHeight);
    
    [_cancelButton setTitle:@"搜索" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _textField.font = [UIFont systemFontOfSize:13];
    
    _textField.tintColor = [UIColor grayColor];
    // 设置背景视图为圆角
    [_backgroundImageView.layer setMasksToBounds:YES];
    [_backgroundImageView.layer setCornerRadius:[self defaultHeight] / 2.f];
    
//    _textField.backgroundColor = [UIColor redColor];
//    _searchButton.backgroundColor = [UIColor orangeColor];
}

#pragma mark - action

#pragma mark - 取消按钮
- (void)cancelButtonAction:(UIButton *)sender {
    
    _textField.text = @"";
    [_textField resignFirstResponder];
    [self statusNormal];
  
    if (_didEndEditingBlock) {
        _didEndEditingBlock(_textField);
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // 回调
    if (_didBeginEditingBlock) {
        _didBeginEditingBlock(textField);
    }
    [UIView animateWithDuration:0.2 animations:^{
        
        // 取消按钮在右侧显示
        CGFloat viewWidth = self.bounds.size.width;
        CGFloat viewHeight = self.bounds.size.height;
//        CGFloat radius = viewHeight / 2.f;
        CGFloat searchButtonWidth = 40;
        _cancelButton.frame = CGRectMake(viewWidth - searchButtonWidth, 0, searchButtonWidth, viewHeight);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        if (_placeholder) {
            _textField.placeholder = _placeholder;
        }else {
            _textField.placeholder = @"请输入搜索内容";
        }
        _cancelButton.userInteractionEnabled = YES;
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (_didEndEditingBlock) {
        _didEndEditingBlock(textField);
    }
    // 如果textField内容不为空时则取消按钮不回到中心，还可以响应用户点击
    if (textField.text.length) {
        return ;
    }
    [self statusNormal];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textChange:(UITextField *)textField {
    if (_textChangeBlock) {
        _textChangeBlock(textField);
    }
}


#pragma mark 搜索框无文本输入，并且取消搜索状态时
- (void)statusNormal {
    
    _textField.placeholder = @"";
    [UIView animateWithDuration:0.2 animations:^{
        
        // 取消按钮在中心显示（显示文字为“搜索”）
        CGFloat viewWidth = self.bounds.size.width;
        CGFloat viewHeight = self.bounds.size.height;
        CGFloat searchButtonWidth = 40;
        _cancelButton.frame = CGRectMake((viewWidth - searchButtonWidth) / 2.f, 0, searchButtonWidth, viewHeight);
        [_cancelButton setTitle:@"搜索" forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        
        _cancelButton.userInteractionEnabled = NO;
    }];
}

#pragma mark set block
- (void)dvv_setTextFieldDidBeginEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle {
    _didBeginEditingBlock = handle;
}
- (void)dvv_setTextFieldDidEndEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle {
    _didEndEditingBlock = handle;
}
- (void)dvv_setTextFieldTextChangeBlock:(DVVSearchViewUITextFieldDelegateBlock)handle {
    _textChangeBlock = handle;
}

#pragma mark - lazy load
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
        _backgroundImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    }
    return _backgroundImageView;
}
- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeDefault;
        _textField.returnKeyType = UIReturnKeySearch;
    }
    return _textField;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton new];
        _cancelButton.userInteractionEnabled = NO;
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _cancelButton;
}
- (CGFloat)defaultHeight {
    return 26;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
