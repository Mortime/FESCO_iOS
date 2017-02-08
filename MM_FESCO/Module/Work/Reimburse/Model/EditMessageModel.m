//
//  EditMessageModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/5.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "EditMessageModel.h"

/*
 
 {
 "apply_Id" = 44;
 "bill_Num" = 1;
 "detail_Id" = 73;
 "detail_Memo" = ceshi;
 "emp_Id" = "<null>";
 "expense_Date" = "<null>";
 icon = "<null>";
 "money_Amount" = 700;
 "pic_Ids" = "<null>";
 pics =                 (
 {
 "detail_Id" = 73;
 id = 26;
 "pic_Desc" = "<null>";
 "pic_Url" = "F://expensePics/12/3/20161205150250IMG_0003.JPG";
 },
 {
 "detail_Id" = 73;
 id = 27;
 "pic_Desc" = "<null>";
 "pic_Url" = "F://expensePics/11/11/20161205150250IMG_0002.JPG";
 }
*/

@implementation EditMessageModel
+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"moneyAmount":@"money_Amount",
              @"spendBegin":@"spend_Begin",
              @"spendEnd":@"spend_End",
              @"spendType":@"spend_Type_Str",
              @"detailId":@"detail_Id",
              @"billNum":@"bill_Num",
              @"picArray":@"pics",
              @"cityName":@"spend_City",
              @"spendId":@"spend_Type",
              @"detailMemo":@"detail_Memo"
              
              };
}

@end
