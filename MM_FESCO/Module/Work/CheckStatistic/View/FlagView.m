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

@property (nonatomic, strong) NSArray *imgArray;
@end

@implementation FlagView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        
        [self initUI];
    }
    return self;

}
- (void)initUI{
    for (int i = 0; i < _imgArray.count; i++) {
        
        CGFloat baseViewW = 15;
            
            FlagBaseView *baseView = [[FlagBaseView alloc] initWithFrame:CGRectMake(i * (baseViewW + 15), 0, 15, 15)];
            baseView.imgStr = _imgArray[i];
            [self addSubview:baseView];
    }
}
- (void)initData{
    self.imgArray = @[@"flag_chidao",@"flag_zaotui",@"flag_jiaban",@"flag_jiaqi",@"flag_kuanggong"];
    
    
}
@end
