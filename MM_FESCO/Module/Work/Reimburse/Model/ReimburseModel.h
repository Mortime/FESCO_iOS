//
//  ReimburseModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 "account_Id" = 1922226633855887;
 "account_Name" = "<null>";
 "apply_Date" = 1479744000000;
 "apply_Date_Str" = "<null>";
 "apply_Id" = 33;
 "approval_Man" = "<null>";
 "cust_Id" = 29;
 details =      
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
@interface ReimburseModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) NSInteger statusReimburse; // 0待提交，1待审批，2待支付，3未通过，4已支付

@property (nonatomic, strong) NSString  *typeStr;  //  报销单类型

@property (nonatomic, strong) NSArray *details;

@property (nonatomic, strong) NSString *editTime; // 报销时间

@property (nonatomic, strong) NSString *applyDate; // 申请时间

@property (nonatomic, assign) NSInteger applyId;  // 申请ID

@property (nonatomic, strong) NSString *accountName; // 姓名

@property (nonatomic, assign) NSInteger accountId;  // 银行卡号

@property (nonatomic, strong) NSString *memo;

@property (nonatomic, assign) NSInteger groupId; // 报销部门id

@property (nonatomic, assign) NSInteger moneySum; // 金钱总金额



@end
