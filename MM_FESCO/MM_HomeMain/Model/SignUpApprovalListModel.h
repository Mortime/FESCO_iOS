//
//  SignUpApprovalListModel.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/18.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "apply_Date" = 1473411707000;
 "apply_Id" = 106;
 "check_Time" = 1473411600000;
 "check_Type" = 1;
 currApprovalMan = "<null>";
 "cust_Addr" = "\U4e39\U68f1\U88575\U53f7";
 "cust_Id" = 29;
 "emp_Id" = 163;
 "emp_Name" = "\U80e1\U677e";
 "exam_End_Is" = 2;
 "exam_Step_Is_Over" = 0;
 memo = Fff;
 */


@interface SignUpApprovalListModel : NSObject


@property (nonatomic, strong) NSString *empName;  // 申请人

@property (nonatomic, strong) NSString *applyDate; // 申请时间

@property (nonatomic, strong) NSString *beginTime; // 开始时间

@property (nonatomic, assign) NSInteger checkType;  // 签到类型 1 签到 , 2 签退, 3 外勤

@property (nonatomic, assign) NSInteger applyid; // 申请id


@end
