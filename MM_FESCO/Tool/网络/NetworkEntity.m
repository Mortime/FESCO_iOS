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
+ (void)getTesTInfoWithUserInfoWithUserId:(NSString *)userId
                                  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure
{
    if (!userId) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],userId];
    [NetworkTool GET:urlStr params:nil success:success failure:failure];
}


/**
 *  测试接口数据 POST
 *
 *  @param param     测试字段
 */

+ (void)postTestParam:(NSString *)param success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    if (!param)  {
        return [NetworkTool missParagramerCallBackFailure:failure];
    };
    NSDictionary * dic = @{@"param":param,
                        
                           };
    
    [NetworkTool POST:@"headmaster/userinfo/userlogin" params:dic success:success failure:failure];
}


@end
