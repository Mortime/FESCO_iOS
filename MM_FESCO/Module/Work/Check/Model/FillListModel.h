//
//  FillListModel.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/6.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "apply_Date" = 1472434596000;
 "apply_Id" = 53;
 "check_Time" = 1472214840000;
 "check_Type" = 2;
 currApprovalMan = "\U80e1\U677e";
 "cust_Addr" = "\U5916\U4f01";
 "cust_Id" = 29;
 "emp_Id" = 163;
 "emp_Name" = "\U80e1\U677e";
 "exam_End_Is" = 2;
 "exam_Step_Is_Over" = 0;
 memo = "\U5fd8\U8bb0\U6253\U5361";
 
 */



@interface FillListModel : NSObject

@property (nonatomic, strong) NSString *applyDate;

@property (nonatomic, strong) NSString *checkTime;

@property (nonatomic, assign) NSInteger checkType; // 1 签到 , 2 签退, 3 外勤

@property (nonatomic, strong) NSString *applePeople;

@property (nonatomic, strong) NSString *custAddress;

@property (nonatomic, assign) NSInteger applyResult; // 0 审批未通过, 1 通过, 2 正在审批 , 

@property (nonatomic, assign) NSInteger stepOver;  // 0 未结束 , 1 结束

@property (nonatomic, strong) NSString *memo;



@end
