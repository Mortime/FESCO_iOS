//
//  LeaveApplyCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveApplyCell.h"
#import "MMChooseTextFile.h"

@interface LeaveApplyCell ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *resultUnitArray;

@property (nonatomic, strong) UIPickerView *pickView;

@property (nonatomic,strong) UITextField *rithtTextFiled; // 上午或者下午选择 默认是隐藏的

@property (nonatomic, strong) NSArray *holArray;

@property (nonatomic, strong) MMChooseTextFile *hourTimeNumTextFiled; //   // 当选择休假并且选择时间单位为小时时 截止时间显示为请假时数,  默认是隐藏的

@end

@implementation LeaveApplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return  self;
}
- (void)initUI{
    self.resultUnitArray = [NSMutableArray array];
    self.holArray = @[@"上午",@"下午"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.textFile];
    [self addSubview:self.rithtTextFiled];
    [self addSubview:self.hourTimeNumTextFiled];
    self.rithtTextFiled.inputView = self.pickView;
}
- (void)layoutSubviews{
    [self.textFile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom);
        
    }];
    
    [self.rithtTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom);
//        make.width.mas_offset (@100);
        
    }];
    
    [self.hourTimeNumTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom);
        
    }];

    
    
    
    _textFile.tag = _index;
    
    _rithtTextFiled.tag = _index + 10;
    
    if (_index == 3000) {
        _textFile.dataArray = _holTypeArray;
    }
    if (_index == 3001) {
        [_resultUnitArray removeAllObjects];
        for (NSNumber *unit in _unitsArray) {
            
            if ([unit integerValue] == 1) {
                [_resultUnitArray addObject:@"天"];
            }
            if ([unit integerValue] == 2) {
                [_resultUnitArray addObject:@"小时"];
            }
            if ([unit integerValue] == 3) {
                [_resultUnitArray addObject:@"半天"];
            }
        }
        
        _textFile.dataArray = _resultUnitArray;
    }
    // 显示日期PickView
    if (_index == 3002 || _index == 3003 ) {
        _textFile.isShowDataPickView = YES;
    }
    // 不显示PickView
    if (_index == 3004) {
        _textFile.isExist = YES;
    }
    if (_index == 3005) {
        _textFile.dataArray = _pickData;
    }
    
    // 剩余假期
    if (_index == 3006) {
        _textFile.isExist = YES;
        _textFile.userInteractionEnabled = NO;
        _textFile.rightTextFiled.text = _holNumberStr;
    }
    
    
    if (_index == 3002 || _index == 3003) {
        if (_isShowAMPM) {
            _rithtTextFiled.hidden = NO;
            _textFile.timeType = _timeType;
        }else{
            _rithtTextFiled.hidden = YES;
        }
    }

    
    if ( _index == 3003) {
        if (_isShowTimeNum) {
            _hourTimeNumTextFiled.hidden = NO;
            _textFile.hidden = YES;
        }else{
            _hourTimeNumTextFiled.hidden = YES;
             _textFile.hidden = NO;
        }
    }

    
    
    // 当选择休假并且选择时间单位为小时时 截止时间显示为请假时数,
        
    

}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
#pragma mark ------ UItextFiledDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _rithtTextFiled.layer.borderColor = MM_MAIN_FONTCOLOR_BLUE.CGColor;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    // 3012 开始时间  ,  3013 结束时间
    _rithtTextFiled.layer.borderColor = [UIColor whiteColor].CGColor;
    if ([_delegate respondsToSelector:@selector(leaveApplyCellDelegateWithAMPM:)]) {
        [_delegate leaveApplyCellDelegateWithAMPM:textField];
    }
}
#pragma mark ------ UIPickViewDelegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.holArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    self.rithtTextFiled.text = self.holArray[row];
//
//    if (_didEndEditingBlock) {
//        _didEndEditingBlock(self.rightTextFiled,self.tag);
//    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

#pragma makr MMChooseTixtFileBlock
- (void)initHourTime:(NSString *)hourTime{
    if ([_delegate respondsToSelector:@selector(leaveApplyCellDelegateWithHourTime:)]) {
        [_delegate leaveApplyCellDelegateWithHourTime:hourTime];
    }
}
- (MMChooseTextFile *)textFile{
    if (_textFile == nil) {
        _textFile = [[MMChooseTextFile alloc] init];
        _textFile.backgroundColor  = [UIColor whiteColor];
////        _textFile.dataArray = self.dataArray;
//        [_textFile dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
//            
//        }];
//        
        
    }
    return _textFile;
}
- (void)setLeftTitle:(NSString *)leftTitle{
    _textFile.leftTitle = leftTitle;
}
- (void)setPlaceTitle:(NSString *)placeTitle{
    _textFile.placeHold = placeTitle;
}

- (UITextField *)rithtTextFiled {
    if (_rithtTextFiled == nil) {
        _rithtTextFiled = [[UITextField alloc] init];
        [_rithtTextFiled setValue:[UIColor colorWithHexString:@"666666"] forKeyPath:@"_placeholderLabel.textColor"];
        [_rithtTextFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        _rithtTextFiled.font = [UIFont systemFontOfSize:14];
        _rithtTextFiled.placeholder = @"请选择上午或下午";
        _rithtTextFiled.textColor = [UIColor grayColor];
        _rithtTextFiled.backgroundColor = [UIColor clearColor];
        _rithtTextFiled.delegate = self;
        _rithtTextFiled.layer.borderWidth = 1;
        _rithtTextFiled.layer.borderColor = MM_MAIN_FONTCOLOR_BLUE.CGColor;
        _rithtTextFiled.hidden = YES;
        
    }
    return _rithtTextFiled;
}

- (MMChooseTextFile *)hourTimeNumTextFiled {
    if (_hourTimeNumTextFiled == nil) {
        _hourTimeNumTextFiled = [[MMChooseTextFile alloc] init];
        _hourTimeNumTextFiled.leftTitle = @"请假时数";
        _hourTimeNumTextFiled.placeHold = @"请输入请假时数";
        _hourTimeNumTextFiled.isExist = YES;
        _hourTimeNumTextFiled.hidden = YES;
        _hourTimeNumTextFiled.backgroundColor = [UIColor whiteColor];
        [_hourTimeNumTextFiled dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self initHourTime:textField.text];
        }];
    }
    return _hourTimeNumTextFiled;
}

- (UIPickerView *)pickView {
    if (_pickView == nil) {
        _pickView = [[UIPickerView alloc] init];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        //        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickView;
}

@end
