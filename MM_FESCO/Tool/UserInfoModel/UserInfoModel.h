//
//  UserInfoModel.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/10.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
//@property(nonatomic,strong)NSString * userID;
//@property(nonatomic,strong)NSString * portrait;
//@property(nonatomic,strong)NSString * name;
//@property(nonatomic,strong)NSString * tel;
@property(nonatomic,strong)NSString *mailNum; // 用户名

@property(nonatomic,strong)NSString *password;  // 用户密码

@property(nonatomic,strong)NSString * token;

@property(nonatomic,strong)NSString * custId;  // 公司id
@property(nonatomic,strong)NSString * custName;

@property(nonatomic,strong)NSString * empId;   // 员工id
@property(nonatomic,strong)NSString * empName;

@property (nonatomic, strong) NSString *loginTime; // 第一登录时间

//@property(nonatomic,strong)NSString * schoolId;
//@property(nonatomic,strong)NSString * schoolName;
//@property(nonatomic,strong)NSString * complaintreminder;
//@property(nonatomic,strong)NSString * newmessagereminder;
//@property(nonatomic,strong)NSString * applyreminder;


+ (UserInfoModel *)defaultUserInfo;

+ (BOOL)isLogin;
- (void)loginOut;
- (BOOL)loginViewDic:(NSDictionary *)info;

//- (NSDictionary *)messageExt;
@end
