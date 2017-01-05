//
//  ReimburseApprovalListModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/4.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "ReimburseApprovalListModel.h"

@implementation ReimburseApprovalListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"accountId": @"account_Id",
              @"applyDate":@"apply_Date",
              @"typeStr":@"type_Str",
              @"applyId":@"apply_Id"
              };
}
@end
