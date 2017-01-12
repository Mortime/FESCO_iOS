//
//  EditMessageModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/5.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

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




@interface EditMessageModel : NSObject

@property (nonatomic, strong) NSString *spendType;  // 消费类型

@property (nonatomic, assign) NSInteger billNum;  // 发票数 /

@property (nonatomic, assign) CGFloat moneyAmount;   // 金额  /

@property (nonatomic, strong) NSArray *picArray; // 图片信息数组

@property (nonatomic, strong) NSString *spendBegin;  // 开始时间 /

@property (nonatomic, strong) NSString *spendEnd;  // 结束时间  /

@property (nonatomic, strong) NSString *cityName;  // 消费城市

@property (nonatomic, assign) NSInteger spendId; // 消费ID

@property (nonatomic, assign) NSInteger detailId;

@property (nonatomic, strong) NSString *detailMemo;  // 消费城市


@end
