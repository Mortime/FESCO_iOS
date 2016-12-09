//
//  ReimburseApplyManModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ReimburseApplyManModel.h"

@implementation ReimburseApplyManModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"empId":@"emp_Id",
              @"empName":@"emp_Name"
              };
}

@end
