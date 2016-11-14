//
//  BankInfoModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "BankInfoModel.h"

@implementation BankInfoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"bankNumber":@"emp_Bank_No",
              @"bankPayName":@"bank_Pay_Name"
              };
}

@end
