//
//  MMLoginTool.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMLoginTool.h"

@implementation MMLoginTool

+ (BOOL)checkCancelAppointmentWithBeginTime {
    
    
    
    
    
    NSString *yyyyStr = [self loginTimeWithFormatString:@"yyyy"];
    NSString *MMStr = [self loginTimeWithFormatString:@"MM"];
    NSString *ddStr = [self loginTimeWithFormatString:@"dd"];
    NSString *HHStr = [self loginTimeWithFormatString:@"HH"];
    
    NSString *currentyyyyStr = [self dateFromLocalWithFormatString:@"yyyy"];
    NSString *currentMMStr = [self dateFromLocalWithFormatString:@"MM"];
    NSString *currentddStr = [self dateFromLocalWithFormatString:@"dd"];
    NSString *currentHHStr = [self dateFromLocalWithFormatString:@"HH"];
    
    BOOL flage = NO;
    //判断年份
    if ([yyyyStr integerValue] >= [currentyyyyStr integerValue]) {
        // 判断月份
        if ([MMStr integerValue] >= [currentMMStr integerValue]) {
            // 判断天
            if ([ddStr integerValue] >= [currentddStr integerValue]) {
                // 相差一天的情况
                if (1 == [ddStr integerValue] - [currentddStr integerValue]) {
                    
                    if (24 - [currentHHStr integerValue] + [HHStr integerValue] > 24) {
                        flage = YES;
                    }
                }else {
                    if ([ddStr integerValue] - [currentddStr integerValue] > 1) {
                        flage = YES;
                    }
                }
            }
        }
    }
    return flage;
}


+ (NSString *)dateFromLocalWithFormatString:(NSString *)formatString {
    
    NSDate *localDate = [NSDate new];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter stringFromDate:localDate];
}
+ (NSString *)loginTimeWithFormatString:(NSString *)formatString{
    
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *date = [dateFormatter dateFromString:[UserInfoModel defaultUserInfo].loginTime];
    //输出格式
    [dateFormatter setDateFormat:formatString];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
@end
