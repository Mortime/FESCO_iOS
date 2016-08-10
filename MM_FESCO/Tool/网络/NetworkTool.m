//
//  NetworkTool.m
//  MM_FESCO
//
//  Created by Mortimey on 16/7/27.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NetworkTool.h"

#import "AFNetworking.h"

#define  HOST_TEST_DAMIAN  @"http://101.200.204.240:8181/api"   // 测试服务器地址

//#define  HOST_LINE_DOMAIN  @"http://jzapi.yibuxueche.com/api"   // 正式服务器地址  http://api.epetbar.com/gutouv2

//#define  HOST_LINE_DOMAIN  @"http://api.epetbar.com/gutouv2"    http://11.0.142.214:8080


#define  HOST_LINE_DOMAIN  @"http://www.payrollpen.com"

//#define  HOST_LINE_DOMAIN  @"http://11.0.147.115:8080/payroll"   // 接口测试

//#define QA_TEST

@implementation AFHttpClient

+ (instancetype)sharedClient {
    
    static AFHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:[NetworkTool domain]]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"application/x-javascript",@"text/plain",@"image/gif", nil];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        
        
    
        
//        //接收无效的证书 默认是NO
//        _sharedClient.securityPolicy.allowInvalidCertificates = YES;
//        
//        //不验证域名,默认是YES
//        _sharedClient.securityPolicy.validatesDomainName = NO;
        

        [_sharedClient.requestSerializer setValue:[[UserInfoModel defaultUserInfo] token] forHTTPHeaderField:@"authorization"];
        
        //        [_sharedClient.requestSerializer setValue:@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiI1NjU4MmNhZjFmY2YwM2Q4MTNmNWZiZmMiLCJ0aW1lc3RhbXAiOiIyMDE1LTExLTI5VDA1OjI2OjM3LjAxNFoiLCJhdWQiOiJibGFja2NhdGUiLCJpYXQiOjE0NDg3NzQ3OTd9.FkiYdCgKMWFpYV2Bymbg8hAGrmutMTEHpfcOsAMnT-8" forHTTPHeaderField:@"authorization"];
        
    });
    
    return _sharedClient;
}
@end

@implementation NetworkTool

+ (NSString *)domain
{
#ifdef QA_TEST
    return HOST_TEST_DAMIAN;
#else
    return HOST_LINE_DOMAIN;
#endif
}

#pragma mark - 设置请求头
+ (void)setHTTPHeaderField:(NSString *)string {
    
    [[AFHttpClient sharedClient].requestSerializer setValue:string forHTTPHeaderField:@"authorization"];
}

#pragma mark - AFN网络请求
#pragma mark POST请求
+ (void)POST:(NSString *)path
      params:(NSDictionary *)params
     success:(NetworkSuccessBlock)success
     failure:(NetworkFailureBlock)failure {
    
    AFHttpClient *manager = [AFHttpClient sharedClient];
    
    [manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success == nil) return;
        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return;
        failure(error);

    }];
    
    }

#pragma mark GET请求
+ (void)GET:(NSString *)path
     params:(NSDictionary *)params
    success:(NetworkSuccessBlock)success
    failure:(NetworkFailureBlock)failure {
    
    AFHttpClient *manager = [AFHttpClient sharedClient];
    
    NSLog(@"*8888888888-===================");
    
    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success == nil) return;
        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure == nil) return;
        failure(error);
    }];
    
}


/**
 *  错误处理
 */
+ (void)missParagramerCallBackFailure:(NetworkFailureBlock)failure
{
    NSError * error = [NSError errorWithDomain:@"Deomin" code:0
                                      userInfo:@{@"error":@"缺少参数"}];
    failure(error);
}

#pragma mark -
#pragma mark 取消网络请求
+ (void)cancelAllRequest {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}
@end
