//
//  ReimburseApplyManModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 address = "<null>";
 "certificate_No" = 22;
 "certificate_Type" = 4;
 "cust_Id" = 29;
 "cust_Inter_No" = "<null>";
 "departure_Time" = "<null>";
 email = "hu.song@fesco.com.cn";
 "emp_Id" = 163;
 "emp_Name" = "\U80e1\U677e";
 "emp_Status" = 1;
 "endowment_Rate" = "<null>";
 "entry_Time" = "<null>";
 "exam_Authority" = 1;
 "extra_Work_Authority" = 0;
 gender = 1;
 "group_Id" = 6;
 "group_Name" = "<null>";
 "housing_Fund_Rate" = "<null>";
 "injury_Rate" = "<null>";
 isspecial = 0;
 "login_Name" = husong;
 "login_Password" = "f9uiGzKzuGu6G2GsGnoKtQ==";
 "maternity_Rate" = "<null>";
 "medical_Rate" = "<null>";
 memo = "<null>";
 methodname = "<null>";
 mobile = 18611279997;
 modifier = "\U80e1\U677e";
 "modify_Time" = 1481126400000;
 nationality = "<null>";
 "other_Item1" = "<null>";
 "other_Item10" = "<null>";
 "other_Item11" = "<null>";
 "other_Item12" = "<null>";
 "other_Item13" = "<null>";
 "other_Item14" = "<null>";
 "other_Item15" = "<null>";
 "other_Item16" = "<null>";
 "other_Item17" = "<null>";
 "other_Item18" = "<null>";
 "other_Item19" = "<null>";
 "other_Item2" = 8000;
 "other_Item20" = "<null>";
 "other_Item21" = "<null>";
 "other_Item22" = "<null>";
 "other_Item23" = "<null>";
 "other_Item24" = "<null>";
 "other_Item25" = "<null>";
 "other_Item26" = "<null>";
 "other_Item27" = "<null>";
 "other_Item28" = "<null>";
 "other_Item29" = "<null>";
 "other_Item3" = "<null>";
 "other_Item30" = "<null>";
 "other_Item31" = "<null>";
 "other_Item32" = "<null>";
 "other_Item33" = "<null>";
 "other_Item34" = "<null>";
 "other_Item35" = "<null>";
 "other_Item36" = "<null>";
 "other_Item37" = "<null>";
 "other_Item38" = "<null>";
 "other_Item39" = "<null>";
 "other_Item4" = "<null>";
 "other_Item40" = "<null>";
 "other_Item5" = "<null>";
 "other_Item6" = "<null>";
 "other_Item7" = "<null>";
 "other_Item8" = "<null>";
 "other_Item9" = "<null>";
 phone = "010-65874734";
 "photo_Url" = "<null>";
 position = "<null>";
 salary = 8000;
 "synch_time" = 1459872000000;
 "tax_Base" = 3500;
 "unemployment_Rate" = "<null>";
 "weixin_Status" = 1;
 weixinid = hughsong;
 "yearly_Hol_Num" = "<null>";
 zipcode = "<null>";
 },

 */

@interface ReimburseApplyManModel : NSObject

@property (nonatomic, assign) NSInteger empId;

@property (nonatomic, strong) NSString *empName;
@end
