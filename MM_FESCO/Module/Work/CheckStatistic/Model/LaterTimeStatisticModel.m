//
//  LaterTimeStatisticModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/10/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LaterTimeStatisticModel.h"

@implementation LaterTimeStatisticModel
+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{
              @"name":@"emp_Name",
              @"timeNumber":@"counts"
              };
}

@end
