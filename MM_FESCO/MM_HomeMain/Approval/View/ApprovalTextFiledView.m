//
//  ApprovalTextFiledView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ApprovalTextFiledView.h"

@interface ApprovalTextFiledView ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UITextField *rightTextFiled;

@property (strong, nonatomic) UIPickerView *pickerView;

@property (nonatomic, strong) DVVSearchViewUITextFieldDelegateBlock didEndEditingBlock;

@end

@implementation ApprovalTextFiledView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.isExist = NO;
        
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.rightTextFiled.delegate = self;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self addSubview:self.bgView];
    
    [self.bgView addSubview:self.leftLabel];
    [self.bgView addSubview:self.rightTextFiled];
    
    if (!_isExist) {
        
        self.rightTextFiled.inputView = self.pickerView;
        
    }
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
    }];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@100);
        
    }];
    [self.rightTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.leftLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.height.mas_equalTo(self.mas_height);
        make.right.mas_equalTo(self.bgView.mas_right);
        
    }];
    
    
    self.leftLabel.text = self.leftTitle;
    self.rightTextFiled.placeholder = self.placeHold;
    self.rightTextFiled.text = self.textFileStr;
    if (_isExist) {
        // 不显示选择器,让用户输入内容
        self.rightTextFiled.inputView = nil;
    }
}
#pragma mark ----- UIScrollerDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    
    self.rightTextFiled.textColor = MM_MAIN_FONTCOLOR_BLUE;
    _bgView.layer.borderColor = MM_MAIN_FONTCOLOR_BLUE.CGColor;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (_isExist) {
        if (_didEndEditingBlock) {
            _didEndEditingBlock(self.rightTextFiled,self.tag);
        }
    }
    
    self.rightTextFiled.textColor = [UIColor grayColor];
    _bgView.layer.borderColor = [UIColor whiteColor].CGColor;
}
#pragma mark ------ UIPickViewDelegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *resultString = self.dataArray[row];
    self.rightTextFiled.text = resultString;
    
    if (_didEndEditingBlock) {
        _didEndEditingBlock(self.rightTextFiled,self.tag);
    }
    
}

- (void)dvv_setTextFieldDidEndEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle {
    _didEndEditingBlock = handle;
}

#pragma mark ---- Lazy加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.layer.borderWidth = 2;
        _bgView.userInteractionEnabled = YES;
        _bgView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _bgView;
}
- (UILabel *)leftLabel{
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] init];
        //        _leftLabel.centerY = self.bgView.centerY;
        _leftLabel.font = [UIFont systemFontOfSize:14];
        _leftLabel.textColor = [UIColor blackColor];
    }
    return _leftLabel;
}
- (UITextField *)rightTextFiled {
    if (_rightTextFiled == nil) {
        _rightTextFiled = [[UITextField alloc] init];
        [_rightTextFiled setValue:[UIColor colorWithHexString:@"666666"] forKeyPath:@"_placeholderLabel.textColor"];
        [_rightTextFiled setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
        _rightTextFiled.font = [UIFont systemFontOfSize:12];
        _rightTextFiled.textColor = [UIColor grayColor];
        _rightTextFiled.backgroundColor = [UIColor clearColor];
        
    }
    return _rightTextFiled;
}
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        //        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}
@end