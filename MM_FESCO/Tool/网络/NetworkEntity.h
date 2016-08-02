//
//  NetworkEntity.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkTool.h"
#import "AFNetworking.h"

@interface NetworkEntity : NSObject


/**
 *  测试接口数据 GET
 */
+ (void)getTesTInfoWithUserInfoWithUserId:(NSString *)userId
                                  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;



/**
 *  测试接口数据 POST
 *
 *  @param param     测试字段
 */
+ (void)postTestParam:(NSString *)param success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

@end
