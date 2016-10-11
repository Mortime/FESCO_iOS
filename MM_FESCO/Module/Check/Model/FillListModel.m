//
//  FillListModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/6.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "FillListModel.h"

@implementation FillListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"applyDate": @"apply_Date",
              @"checkTime":@"check_Time",
              @"checkType":@"check_Type",
              @"applePeople":@"currApprovalMan",
              @"custAddress":@"cust_Addr",
              @"applyResult":@"exam_End_Is",
              @"stepOver":@"exam_Step_Is_Over"};
}

@end
