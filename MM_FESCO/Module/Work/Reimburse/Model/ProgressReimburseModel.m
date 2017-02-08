//
//  ProgressReimburseModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/12.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "ProgressReimburseModel.h"

@implementation ProgressReimburseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"moneyAmount":@"money_Amount",
              @"spendBegin":@"spend_Begin",
              @"spendEnd":@"spend_End",
              @"spendType":@"spend_Type_Str",
              @"detailId":@"detail_Id",
              @"billNum":@"bill_Num",
              @"picUrl":@"pic_Url",
              @"spendMemo":@"detail_Memo",
              @"picMemo":@"pic_Desc",
              @"cityName":@"spend_City",
              @"spendId":@"spend_Type"
              
              };
}

@end
