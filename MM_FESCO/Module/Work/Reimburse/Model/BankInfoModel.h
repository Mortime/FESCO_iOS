//
//  BankInfoModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "bank_Account_Status" = 1;
 "bank_Account_Status_Str" = "<null>";
 "bank_Pay_Name" = "\U80e1\U677e";
 "bank_Type" = 1;
 "bank_Type_Str" = "<null>";
 "bank_Use" = 0;
 "bank_Use_Str" = "<null>";
 "cust_Id" = 29;
 "emp_Bank_Id" = 1401;
 "emp_Bank_No" = 1922226633855887;
 "emp_Id" = 163;
 "emp_Name" = "<null>";
 modifier = "husong82@foxmail.com";
 "modify_Time" = "<null>";
 "open_Bank" = "\U4e2d\U56fd\U94f6\U884c";

 
 */
@interface BankInfoModel : NSObject

@property (nonatomic, assign) NSInteger bankNumber;

@property (nonatomic, strong) NSString *bankPayName;

@property (nonatomic, assign) NSInteger empBankId;

@end
