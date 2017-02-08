//
//  ProgressShowModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/19.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "ProgressShowModel.h"

@implementation ProgressShowModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"applyId":@"apply_Id",
              @"approvalTime":@"approval_Time",
              @"approvalMan":@"approval_Man",
              @"approvalManStr":@"approval_Man_Str",
              @"isPass":@"is_Pass",
              @"isPassStr":@"is_Pass_Str"
              
              };
}


@end
