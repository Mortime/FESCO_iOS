//
//  CollectionFooterView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/26.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "CollectionFooterView.h"

@implementation CollectionFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        view.backgroundColor= [UIColor clearColor];
        [self addSubview:view];
    }
    return self;
}

@end
