//
//  NetworkEntity.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NetworkEntity.h"

@implementation NetworkEntity

/**
 *   首页标签信息
 */
+ (void)postHomeMainListWithParamMD5:(NSString *)paramMD5  menthodname:(NSString *)menthodname tokenkeyID:(NSString *)tokenkey secret:(NSString *)secret success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    
    // sign， jsonParam
    

    
    // jsonParam={"menthodname":"getAppMenu","tokenkey":"42711...154"}
    
    // TMz/bhZ8WBP/V5CE7iOTGmqu42yOrSJrWSh9BXbE4ZIP+RjwgWufiWd9rjPFlIi4
    if (!paramMD5) {
                return [NetworkTool missParagramerCallBackFailure:failure];
    }
        NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"getMenu.json"];
    NSLog(@"mainHomeUrlstr  %@",urlStr);
    
    
    NSString *str = @"{'methodname':'getMenu'}";
    
    NSDictionary * dic = @{@"sign":paramMD5,
                           
                           @"jsonParam":str,
                           
                           @"tokenkey":tokenkey
                           
                           };

    
    NSLog(@"mainHomeUrlstrdic  %@",dic);
    [NetworkTool POST:urlStr params:dic success:success failure:failure];

}



/**
 *  测试接口数据 GET
 */
//+ (void)getTesTInfoWithUserInfoWithUserId:(NSString *)userId
//                                  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure
//{
//    if (!userId) {
//        return [NetworkTool missParagramerCallBackFailure:failure];
//    }
//    NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],userId];
//    [NetworkTool GET:urlStr params:nil success:success failure:failure];
//}


/**
 *  用户登录 
 *
 *  @param photoNumber （req）  手机号
 *  @param password     (req)  密码 MD5加密后
 *  @param deviceId （req）  设备唯一标识
 *  @param deviceType     (req)  设备类型 (iOS : 1 ,android : 0);
 
 */

+ (void)postLoginWithPhotoNumber:(NSString *)photoNumber password:(NSString *)password deviceId:(NSString *)deviceId deviceType:(NSString *)deviceType   success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure
    {
        if (!photoNumber || !password) {
            return [NetworkTool missParagramerCallBackFailure:failure];
        }
        NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"login.json"];
        
        NSDictionary * dic = @{@"login_Name":photoNumber,
                               @"password":password,
                               @"deviceId":deviceId,
                               @"deviceType":deviceType
                               
                               };
        NSLog(@"url ------ %@, %@",urlStr,dic);
        

[NetworkTool POST:urlStr params:dic success:success failure:failure];
    }
    

/**
 *   加载个人信息
 */
+ (void)postPersonMessageWithCustId:(NSString *)custid emptId:(NSString *)emptId tokenkeyID:(NSString *)tokenkey   sign:(NSString *)sign  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure
{
    if (!custid || !emptId) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
    
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"emp/loadEmpInfo.json"];
    
    
//    NSString *custidStr = [NSString stringWithFormat:@"'cust_Id':'%@'",custid];
//    NSString *empStr = [NSString stringWithFormat:@"'emp_Id':'%@'",emptId];
//    NSString *str = @"'methodname':'emp/loadEmpInfo.json'";
//    
//    NSString *resultStr = [NSString stringWithFormat:@"{%@,%@,%@}",custidStr,empStr,str];
//    
//    MMLog(@"test ==== test json parnnn    1 %@",resultStr);

    NSDictionary *jsonParam = @{@"cust_Id":custid,
                                @"emp_Id":emptId,
                                @"methodname":@"emp/loadEmpInfo.json"};
    
    NSString *resultStr =  [NSString jsonToJsonStingWith:jsonParam];
    
    
    
    
    NSDictionary * dic = @{@"jsonParam":resultStr,
                           
                           @"sign":sign,
                           
                           @"tokenkey":tokenkey
                           

                           };
    NSLog(@"url ------ %@, %@",resultStr,dic);
    
    
    [NetworkTool POST:urlStr params:dic success:success failure:failure];
}

/**
 *   HomeMain ======== 个人信息修改
 
 *  @param emptId     (req)  员工id
 
 */

+ (void)postSubmitPersonMessageWithEmpId:(NSString *)empId empName:(NSString *)empName  gender:(NSString *)gender mobile:(NSString *)mobile phone:(NSString *)phone weixinid:(NSString *)weixinid email:(NSString *)email address:(NSString *)address zipcode:(NSString *)zipcode  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    if (!empId ) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
    NSLog(@"%@",address);
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"emp/updateEmpInfo.json"];
    
    
    NSString *sexTag = @"";
    if ([gender isEqualToString:@"男"]) {
        sexTag = @"1";
    }
    if ([gender isEqualToString:@"女"]) {
        sexTag = @"2";
    }
    NSDictionary *param  = @{@"emp_Name":empName,
                                 @"emp_Id":empId,
                                 @"methodname":@"emp/updateEmpInfo.json",
                                 @"gender":sexTag,
                                 @"phone":phone,
                                 @"mobile":mobile,
                                 @"email":email,
                                 @"weixinid":weixinid,
                                 @"address":address,
                                 @"zipcode":zipcode
                                };
    NSString *sign = [NSString sortKeyWith:param];
    NSString *jsonParamStr = [NSString jsonToJsonStingWith:param];
    
    MMLog(@"MMMMsign ====%@       MMMjsonParamStr ===== =======%@",sign,jsonParamStr);
    
    
    

    
    NSDictionary * dic = @{@"jsonParam":jsonParamStr,
                           
                           @"sign":sign,
                           
                           @"tokenkey":[UserInfoModel defaultUserInfo].token
                           
                           };
    NSLog(@"url ------ %@",dic);
    
    
    [NetworkTool POST:urlStr params:dic success:success failure:failure];

}
+ (void)postPhoneNumberListWithCustId:(NSString *)custid  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    if (!custid ) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
    NSDictionary *dic = @{@"cust_Id":custid,
                          @"methodname":@"getAllPhoneNumber.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"getAllPhoneNumber.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                           
                           @"sign":sign,
                           
                           @"tokenkey":[UserInfoModel defaultUserInfo].token
                           
                           
                           };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}
@end
