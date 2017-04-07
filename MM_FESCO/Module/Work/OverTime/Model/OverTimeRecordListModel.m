//
//  OverTimeRecordListModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "OverTimeRecordListModel.h"

@implementation OverTimeRecordListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"applyDate": @"apply_Date",
              @"beginTime":@"begin_Time",
              @"empName":@"emp_Name",
              @"endTime":@"end_Time",
              @"statusType":@"exam_End_Is",
              @"applyMan":@"currApprovalMan",
              @"holBeginApm":@"hol_Begin_Apm",
              @"holEndApm":@"hol_End_Apm"

              };
}

@end
