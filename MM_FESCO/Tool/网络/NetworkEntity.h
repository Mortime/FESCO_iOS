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



+ (void)postHomeMainListWithParamMD5:(NSString *)paramMD5  menthodname:(NSString *)menthodname tokenkeyID:(NSString *)tokenkey secret:(NSString *)secret success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *  用户教练登录 返回信息描述见 获取用户详情
 *
 *  @param photoNumber （req）  手机号
 *  @param password     (req)  密码 MD5加密后
 *  @param deviceId （req）  设备唯一标识
 *  @param deviceType     (req)  设备类型 (iOS : 1 ,android : 0);
 
 */
+ (void)postLoginWithPhotoNumber:(NSString *)photoNumber password:(NSString *)password deviceId:(NSString *)deviceId deviceType:(NSString *)deviceType   success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;


/**
 *   HomeMain ======== 加载个人信息
 
 *  @param custid （req）  公司id
 *  @param emptId     (req)  员工id

 */
+ (void)postPersonMessageWithCustId:(NSString *)custid emptId:(NSString *)emptId tokenkeyID:(NSString *)tokenkey   sign:(NSString *)sign  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;


///**
// *  测试接口数据 POST
// *
// *  @param param     测试字段
// */
//+ (void)postTestParam:(NSString *)param success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

@end
