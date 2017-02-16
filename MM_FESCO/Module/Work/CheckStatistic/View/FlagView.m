//
//  FlagView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "FlagView.h"
#import "FlagBaseView.h"



@interface FlagView ()

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *colorArray;
@end

@implementation FlagView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initData];

        [self initUI];
           }
    return self;
}
- (void)initUI{
    for (int i = 0; i < _titleArray.count; i++) {
        
        CGFloat baseViewW = kMMWidth / 3;
        CGFloat baseViewH = self.height / 2;
        if (i < 3) {
            
            FlagBaseView *baseView = [[FlagBaseView alloc] initWithFrame:CGRectMake(i * baseViewW, 0, baseViewW, baseViewH)];
            baseView.titleStr = _titleArray[i];
            baseView.titleColor = [UIColor colorWithHexString:_colorArray[i]];
            [self addSubview:baseView];
        }else{
            FlagBaseView *baseView = [[FlagBaseView alloc] initWithFrame:CGRectMake((i - 3) * baseViewW, baseViewH, baseViewW, baseViewH)];
            baseView.titleStr = _titleArray[i];
            baseView.titleColor = [UIColor colorWithHexString:_colorArray[i]];
            [self addSubview:baseView];

        }
    }
}
- (void)initData{
    self.titleArray = @[@"正常",@"迟到",@"早退",@"旷工",@"请假",@"加班"];
    self.colorArray = @[@"ffffff",@"ffdfbd",@"e4bdff",@"ffbdbd",@"bfffbd",@"bdbfff"];
    
}
@end
