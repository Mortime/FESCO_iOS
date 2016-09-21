//
//  LeavaRecordListModel.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 
 "appl_Date" = 1472000636000;
 currApprovalMan = "\U89e3\U671d\U8f89";
 "cust_Id" = 29;
 "emp_Id" = 163;
 "emp_Name" = "\U80e1\U677e";
 "exam_End_Is" = 2;
 "exam_End_Is_Name" = "<null>";
 "exam_Step_Is_Over" = 0;
 "group_Name" = "<null>";
 "hol_Begin" = 1471968000000;
 "hol_Begin_Apm" = "\U4e0b\U5348";
 "hol_Begin_Str" = "<null>";
 "hol_Emp_Exam_Id" = 760;
 "hol_End" = 1471968000000;
 "hol_End_Apm" = "\U4e0b\U5348";
 "hol_End_Str" = "<null>";
 "hol_Name" = "\U5e74\U5047";
 "hol_Num" = "0.5";
 "hol_Num_Str" = "<null>";
 "hol_Set_Id" = 63;
 "hol_Source" = "<null>";
 "hol_Unit" = 1;
 momo = "\U670b\U53cb\U6709\U4e8b\U5e2e\U5fd9";
 "pay_Money" = "26.27257799671592";


 
 */
@interface LeavaRecordListModel : NSObject


@property (nonatomic, strong) NSString *empName;  // 申请人

@property (nonatomic, strong) NSString *applyDate; // 申请时间

@property (nonatomic, strong) NSString *beginTime; // 开始时间

@property (nonatomic, strong) NSString *endTime; // 结束时间

@property (nonatomic, strong) NSString *holName; // 假期名称

@property (nonatomic, assign) NSInteger statusType; // 审批状态

@property (nonatomic, strong) NSString *currApprovalMan; // 审批人



@end
