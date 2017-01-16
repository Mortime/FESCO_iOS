//
//  FileMainApprovalDetailCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "FileMainApprovalDetailCell.h"

@interface FileMainApprovalDetailCell ()



@end

@implementation FileMainApprovalDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 设置是否显示pickView yes 为不显示
        _isExist = YES;
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.rightTextFiled];
}
- (void)layoutSubviews{
    
    [self.rightTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.height.mas_equalTo(self.mas_height);
        make.right.mas_equalTo(self.mas_right).offset(0);
        
        
    }];
    
    // cell中设置后重新赋值
    self.rightTextFiled.dataArray =  self.pickDataArray;
    _rightTextFiled.isExist = _isExist;
    _rightTextFiled.tag = _textFiledTag;
}
- (void)initWithTextFile:(UITextField *)textfile indexTag:(NSInteger)indexTag{
    if ([_delegate respondsToSelector:@selector(fileMainApprovalDetailCellDelegateWithTextFile:indexTag:)]) {
        [_delegate fileMainApprovalDetailCellDelegateWithTextFile:textfile indexTag:indexTag];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (ApprovalTextFiledView *)rightTextFiled{
    if (_rightTextFiled == nil) {
        _rightTextFiled = [[ApprovalTextFiledView alloc] init];
        [_rightTextFiled dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self initWithTextFile:textField indexTag:indexTag];
        }];
        
        
    }
    return _rightTextFiled;
}
- (void)setLeftTitle:(NSString *)leftTitle{
    _rightTextFiled.leftTitle = leftTitle;
}
- (void)setRightTitle:(NSString *)rightTitle{
    _rightTextFiled.placeHold = rightTitle;
}
@end
