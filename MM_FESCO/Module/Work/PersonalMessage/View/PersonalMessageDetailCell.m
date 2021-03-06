//
//  PersonalMessageDetailCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PersonalMessageDetailCell.h"


@interface PersonalMessageDetailCell () <UITextFieldDelegate>


@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic ,strong) UIImageView *leftImageView;

@property (nonatomic, strong) DVVSearchViewUITextFieldDelegateBlock didEndEditingBlock;



@end

@implementation PersonalMessageDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor clearColor];
        self.detailFiled.delegate = self;
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.leftImageView];
    [self.bgView addSubview:self.detailFiled];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.bgView.mas_left).offset(20);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@22);
    }];

    [self.detailFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(20);
        make.centerY.mas_equalTo(self.bgView.mas_centerY).offset(2);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.height.mas_equalTo(self.bgView.mas_height);
    }];

}

#pragma mark ---- Lazy 加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor  =  [UIColor clearColor];
        
    }
    return _bgView;
}
- (UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = [UIColor clearColor];
    }
    return _leftImageView;
}
- (UITextField *)detailFiled{
    if (_detailFiled == nil ) {
        _detailFiled = [[UITextField alloc] init];
        _detailFiled.font = [UIFont systemFontOfSize:14];
        _detailFiled.textColor = [UIColor colorWithHexString:@"333333"];
        _detailFiled.backgroundColor = [UIColor clearColor];
        

        
    }
    return _detailFiled;
}

- (void)dvv_setTextFieldDidEndEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle {
    _didEndEditingBlock = handle;
}

#pragma mark ---- UITextFileDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.textColor = MM_MAIN_FONTCOLOR_BLUE;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    MMLog(@"textField = %lu",textField.tag);
    textField.textColor = [UIColor colorWithHexString:@"333333"];
    if (_didEndEditingBlock) {
        _didEndEditingBlock(textField);
    }
    
    // 编辑完成后重新保存个人信息
    NSString *messageStr = textField.text;
    NSString *keyStr = @"";
    
    if (textField.tag == 100 ) {
        //  座机
         keyStr = kPhone;
    }
    if (textField.tag == 101 ) {
        //  电话
        keyStr = kMobile;
    }
    if (textField.tag == 102 ) {
        //  微信号
        keyStr = kWeixin;
    }
    if (textField.tag == 103 ) {
        //  邮箱
        keyStr = kMail;
    }
    if (textField.tag == 104 ) {
        //  地址
         keyStr = kAddress;
    }
    if (textField.tag == 105 ) {
        //  邮编
         keyStr = kZipCode;
        
    }
    // 将个人信息进行保存
    [self storeData:messageStr forKey:keyStr];

    
}

#pragma mark ----  data
- (void)setImgStr:(NSString *)imgStr{
    self.leftImageView.image = [UIImage imageNamed:imgStr];
}

- (void)setPersonalMessageModel:(PersonalMessageModel *)personalMessageModel{
    NSString *messageStr = @"";
    NSString *keyStr = @"";
    
    if (_index == 0) {
        //  座机
        messageStr = personalMessageModel.phone;
        keyStr = kPhone;
           }
    
    if (_index == 1) {
        // 电话
        messageStr =  personalMessageModel.mobile;
        keyStr = kMobile;
        
    }
    
    if (_index == 2) {
        // 微信号
        messageStr = personalMessageModel.weixinid;
        keyStr = kWeixin;
    }
    if (_index == 3) {
        // 邮箱
        messageStr = personalMessageModel.email;
        keyStr = kMail;
    }
    if (_index == 4) {
        // 地址
        messageStr = personalMessageModel.address;
        keyStr = kAddress;
        
    }
    if (_index == 5) {
        // 邮编
        messageStr = personalMessageModel.zipcode;
        keyStr = kZipCode;
    }


    if (messageStr == nil || [messageStr isEqualToString:@""]) {
        
        [_detailFiled setValue:[UIColor colorWithHexString:@"999999"] forKeyPath:@"_placeholderLabel.textColor"];
        [_detailFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        self.detailFiled.placeholder = self.dataStr;
        messageStr = @"";
        
    }else{
        self.detailFiled.text = messageStr;
    }

    // 将个人信息进行保存
    [self storeData:messageStr forKey:keyStr];
    
}

#pragma mark - StoreDefaults
- (void)storeData:(id)data forKey:(NSString *)key
{
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defults setObject:data forKey:key];
    [defults synchronize];
}


@end
