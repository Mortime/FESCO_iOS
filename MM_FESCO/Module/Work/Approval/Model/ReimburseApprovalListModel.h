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
 "apply_Date" = 1483718400000;
 "apply_Date_Str" = "<null>";
 "apply_Id" = 190;
 "approval_Man" = "<null>";
 "cust_Id" = 29;
 details = "<null>";
 "edit_Time" = 1484189829000;
 "emp_Id" = 163;
 "emp_Name" = "<null>";
 "exam_End_Is" = 1;
 "exam_End_Is_Str" = "<null>";
 "exam_Step_Is_Over" = 0;
 "exam_Step_Is_Over_Str" = "<null>";
 "group_Id" = 10;
 "group_Name" = "<null>";
 memo = "<null>";
 "money_Sum" = 11;
 "search_Begin" = "<null>";
 "search_End" = "<null>";
 title = Cass;
 type = 1;
 "type_Str" = "\U65e5\U5e38\U62a5\U9500\U5355";
 
 */



@interface ReimburseApprovalListModel : NSObject


@property (nonatomic, assign) NSInteger accountId;

@property (nonatomic, assign) NSInteger applyId;

@property (nonatomic, strong) NSString *applyDate; // 申请时间

@property (nonatomic, strong) NSArray *details;

@property (nonatomic, strong) NSString *memo;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *typeStr;

@property (nonatomic, strong) NSString *empName;

@property (nonatomic, assign) CGFloat moneySum;


@end
