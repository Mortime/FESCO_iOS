//
//  OverTimeStatisticModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/10/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "OverTimeStatisticModel.h"

@implementation OverTimeStatisticModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{
             @"name":@"emp_Name",
             @"timeNumber":@"duration"
             };
}

@end
