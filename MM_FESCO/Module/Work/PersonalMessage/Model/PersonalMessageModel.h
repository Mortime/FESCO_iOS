//
//  PersonalMessageModel.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/22.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalMessageModel : NSObject

/* 
 
 responseObject =  {
address = "<null>";
email = "hu.song@fesco.com.cn";
"emp_Id" = 163;
"emp_Name" = "\U80e1\U677e";
gender = 1;
mobile = 18611279997;
phone = "010-65874733";
weixinid = hughsong;
zipcode = "<null>";
}

*/


@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *email;

@property (nonatomic, strong) NSString *empID;

@property (nonatomic, strong) NSString *empName;

@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *weixinid;

@property (nonatomic, assign) NSInteger gender;  // 1 男; 2 女

@property (nonatomic, strong) NSString *zipcode;



@end
