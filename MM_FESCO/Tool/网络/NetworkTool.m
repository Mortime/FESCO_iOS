//
//  NetworkTool.m
//  MM_FESCO
//
//  Created by Mortimey on 16/7/27.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NetworkTool.h"

#import "AFNetworking.h"

#import "MMLoginController.h"
#import "JZUserLoginManager.h"

#define  HOST_LINE_DOMAIN  @"https://www.payrollpen.com/payroll" // 正式服务器地址

#define  HOST_TEST_DAMIAN  @"https://11.0.197.196:8443/payroll"   // 测试服务器地址  rui

//#define  HOST_TEST_DAMIAN  @"https://11.0.197.211:8443/payroll"   // 测试服务器地址  tu  https://192.168.0.39:8090

//#define  HOST_TEST_DAMIAN  @"https://192.168.0.39:8090/payroll"   // 测试服务器地址  tu  https://192.168.0.39:8090

//#define QA_TEST

@implementation AFHttpClient

+ (instancetype)sharedClient {
    
    static AFHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:[NetworkTool domain]]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"application/x-javascript",@"text/plain",@"image/gif",@"image/*", nil];
        NSString *cerPath = [[NSBundle mainBundle] pathForResource:kHttpsCerKey ofType:@"cer"];
        NSData * certData =[NSData dataWithContentsOfFile:cerPath];
        MMLog(@"certData == %@",certData);
        NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        
        securityPolicy.allowInvalidCertificates = YES;
        //validatesDomainName 是否需要验证域名，默认为YES；
         securityPolicy.validatesDomainName = NO;
        [securityPolicy setPinnedCertificates:certSet];
        _sharedClient.securityPolicy  = securityPolicy;
        [_sharedClient setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
            DLog(@"setSessionDidBecomeInvalidBlock");
        }];
        [_sharedClient setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
            NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
            __autoreleasing NSURLCredential *credential =nil;
            if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
                if([_sharedClient.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                    credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                    if(credential) {
                        disposition =NSURLSessionAuthChallengeUseCredential;
                    } else {
                        disposition =NSURLSessionAuthChallengePerformDefaultHandling;
                    }
                } else {
                    disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
                }
            } else {
                // client authentication
                SecIdentityRef identity = NULL;
                SecTrustRef trust = NULL;
                NSString *p12 = [[NSBundle mainBundle] pathForResource:@"clientkey"ofType:@"p12"];
                NSFileManager *fileManager =[NSFileManager defaultManager];
                
                if(![fileManager fileExistsAtPath:p12])
                {
                    NSLog(@"client.p12:not exist");
                }
                else
                {
                    NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                    
                    if ([NSString extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
                    {
                        SecCertificateRef certificate = NULL;
                        SecIdentityCopyCertificate(identity, &certificate);
                        const void*certs[] = {certificate};
                        CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                        credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                        disposition =NSURLSessionAuthChallengeUseCredential;
                    }
                }
            }
            *_credential = credential;
            return disposition;
        }];

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
        
        
        // 当请求超时时直接跳转到登录界面(默认为7天)
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"time out"]) {
            [[UserInfoModel defaultUserInfo] loginOut];
            MMLoginController *logninVC = (MMLoginController *)[JZUserLoginManager loginController];
            ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = logninVC;

        }
        
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
