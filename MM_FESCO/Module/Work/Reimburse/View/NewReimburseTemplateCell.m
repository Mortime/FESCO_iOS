//
//  NewReimburseTemplateCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/7.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewReimburseTemplateCell.h"
#import "BankInfoModel.h"
#import "GroupInfoModel.h"

@interface NewReimburseTemplateCell () <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UITextField *detailTextField;

@property (strong, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic) UIDatePicker *dateView;

@property (nonatomic, strong) DVVSearchViewUITextFieldDelegateBlock didEndEditingBlock;

@property (nonatomic, strong) NSString *resultStr;


@end

@implementation NewReimburseTemplateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.isShowDataPickView = NO;
        self.isExist = NO;
        self.isShowPickView = NO;
    }
    return self;
}

- (void)initUI{
    
    self.detailTextField.delegate = self;
    
    self.pickerView.delegate = self;
    
    self.pickerView.dataSource = self;


    [self addSubview:self.bgView];

    [self.bgView addSubview:self.titleLabel];
    
    [self.bgView addSubview:self.detailTextField];
    
    [self.bgView addSubview:self.arrowImageView];
    
    
    
       
    
}
- (void)layoutSubviews{
    
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
        
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        make.width.mas_offset(@100);
    
    }];
    [self.detailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
    
        
    }];

    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@5);
        make.height.mas_equalTo(@9);
        
    }];
    
    self.detailTextField.placeholder = self.placeHold;
    
    if (_isShowDataPickView) {
        // 显示日期选择器
        self.detailTextField.inputView = self.dateView;
        
    }
    if (!_isExist) {
        // textFile  不可输入
        self.detailTextField.enabled = NO;
    }
    if (_isShowPickView) {
        
        self.detailTextField.inputView = self.pickerView;
    }

    
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
    
    if (_isGroup) {
         GroupInfoModel *model =  self.dataArray[row];
        _resultStr = model.groupName;
        return  _resultStr;
    }else{
        BankInfoModel *model =  self.dataArray[row];
        
        _resultStr = [NSString stringWithTitle:model.bankPayName content:model.bankNumber];
        return _resultStr;
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (_isGroup) {
        GroupInfoModel *model =  self.dataArray[row];
    
        
        self.detailTextField.text = model.groupName;

    }else{
        BankInfoModel *model =  self.dataArray[row];
        
        NSString *result = [NSString stringWithTitle:model.bankPayName content:model.bankNumber];
        
        self.detailTextField.text = result;

    }
    
    //    if (_didEndEditingBlock) {
    //        _didEndEditingBlock(self.rightTextFiled,self.tag);
    //    }
    
}

#pragma mark ----- UIDataView
- (void)valueChange:(UIDatePicker *)datePicker{
    //创建一个日期格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期的显示格式
    fmt.dateFormat = @"yyyy-MM-dd";
    //将日期转为指定格式显示
    NSString *dateStr = [fmt stringFromDate:datePicker.date];
    _detailTextField.text = dateStr;
    
    if (_didEndEditingBlock) {
        _didEndEditingBlock(self.detailTextField,self.tag);
    }
    
}

- (void)dvv_setTextFieldDidEndEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle {
    _didEndEditingBlock = handle;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (_isShowDataPickView) {
        [self valueChange:_dateView];
    }
    
    if ([self.detailTextField.text isEqualToString:@""]) {
        if (_isGroup) {
            GroupInfoModel *model =  self.dataArray[0];

            self.detailTextField.text = model.groupName;
        }else if(self.dataArray.count){
            BankInfoModel *model =  self.dataArray[0];
            
            NSString *result = [NSString stringWithTitle:model.bankPayName content:model.bankNumber];
            
            self.detailTextField.text = result;
        }
        
    }
    if (_didEndEditingBlock) {
        _didEndEditingBlock(self.detailTextField,self.tag);
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
#pragma mark ---- Lazy 加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor grayColor];
    
        
    }
    return _titleLabel;
}

- (UITextField *)detailTextField{
    if (_detailTextField == nil) {
        _detailTextField = [[UITextField alloc] init];
        _detailTextField.font = [UIFont systemFontOfSize:14];
        _detailTextField.textColor = [UIColor blackColor];
        [_detailTextField setValue:[UIColor  grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_detailTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
        
    
        
    }
    return _detailTextField;
}

- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.backgroundColor = [UIColor clearColor];
        _arrowImageView.image = [UIImage imageNamed:@"arrow_next"];
    }
    return _arrowImageView;
}
- (UIDatePicker *)dateView{
    if (_dateView == nil) {
        _dateView = [[UIDatePicker alloc] init];
        //设置本地语言
        _dateView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //设置日期显示的格式
        _dateView.datePickerMode = UIDatePickerModeDate;
        //监听datePicker的ValueChanged事件
        [_dateView addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _dateView;
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

- (void)setTitleStr:(NSString *)titleStr{
    _titleLabel.text = titleStr;
}
- (void)setDetailStr:(NSString *)detailStr{
    _detailTextField.text = detailStr;
}
@end
