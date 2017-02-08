//
//  ProgressShowModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/19.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgressShowModel : NSObject
/*
 "apply_Id" = 362;
 approvalTime = "<null>";
 "approval_Man" = 163;
 "approval_Man_Str" = "\U80e1\U677e";
 "approval_Time" = 1484794607000;
 "is_Other_Party" = "<null>";
 "is_Over" = 1;
 "is_Pass" = 0;
 "is_Pass_Str" = "\U672a\U901a\U8fc7";
 memo = "<null>";
 "next_Approval_Man" = "<null>";
 "step_Id" = 288;
 
 */

@property (nonatomic, assign) NSInteger applyId;  // 申请ID

@property (nonatomic, strong) NSString *approvalTime;  // 申请时间

@property (nonatomic, assign) NSInteger approvalMan;  // 申请人ID

@property (nonatomic, strong) NSString *approvalManStr;  // 申请人

@property (nonatomic, strong) NSString *isPassStr;  // 审批信息

@property (nonatomic, strong) NSString *memo;


@end
