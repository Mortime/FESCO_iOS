//
//  OverTimeListModel.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 list =     (
 {
 "apply_Date" = 1469579159000;
 "apply_Id" = 332;
 "begin_Time" = 1469482200000;
 currApprovalMan = "<null>";
 "cust_Id" = 29;
 "emp_Id" = 4289;
 "emp_Name" = "\U82ae\U7ee7\U4f1f";
 "end_Time" = 1469493000000;
 "exam_End_Is" = 2;
 "exam_End_Is_Name" = "<null>";
 "exam_Step_Is_Over" = 0;
 "pay_Money" = "<null>";
 reason = "\U8d22\U52a1\U5916\U5305\U7cfb\U7edf\U6dfb\U52a0\U529f\U80fd";
 "time_Unit" = 2;
 "time_Unit_Name" = "<null>";
 "work_Duration" = 3;
 }
 );

 */

@interface OverTimeListModel : NSObject

@property (nonatomic, strong) NSString *applyDate; // 申请时间

@property (nonatomic, strong) NSString *beginTime; // 开始时间

@property (nonatomic, strong) NSString *endTime; // 结束时间

@property (nonatomic, strong) NSString *empName;  // 申请人

@property (nonatomic, strong) NSString *reason; // 申请原因

@property (nonatomic, assign) NSInteger applyid; // 申请id

@end
