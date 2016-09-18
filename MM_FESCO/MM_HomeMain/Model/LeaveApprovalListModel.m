//
//  LeaveApprovalListModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/18.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveApprovalListModel.h"

@implementation LeaveApprovalListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"applyDate": @"apply_Date",
              @"beginTime":@"hol_Begin",
              @"empName":@"emp_Name",
              @"endTime":@"hol_End",
              @"name":@"hol_Name",
              @"applyId":@"hol_Emp_Exam_Id"
              };
}

@end
