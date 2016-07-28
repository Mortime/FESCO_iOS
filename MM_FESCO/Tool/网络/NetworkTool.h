//
//  NetworkTool.h
//  MM_FESCO
//
//  Created by Mortimey on 16/7/27.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

typedef void (^NetworkSuccessBlock) (id responseObject);
typedef void (^NetworkFailureBlock) (NSError *failure);


@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end


@interface NetworkTool : NSObject

+ (NSString *)domain;

/**
 *  设置请求头
 */
+ (void)setHTTPHeaderField:(NSString *)string;

/**
 *  AFN get请求
 *
 *  @param path URL地址
 *
 *  @param params 请求参数 (NSDictionary)
 *
 *  @param success 请求成功返回值（NSArray or NSDictionary）
 *
 *  @param failure 请求失败值 (NSError)
 */
+ (void)GET:(NSString *)path
     params:(NSDictionary *)params
    success:(NetworkSuccessBlock)success
    failure:(NetworkFailureBlock)failure;

/**
 *  AFN post请求
 *
 *  @param path URL地址
 *
 *  @param params 请求参数 (NSDictionary)
 *
 *  @param success 请求成功返回值（NSArray or NSDictionary）
 *
 *  @param failure 请求失败值 (NSError)
 */
+ (void)POST:(NSString *)path
      params:(NSDictionary *)params
     success:(NetworkSuccessBlock)success
     failure:(NetworkFailureBlock)failure;


///**
// *  AFN POST上传图片
// *
// *  @param path URL地址
// *
// *  @param params 请求参数 (NSDictionary)
// *
// *  @param success 请求成功返回值（NSArray or NSDictionary）
// *
// *  @param images 需要上传的图片数组，二进制格式的图片
// *
// *  @param failure 请求失败值 (NSError)
// */
//+ (void)postWithImagePath:(NSString *)path
//                   params:(NSDictionary *)params
//                   images:(NSArray *)images
//                  success:(NetworkSuccessBlock)success
//                  failure:(NetworkFailureBlock)failure;

/**
 *  错误处理
 */
+ (void)missParagramerCallBackFailure:(NetworkFailureBlock)failure;

/**
 *   取消网络请求
 */
+ (void)cancelAllRequest;
@end
