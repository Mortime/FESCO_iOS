//
//  LeaveApprovalListModel.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/18.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "appl_Date" = 1472790037000;
 currApprovalMan = "<null>";
 "cust_Id" = 29;
 "emp_Id" = 1678;
 "emp_Name" = "\U674e\U9e4f";
 "exam_End_Is" = 1;
 "exam_End_Is_Name" = "<null>";
 "exam_Step_Is_Over" = 1;
 "group_Name" = "<null>";
 "hol_Begin" = 1472794200000;
 "hol_Begin_Apm" = "<null>";
 "hol_Begin_Str" = "<null>";
 "hol_Emp_Exam_Id" = 802;
 "hol_End" = 1472808600000;
 "hol_End_Apm" = "<null>";
 "hol_End_Str" = "<null>";
 "hol_Name" = "\U8c03\U4f11";
 "hol_Num" = 4;            // 请假时长
 "hol_Num_Str" = "<null>";
 "hol_Set_Id" = 141;
 "hol_Source" = "History_Num:4.0;";
 "hol_Unit" = 2;
 momo = "\U5012\U4f11";
 "pay_Money" = 0;

 
 */
@interface LeaveApprovalListModel : NSObject

@property (nonatomic, strong) NSString *empName;  // 申请人

@property (nonatomic, strong) NSString *applyDate; // 申请时间

@property (nonatomic, strong) NSString *beginTime; // 开始时间

@property (nonatomic, strong) NSString *endTime; // 结束时间

@property (nonatomic, strong) NSString *name; // 假期名称



@end
