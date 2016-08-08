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
 *  用户教练登录 返回信息描述见 获取用户详情
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
        NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"mob/login.json"];
        
        NSDictionary * dic = @{@"login_Name":photoNumber,
                               @"password":password,
                               @"deviceId":deviceId,
                               @"deviceType":deviceType
                               
                               };
        NSLog(@"url ------ %@, %@",urlStr,dic);
        

[NetworkTool POST:urlStr params:dic success:success failure:failure];
    }
    



@end
