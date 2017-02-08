//
//  SignUpApprovalListModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/18.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "SignUpApprovalListModel.h"

@implementation SignUpApprovalListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"applyDate": @"apply_Date",
              @"beginTime":@"check_Time",
              @"empName":@"emp_Name",
              @"applyid":@"apply_Id",
              @"checkType":@"check_Type"
              };
}

@end
