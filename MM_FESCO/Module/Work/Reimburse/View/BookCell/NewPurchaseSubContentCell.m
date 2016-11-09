//
//  ewPurchaseSubContentCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewPurchaseSubContentCell.h"


@interface NewPurchaseSubContentCell ()

@property (nonatomic, strong) UIView *bgView;


@end
@implementation NewPurchaseSubContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return  self;
}

- (void)initUI{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    [self addSubview:self.bgView];
    [self addSubview:self.textFiled];
    
    
}
- (void)layoutSubviews{
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom);
        
        
    }];

}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (MMChooseTextFile *)textFiled{
    if (_textFiled == nil) {
        _textFiled = [[MMChooseTextFile alloc] init];
        _textFiled.backgroundColor = [UIColor whiteColor];
    }
    return _textFiled;
}
@end
