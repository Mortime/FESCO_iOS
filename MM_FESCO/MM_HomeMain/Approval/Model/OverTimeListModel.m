//
//  OverTimeListModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "OverTimeListModel.h"

@implementation OverTimeListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"applyDate": @"apply_Date",
              @"beginTime":@"begin_Time",
              @"endTime":@"end_Time",
              @"empName":@"emp_Name",
              @"applyid":@"apply_Id"
            };
}
@end
