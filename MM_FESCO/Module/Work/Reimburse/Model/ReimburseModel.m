

//
//  ReimburseModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ReimburseModel.h"

/*
 
 "account_Id" = 1922226633855887;
 "account_Name" = "<null>";
 "apply_Date" = 1479744000000;
 "apply_Date_Str" = "<null>";
 "apply_Id" = 33;
 "approval_Man" = "<null>";
 "cust_Id" = 29;
 details =             (
 {
 "apply_Id" = 33;
 "bill_Num" = 1;
 "detail_Id" = "<null>";
 "detail_Memo" = ceshi;
 "emp_Id" = "<null>";
 "expense_Date" = "<null>";
 icon = "<null>";
 "money_Amount" = 400;
 "pic_Ids" = "<null>";
 pics =                     (
 );
 "spend_Begin" = 1479657600000;
 "spend_Begin_Str" = "<null>";
 "spend_City" = "\U5b89\U9633";
 "spend_End" = 1479744000000;
 "spend_End_Str" = "<null>";
 "spend_Type" = 17;
 "spend_Type_Str" = "\U957f\U9014-\U7070\U673a";
 trId = "<null>";
 }
 );
 "edit_Time" = 1479967835000;
 
 
 "emp_Id" = 163;
 "emp_Name" = "<null>";
 "exam_End_Is" = 0;
 "exam_End_Is_Str" = "<null>";
 "exam_Step_Is_Over" = 0;
 "exam_Step_Is_Over_Str" = "<null>";
 "group_Id" = 94;
 "group_Name" = "<null>";
 memo = ceshi;
 "money_Sum" = "<null>";
 "search_Begin" = "<null>";
 "search_End" = "<null>";
 title = ceshi;
 type = 1;
 "type_Str" = "\U65e5\U5e38\U62a5\U9500\U5355";
 
 */

@implementation ReimburseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"statusReimburse":@"exam_End_Is",
              @"typeStr":@"type_Str",
              @"editTime":@"edit_Time",
              @"applyDate":@"apply_Date",
              @"applyId":@"apply_Id",
              @"accountName":@"account_Name",
              @"accountId":@"account_Id",
              @"groupId":@"group_Id",
              @"moneySum":@"money_Sum"
              
              };
}

@end
