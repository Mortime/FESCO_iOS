//
//  ProgressReimburseModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/12.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 
 {
 "apply_Id" = 188;
 "bill_Num" = 1;
 "cust_Id" = "<null>";
 "detail_Id" = 279;
 "detail_Id_Before_Imported" = "<null>";
 "detail_Memo" = "<null>";
 "emp_Id" = "<null>";
 "expense_Date" = "<null>";
 icon = "fa fa-car fa-lg";
 "money_Amount" = 100;
 "pic_Ids" = "<null>";
 pics =                 (
 {
 "detail_Id" = 279;
 id = "<null>";
 "pic_Desc" = "<null>";
 "pic_Url" = "<null>";
 }
 );
 "spend_Begin" = 1484064000000;
 "spend_Begin_Str" = "<null>";
 "spend_City" = "<null>";
 "spend_End" = "<null>";
 "spend_End_Str" = "<null>";
 "spend_Type" = 19;
 "spend_Type_Str" = "\U4ea4\U901a\U8d39-\U505c\U8f66\U8fc7\U8def\U8d39";
 trId = "<null>";
 },
 
 
 */




@interface ProgressReimburseModel : NSObject


@property (nonatomic, strong) NSString *spendType;  // 消费类型

@property (nonatomic, assign) NSInteger billNum;  // 发票数 /

@property (nonatomic, assign) CGFloat moneyAmount;   // 金额  /

@property (nonatomic, strong) NSArray *pics;

@property (nonatomic, strong) NSString *picMemo;  // 图片描述

@property (nonatomic, strong) NSString *spendBegin;  // 开始时间 /

@property (nonatomic, strong) NSString *spendEnd;  // 结束时间  /

@property (nonatomic, strong) NSString *cityName;  // 消费城市

@property (nonatomic, assign) NSInteger spendId; // 消费ID

@property (nonatomic, assign) NSInteger detailId;

@property (nonatomic, strong) NSString *icon;
@end
