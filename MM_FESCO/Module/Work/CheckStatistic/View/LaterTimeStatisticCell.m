//
//  LaterTimeStatisticCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LaterTimeStatisticCell.h"

@interface LaterTimeStatisticCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIView *flagView;

@property (nonatomic, strong) UIImageView *flagImageView;

@end

@implementation LaterTimeStatisticCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return  self;
}
- (void)initUI{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.flagView];
    [self.flagView addSubview:self.flagImageView];
}
- (void)layoutSubviews{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(50);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(self.height);
        make.width.mas_equalTo(@60);
    }];
   
    [self.flagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right);
        make.right.mas_equalTo(self.mas_right).offset(-50);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(@2);
        
    }];
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.flagView.mas_left);
        make.centerY.mas_equalTo(self.flagView.mas_centerY);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@9);
        
        
    }];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _nameLabel;
}
- (UIView *)flagView{
    if (_flagView == nil) {
        _flagView = [[UIView alloc] init];
        _flagView.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        
    }
    return _flagView;
}
- (UIImageView *)flagImageView{
    if (_flagImageView == nil) {
        _flagImageView = [[UIImageView alloc] init];
        _flagImageView.backgroundColor = [UIColor clearColor];
        _flagImageView.image = [UIImage imageNamed:@"LaterTime_Flage"];
        
    }
    return _flagImageView;
}
- (void)setModel:(LaterTimeStatisticModel *)model{
    _nameLabel.text = model.name;
    
    CGFloat baseW = kMMWidth - 50 - 50 - 60;
    CGFloat flageW = (baseW * model.timeNumber)/10;
    NSLog(@"flageW = %f  flagView.width=%f flagView.width * model.timeNumber=%f ",flageW,_flagView.width,_flagView.width * model.timeNumber);
    
    [_flagImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(110 + flageW);
        make.centerY.mas_equalTo(@22);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@9);
    }];
  
    
    
}
@end
