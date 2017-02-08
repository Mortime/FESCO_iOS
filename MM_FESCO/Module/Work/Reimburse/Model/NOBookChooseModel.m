//
//  NOBookChooseModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NOBookChooseModel.h"

@implementation NOBookChooseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"moneyAmount":@"money_Amount",
              @"spendBegin":@"spend_Begin",
              @"spendEnd":@"spend_End",
              @"spendTypeStr":@"spend_Type_Str",
              @"detailId":@"detail_Id",
              @"billNum":@"bill_Num",
              @"picUrl":@"pic_Url",
              @"detailMemo":@"detail_Memo",
              @"picMemo":@"pic_Desc",
              @"cityName":@"spend_City",
              @"spendType":@"spend_Type"
              
              };
}

@end
