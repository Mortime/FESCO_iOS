//
//  NewPurchaseRecordModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/18.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 {
 "bill_Num" = 1;
 "detail_Id" = 8;
 "detail_Memo" = Ce;
 "emp_Id" = 163;
 "formatted_Date" = "<null>";
 "money_Amount" = 900;
 "pic_Desc" = "\U56fe\U7247900";
 "pic_Url" = "F://expensePics/14/13/20161118102754IMG_0002.JPG";
 "spend_Begin" = 1478966400000;
 "spend_City" = "\U5b89\U9633";
 "spend_End" = 1479139200000;
 "spend_Type" = 17;
 "spend_Type_Str" = "\U957f\U9014-\U7070\U673a";
 }

 
 */
@interface NewPurchaseRecordModel : NSObject

@property (nonatomic, assign) NSInteger moneyAmount;

@property (nonatomic, strong) NSString *spendBegin;

@property (nonatomic, strong) NSString *spendEnd;

@property (nonatomic, strong) NSString *spendType;

@property (nonatomic, assign) NSInteger detailId;



@end
