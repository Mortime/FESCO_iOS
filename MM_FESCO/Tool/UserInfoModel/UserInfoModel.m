//
//  UserInfoModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/10.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "UserInfoModel.h"


#define USERINFO_IDENTIFY       @"USERINFO_IDENTIFY"

@implementation UserInfoModel (private)

#pragma mark - StoreDefaults
+ (void)storeData:(id)data forKey:(NSString *)key
{
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defults setObject:data forKey:key];
    [defults synchronize];
}

+ (id)dataForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * data = [defaults objectForKey:key];
    return data;
}
+ (void)removeDataForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

@end

@implementation UserInfoModel

+ (UserInfoModel *)defaultUserInfo
{
    static UserInfoModel * userInfoModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!userInfoModel) {
            userInfoModel = [[self alloc] init];
        }
    });
    return userInfoModel;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        if ([[self class] isLogin]) {
            [self loginViewDic:[[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData]];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tonkenChangeNotifition) name:kTonkenChangeNotifition object:nil];

        }
    }
    return self;
}

+ (BOOL)isLogin
{
    return [[self class] dataForKey:USERINFO_IDENTIFY] != nil;
}

- (void)loginOut
{
    [[self class] removeDataForKey:USERINFO_IDENTIFY];
}

- (BOOL)loginViewDic:(NSDictionary *)info
{
    
    
   /*
    responseObject{
        SUCCESS = success;
        "cust_Id" = 1091;
        "cust_Name" = test123;
        "emp_Id" = 4403;
        "emp_Name" = "\U5f20\U4e94";
        token = "e72ffsla7z3y6DULSlISld8DL2yOef7Oj+DBpbuHfudSByzrZWOuelnxV+Ydshr3JebMySz3bhZ9
        \n4dseSTLfuw==";
    }
    */    
    self.token = [info objectForKey:@"token"];
    
    self.mailNum = [info objectForKey:@"MM_phoneNum"];
    
    self.password = [info objectForKey:@"MM_password"];
    
    self.custId = [info objectForKey:@"cust_Id"];
    
    self.custName = [info objectForKey:@"cust_Name"];
    
    self.empId = [info objectForKey:@"emp_Id"];
    
    self.empName = [info objectForKey:@"emp_Name"];
    
    self.loginTime = [info objectForKey:@"MM_loginTime"];
    self.loginPasswordMD5 = [info objectForKey:@"login_Password"];
    
    
    if (![[self class] isLogin]) {
        [[self class] storeData:[info JSONData] forKey:USERINFO_IDENTIFY];
    }
    return YES;
}

//- (NSDictionary *)messageExt
//{
//    if (![[self class] isLogin]) {
//        return nil;
//    }
//    return  @{
//              @"userId":[[UserInfoModel defaultUserInfo] userID],
//              @"nickName":[[UserInfoModel defaultUserInfo] name],
//              @"headUrl":[[UserInfoModel defaultUserInfo] portrait],
//              @"userType":@"2"
//              };
//}
- (void)tonkenChangeNotifition{
    // 接受到通知
    [NetworkEntity postGetNewTokenkey:self.token Success:^(id responseObject) {
        
        MMLog(@"getNewToken =responseObject ======%@",responseObject);
        
        //  ERROR = "get token error.";
        // token = "";
        
        //SUCCESS = success;
        //  token = 3e9b5e3478e21fc320c9a835eae1733f;
        if ([[responseObject objectForKey:@"SUCCESS"] isEqualToString:@"success"]) {
            
            self.token = [responseObject objectForKey:@"token"];
        }
        

    } failure:^(NSError *failure) {
        MMLog(@"getNewToken = ===failure===========%@",failure);
    }];
    
}
@end
