//
//  UploadFile.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

typedef void(^MMUploadSccessBlock)(NSDictionary *data);


typedef void(^Result)(NSData *data, NSString *fileName);

@protocol UploadFiledProgressDelegate <NSObject>

- (void)uploadFiledProgressDelegateWithSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;

@end

@interface UploadFile : NSObject
// 上传图片
- (void)uploadFileWithURL:(NSURL *)url imageUrl:(NSString *)imageUrl  imgIndex:(NSInteger)imgIndex  successBlock:(MMUploadSccessBlock)success;

-(void)getImageFromPHAsset:(PHAsset *)asset Complete:(Result)result;

@property (nonatomic,weak) id <UploadFiledProgressDelegate> delegate;

@end
