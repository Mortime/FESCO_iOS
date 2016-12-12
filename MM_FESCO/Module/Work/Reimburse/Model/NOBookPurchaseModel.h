//
//  NOBookPurchaseModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/12.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOBookPurchaseModel : NSObject

/*
 {
 "bill_Num" = 0;
 "detail_Id" = 44;
 "detail_Memo" = rrr;
 "emp_Id" = 163;
 "formatted_Date" = "<null>";
 icon = "<null>";
 "money_Amount" = 21;
 "pic_Ids" = "<null>";
 pics =             (
 {
 "detail_Id" = 44;
 id = "<null>";
 "pic_Desc" = "<null>";
 "pic_Url" = "<null>";
 }
 );
 "spend_Begin" = 1481212800000;
 "spend_City" = "<null>";
 "spend_End" = 1481299200000;
 "spend_Type" = "<null>";
 "spend_Type_Str" = "\U627e\U4e0d\U5230\U4e86";
 },

 
 */

@property (nonatomic, assign) NSInteger billNum;  // 发票数 /

@property (nonatomic, assign) NSInteger moneyAmount;   // 金额  /

@property (nonatomic, strong) NSArray *picArray; // 图片信息数组

@property (nonatomic, strong) NSString *spendBegin;  // 开始时间 /

@property (nonatomic, strong) NSString *spendEnd;  // 结束时间  /

@property (nonatomic, strong) NSString *cityName;  // 消费城市

@property (nonatomic, strong) NSString *detailMemo;  //

@property (nonatomic, strong) NSString *spendTypeStr;  // 消费类型

@property (nonatomic, assign) NSInteger spendType; // 消费ID

@property (nonatomic, assign) NSInteger detailId;



@end
