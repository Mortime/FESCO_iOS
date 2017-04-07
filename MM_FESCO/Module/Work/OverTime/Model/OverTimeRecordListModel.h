//
//  OverTimeRecordListModel.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 "apply_Date" = 1473037026000;
 "apply_Id" = 513;
 "begin_Time" = 1473036960000;
 currApprovalMan = "\U80e1\U677e";
 "cust_Id" = 29;
 "emp_Id" = 163;
 "emp_Name" = "\U80e1\U677e";
 "end_Time" = 1473036900000;
 "exam_End_Is" = 0; 审批是否通过   1 是通过，2 是正在审批，0 是审批未通过
 "exam_End_Is_Name" = "<null>";
 "exam_Step_Is_Over" = 1;  审批步骤是否结束  0 未结束, 1 结束
 "pay_Money" = "<null>";
 reason = "\U6d4b\U8bd5";
 "time_Unit" = 2;
 "time_Unit_Name" = "<null>";
 "work_Duration" = 1;
 
 
 */
@interface OverTimeRecordListModel : NSObject

@property (nonatomic, strong) NSString *empName;  // 申请人

@property (nonatomic, strong) NSString *applyDate; // 申请时间

@property (nonatomic, strong) NSString *beginTime; // 开始时间

@property (nonatomic, strong) NSString *endTime; // 结束时间

@property (nonatomic, assign) NSInteger statusType; // 审批状态

@property (nonatomic, strong) NSString *applyMan;  // 审批人

@property (nonatomic, strong) NSString *holBeginApm;

@property (nonatomic, strong) NSString *holEndApm;


@end
