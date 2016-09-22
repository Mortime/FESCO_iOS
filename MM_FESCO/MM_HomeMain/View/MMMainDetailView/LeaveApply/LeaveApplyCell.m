//
//  LeaveApplyCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveApplyCell.h"

@interface LeaveApplyCell ()

@property (nonatomic, strong) NSMutableArray *resultUnitArray;

@end

@implementation LeaveApplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return  self;
}
- (void)initUI{
    self.resultUnitArray = [NSMutableArray array];
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
    
    if (_index == 3000) {
        _textFile.dataArray = _holTypeArray;
    }
    if (_index == 3001) {
        [_resultUnitArray removeAllObjects];
        for (NSNumber *unit in _unitsArray) {
            
            if ([unit integerValue] == 1) {
                [_resultUnitArray addObject:@"天"];
            }
            if ([unit integerValue] == 2) {
                [_resultUnitArray addObject:@"小时"];
            }
            if ([unit integerValue] == 3) {
                [_resultUnitArray addObject:@"半天"];
            }
        }
        
        _textFile.dataArray = _resultUnitArray;
    }
    // 显示日期PickView
    if (_index == 3002 || _index == 3003 ) {
        _textFile.isShowDataPickView = YES;
    }
    // 不显示PickView
    if (_index == 3004) {
        _textFile.isExist = YES;
    }
    if (_index == 3005) {
        _textFile.dataArray = _pickData;
    }
    
    // 剩余假期
    if (_index == 3006) {
        _textFile.isExist = YES;
        _textFile.userInteractionEnabled = NO;
        _textFile.rightTextFiled.text = _holNumberStr;
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
