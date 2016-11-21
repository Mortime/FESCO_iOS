

//
//  ReimburseModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ReimburseModel.h"

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

@implementation ReimburseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"statusReimburse":@"exam_End_Is",
              @"typeStr":@"type_Str"
              
              };
}

@end
