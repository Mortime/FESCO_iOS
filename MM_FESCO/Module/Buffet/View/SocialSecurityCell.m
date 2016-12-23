//
//  SocialSecurityCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/23.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "SocialSecurityCell.h"


@interface SocialSecurityCell ()


@end
@implementation SocialSecurityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.socialTextFiledView];
}
- (void)layoutSubviews{
    [self.socialTextFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (SocialSecurityCellView *)socialTextFiledView{
    if (_socialTextFiledView == nil) {
        _socialTextFiledView = [[SocialSecurityCellView alloc] init];
    }
    return   _socialTextFiledView;
}
@end
