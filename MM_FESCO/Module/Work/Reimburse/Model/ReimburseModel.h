//
//  ReimburseModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
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

@end
