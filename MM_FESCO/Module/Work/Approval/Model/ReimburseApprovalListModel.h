//
//  ReimburseApprovalListModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/4.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 "account_Id" = 1401;
 "account_Name" = "<null>";
 "apply_Date" = 1483459200000;
 "apply_Date_Str" = "<null>";
 "apply_Id" = 164;
 "approval_Man" = "<null>";
 "cust_Id" = 29;
 details =             (
 {
 "apply_Id" = 164;
 "bill_Num" = 1;
 "cust_Id" = "<null>";
 "detail_Id" = 238;
 "detail_Id_Before_Imported" = "<null>";
 "detail_Memo" = Ceshi;
 "emp_Id" = "<null>";
 "expense_Date" = "<null>";
 icon = "<null>";
 "money_Amount" = 100;
 "pic_Ids" = "<null>";
 pics =                     (
 {
 "detail_Id" = 238;
 id = "<null>";
 "pic_Desc" = "<null>";
 "pic_Url" = "<null>";
 }
 );
 "spend_Begin" = 1483459200000;
 "spend_Begin_Str" = "<null>";
 "spend_City" = "<null>";
 "spend_End" = "<null>";
 "spend_End_Str" = "<null>";
 "spend_Type" = 19;
 "spend_Type_Str" = "\U4ea4\U901a-\U5730\U94c1";
 trId = "<null>";
 }
 );
 "edit_Time" = 1483499867000;
 "emp_Id" = 163;
 "emp_Name" = "<null>";
 "exam_End_Is" = 1;
 "exam_End_Is_Str" = "<null>";
 "exam_Step_Is_Over" = 0;
 "exam_Step_Is_Over_Str" = "<null>";
 "group_Id" = 4;
 "group_Name" = "<null>";
 memo = Ceshi;
 "money_Sum" = "<null>";
 "search_Begin" = "<null>";
 "search_End" = "<null>";
 title = OO;
 type = 2;
 "type_Str" = "\U5dee\U65c5\U62a5\U9500\U5355";
 },

 
 */



@interface ReimburseApprovalListModel : NSObject


@property (nonatomic, assign) NSInteger accountId;

@property (nonatomic, assign) NSInteger applyId;

@property (nonatomic, strong) NSString *applyDate; // 申请时间

@property (nonatomic, strong) NSArray *details;

@property (nonatomic, strong) NSString *memo;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *typeStr; 

@end
