//
//  FDCalendar.h
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FDCalendarDelegate <NSObject>



@end

@interface FDCalendar : UIView
@property (nonatomic, strong) UIViewController *paramentVC;

- (instancetype)initWithCurrentDate:(NSDate *)date;

@end
