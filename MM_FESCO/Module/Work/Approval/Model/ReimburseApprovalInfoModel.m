//
//  ReimburseApprovalInfoModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/5.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "ReimburseApprovalInfoModel.h"

@implementation ReimburseApprovalInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"accountId": @"account_Id",
              @"applyDate":@"apply_Date",
              @"typeStr":@"type_Str",
              @"applyId":@"apply_Id"
              };
}
@end
