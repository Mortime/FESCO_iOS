//
//  LeavaRecordListModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeavaRecordListModel.h"

@implementation LeavaRecordListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"applyDate": @"appl_Date",
              @"beginTime":@"hol_Begin",
              @"empName":@"emp_Name",
              @"endTime":@"hol_End",
              @"holName":@"hol_Name",
              @"statusType":@"exam_End_Is",
              @"currApprovalMan":@"currApprovalMan",
              @"leaveID":@"hol_Emp_Exam_Id",
              @"holBeginApm":@"hol_Begin_Apm",
              @"holEndApm":@"hol_End_Apm"
              };
}

@end
