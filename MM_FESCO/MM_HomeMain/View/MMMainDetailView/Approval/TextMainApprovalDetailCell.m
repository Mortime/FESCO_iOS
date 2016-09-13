//
//  TextMainApprovalDetailCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "TextMainApprovalDetailCell.h"

@interface TextMainApprovalDetailCell ()

@property (nonatomic ,strong) UILabel *leftlabel;

@property (nonatomic ,strong) UILabel *rightlabel;

@end

@implementation TextMainApprovalDetailCell

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
    [self addSubview:self.rightlabel];
}
- (void)layoutSubviews{
    
    [self.leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(@14);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(@100);
        
        
    }];
    
    [self.rightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftlabel.mas_right).offset(0);
        make.height.mas_equalTo(@12);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(0);
        
        
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
- (UILabel *)leftlabel{
    if (_leftlabel == nil) {
        _leftlabel = [[UILabel alloc] init];
        _leftlabel.font = [UIFont systemFontOfSize:14];
        _leftlabel.textColor = [UIColor blackColor];
        }
    return _leftlabel;
}
- (UILabel *)rightlabel{
    if (_rightlabel == nil) {
        _rightlabel = [[UILabel alloc] init];
        _rightlabel.font = [UIFont systemFontOfSize:12];
        _rightlabel.textColor = [UIColor grayColor];
    }
    return _rightlabel;
}
- (void)setLeftTitle:(NSString *)leftTitle{
    _leftlabel.text = leftTitle;
}
- (void)setRightTitle:(NSString *)rightTitle{
    _rightlabel.text = rightTitle;
}
@end
