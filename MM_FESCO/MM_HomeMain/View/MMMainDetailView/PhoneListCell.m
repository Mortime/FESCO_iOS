//
//  PhoneListCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/25.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PhoneListCell.h"

@implementation PhoneListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //		NSLog(@"%s", __func__);
    }
    return self;
}

- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    
    _phoneListVC.view.frame = self.bounds;
    _phoneListVC.view.frame = self.bounds;
    _phoneListVC.urlString = urlString;
    [self addSubview:_phoneListVC.view];
}


@end
