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
@property(nonatomic,strong)NSString *mailNum;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString * token;
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
