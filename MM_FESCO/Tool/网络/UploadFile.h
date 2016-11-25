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

@interface UploadFile : NSObject
// 上传图片
- (void)uploadFileWithURL:(NSURL *)url imageUrl:(NSString *)imageUrl  imgIndex:(NSInteger)imgIndex  successBlock:(MMUploadSccessBlock)success;

-(void)getImageFromPHAsset:(PHAsset *)asset Complete:(Result)result;

@end
