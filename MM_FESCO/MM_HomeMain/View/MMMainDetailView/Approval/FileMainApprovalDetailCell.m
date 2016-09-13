//
//  FileMainApprovalDetailCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "FileMainApprovalDetailCell.h"
#import "MMChooseTextFile.h"
@interface FileMainApprovalDetailCell ()

@property (nonatomic ,strong) UILabel *leftlabel;

@property (nonatomic ,strong) MMChooseTextFile *rightTextFiled;

@end

@implementation FileMainApprovalDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.leftlabel];
    [self addSubview:self.rightTextFiled];
}
- (void)layoutSubviews{
    
    [self.leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(@14);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(@100);
        
        
    }];
    
    [self.rightTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftlabel.mas_right).offset(0);
        make.height.mas_equalTo(@12);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(0);
        
        
    }];
}
- (void)initWithTextFile:(UITextField *)textfile indexTag:(NSInteger)indexTag{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (UILabel *)leftlabel{
    if (_leftlabel == nil) {
        _leftlabel = [[UILabel alloc] init];
        _leftlabel.font = [UIFont systemFontOfSize:14];
        _leftlabel.textColor = [UIColor blackColor];
    }
    return _leftlabel;
}
- (MMChooseTextFile *)rightTextFiled{
    if (_rightTextFiled == nil) {
        _rightTextFiled = [[MMChooseTextFile alloc] init];
        _rightTextFiled.leftTitle = @"补签原因";
        _rightTextFiled.placeHold = @"请输入补签原因";
        _rightTextFiled.isExist = YES;
        _rightTextFiled.tag = 1000;
        [_rightTextFiled dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self initWithTextFile:textField indexTag:indexTag];
        }];
        
        
    }
    return _rightTextFiled;
}
- (void)setLeftTitle:(NSString *)leftTitle{
    _leftlabel.text = leftTitle;
}

@end