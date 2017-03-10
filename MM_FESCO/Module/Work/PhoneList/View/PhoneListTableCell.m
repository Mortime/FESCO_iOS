//
//  PhoneListTableCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/25.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PhoneListTableCell.h"
#import "BLPFAlertView.h"

@interface PhoneListTableCell ()

@property (nonatomic ,strong) UIView *bgView;

@end

@implementation PhoneListTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor clearColor];
    
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.leftImageView];
//    [self.bgView addSubview:self.messageImageView];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.mobileLabel];
    [self.bgView addSubview:self.phoneLabel];
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
        
    }];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgView.mas_left).offset(16);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@40);
        
    }];
//    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.right.mas_equalTo(self.leftImageView.mas_right);
//        make.bottom.mas_equalTo(self.leftImageView.mas_bottom);
//        make.width.mas_equalTo(@15);
//        make.height.mas_equalTo(@15);
//        
//    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.leftImageView.mas_centerY);
        make.height.mas_equalTo(@14);
        
    }];
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bgView.mas_top);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-16);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
//        make.centerY.mas_equalTo(self.bgView.centerY);
        
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.top.mas_equalTo(self.mobileLabel.mas_bottom).offset(10);
        make.top.mas_equalTo(self.bgView.mas_top);
        make.right.mas_equalTo(self.mobileLabel.mas_left).offset(-15);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        
    }];



}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark ------  UIGestureRecognizer
- (void)didCall:(UIGestureRecognizer *)ges{
    UILabel *label = (UILabel *)[ges view];
    [self.parantVC dismissViewControllerAnimated:YES completion:nil];
    if (label.text == nil || [label.text isEqualToString:@" "]) {
        return;
    }else{
        
        [BLPFAlertView showAlertWithTitle:@"电话号码" message:label.text cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
            MMLog(@"index = %lu",selectedOtherButtonIndex+1);
            NSUInteger indexAlert = selectedOtherButtonIndex + 1;
            if (indexAlert == 1) {
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",label.text];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }else {
                return ;
            }
            
        }];

    
    }
    
}

#pragma mark ----- 环信消息发送
- (void)pushMessage{
    if ([_delegate respondsToSelector:@selector(phoneListTableCellDelegateWithEmpID:empName:iconImage:)]) {
        [_delegate phoneListTableCellDelegateWithEmpID:_empID empName:_empName iconImage:_imgIcon];
    }
}
#pragma mark ---- Lazy 加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor  =  [UIColor whiteColor];
        
    }
    return _bgView;
}
- (UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = [UIColor clearColor];
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.layer.cornerRadius = 20;
        _leftImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushMessage)];
        [_leftImageView addGestureRecognizer:tapGes];

        
    }
    return _leftImageView;
}
- (UIImageView *)messageImageView{
    if (_messageImageView == nil) {
        _messageImageView = [[UIImageView alloc] init];
        _messageImageView.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        _messageImageView.layer.masksToBounds = YES;
        _messageImageView.layer.cornerRadius = 7.5;
        _messageImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushMessage)];
        [_messageImageView addGestureRecognizer:tapGes];
        
    }
    return _messageImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor grayColor];
        
    }
    return _nameLabel;
}
- (UILabel *)mobileLabel{
    if (_mobileLabel == nil) {
        _mobileLabel = [[UILabel alloc] init];
        _mobileLabel.font = [UIFont systemFontOfSize:14];
        _mobileLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _mobileLabel.tag = 300;
        _mobileLabel.userInteractionEnabled =  YES;
        UITapGestureRecognizer *tapGS = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCall:)];
        [_mobileLabel addGestureRecognizer:tapGS];
        
    }
    return _mobileLabel;
}

- (UILabel *)phoneLabel{
    if (_phoneLabel == nil) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textColor = [UIColor grayColor];
        _phoneLabel.tag = 301;
        _phoneLabel.userInteractionEnabled =  YES;
        UITapGestureRecognizer *tapGS = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCall:)];
        [_phoneLabel addGestureRecognizer:tapGS];
        
        
    }
    return _phoneLabel;
}



@end
