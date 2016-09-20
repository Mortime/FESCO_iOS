//
//  LeaveApplyCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveApplyCell.h"

@implementation LeaveApplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return  self;
}
- (void)initUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.textFile];
}
- (void)layoutSubviews{
    [self.textFile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.mas_bottom);
        
    }];
    
    _textFile.tag = _index;
    
    // 显示日期PickView
    if (_index == 3000 || _index == 3001 ) {
        _textFile.isShowDataPickView = YES;
    }
    if (_index == 3003) {
        _textFile.dataArray = @[@"天",@"小时",@"半天"];
    }
    // 不显示PickView
    if (_index == 3002 || _index == 3004) {
        _textFile.isExist = YES;
    }
    if (_index == 3005) {
        _textFile.dataArray = _pickData;
    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
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
@end
