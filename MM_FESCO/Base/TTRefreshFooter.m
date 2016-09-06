//
//  TTRefreshFooter.m
//  Headmaster
//
//  Created by ytzhang on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "TTRefreshFooter.h"

@implementation TTRefreshFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initRefreshView];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self initRefreshView];
    }
    return self;
}

- (void)initRefreshView
{
    
    
    self.refreshFooter = [[YiRefreshFooter alloc] init];
    self.refreshFooter.scrollView = self;
    [self.refreshFooter footer];
    
    self.refreshFooter.beginRefreshingBlock=^(){
        
    };
    
}

@end
