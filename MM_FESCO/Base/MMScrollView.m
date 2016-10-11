//
//  MMScrollView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/10.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMScrollView.h"

@implementation MMScrollView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer.state != 0) {
        return YES;
    } else {
        return NO;
    }
}

@end
