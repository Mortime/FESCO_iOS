//
//  UploadFile.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "UploadFile.h"
#import <JSONKit.h>


@interface UploadFile ()<NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation UploadFile
// 拼接字符串
static NSString *boundaryStr = @"--";   // 分隔字符串
static NSString *randomIDStr;           // 本次上传标示字符串
static NSString *uploadID;              // 上传(php)脚本中，接收文件字段



- (instancetype)init
{
    self = [super init];
    if (self) {
        //        randomIDStr = @"itcast";
        randomIDStr = @"V2ymHFg03ehbqgZCaKO6jy";
        uploadID = @"uploadFile";
    }
    return self;
}

#pragma mark - 私有方法
- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"\r\n%@%@\r\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", uploadID,uploadFile];
    [strM appendFormat:@"Content-Type: %@\r\n\r\n", mimeType];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

- (NSString *)bottomString:(NSString *)key value:(NSString *)value
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"\r\n%@%@\r\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
    [strM appendFormat:@"%@\r\n",value];
    
    
    NSLog(@"%@", strM);
    return [strM copy];
}

#pragma mark - 上传文件
- (void)uploadFileWithURL:(NSURL *)url imageUrl:(NSString *)imageUrl  imgIndex:(NSInteger)imgIndex
{
    // 1> 数据体
    
    NSMutableData *dataM = [NSMutableData data];
    
    //    [dataM appendData:[boundaryStr dataUsingEncoding:NSUTF8StringEncoding]];
    

//        [dataM appendData:[imageUrl dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *dataImage = UIImageJPEGRepresentation([UIImage imageNamed:imageUrl], 0.5);
//    [dataM appendData:dataImage];
     NSString *topStr = [self topStringWithMimeType:@"image/png" uploadFile:imageUrl];
    [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    [dataM appendData:dataImage];
    
    NSString *bottomStr = [self bottomString:[NSString stringWithFormat:@"上传图片%lu",imgIndex] value:[NSString stringWithFormat:@"图片%lu",imgIndex]];
     // 保存图片描述
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"图片%lu",imgIndex] forKey:@"imgDes"];

    [dataM appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [dataM appendData:[[NSString stringWithFormat:@"%@%@--\r\n", boundaryStr, randomIDStr] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 1. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:20];
    
    // dataM出了作用域就会被释放,因此不用copy
    request.HTTPBody = dataM;
    //    NSLog(@"%@",dataM);
    
    // 2> 设置Request的头属性
    request.HTTPMethod = @"POST";
    
    // 3> 设置Content-Length
    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
    
    // 4> 设置Content-Type
    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    
    
    // 3> 连接服务器发送请求
//    [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"connectionError= %@",error);
//        }
//        
//        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"result= %@", result);
//
//    }];

    
    
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            NSLog(@"connectionError= %@",connectionError);
        }
        
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"result= %@", result);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"myDictionary= %@", dic);
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            // 上传成功
            // 保存服务器返回的图片地址
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"path"] forKey:@"imgUrl"];
           
            
        }
        
    }];
}
#pragma mark - 检测上传进度
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    float progress = (float)totalBytesSent / totalBytesExpectedToSend;
    NSLog(@"%f %@", progress, [NSThread currentThread]);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"完成");
}
// 懒加载
- (NSURLSession *)session
{
    if(_session == nil)
    {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _session;
}

-(void)getImageFromPHAsset:(PHAsset *)asset Complete:(Result)result {
    __block NSData *data;
    PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
    if (asset.mediaType == PHAssetMediaTypeImage) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        options.synchronous = YES;
        [[PHImageManager defaultManager] requestImageDataForAsset:asset
                                                          options:options
                                                    resultHandler:
         ^(NSData *imageData,
           NSString *dataUTI,
           UIImageOrientation orientation,
           NSDictionary *info) {
             data = [NSData dataWithData:imageData];
         }];
    }
    
    if (result) {
        if (data.length <= 0) {
            result(nil, nil);
        } else {
            result(data, resource.originalFilename);
        }
    }
}
@end
