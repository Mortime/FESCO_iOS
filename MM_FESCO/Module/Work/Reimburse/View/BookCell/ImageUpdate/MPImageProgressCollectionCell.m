//
//  MPImageProgressCollectionCell.m
//  MobileProject
//
//  Created by wujunyang on 16/7/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "MPImageProgressCollectionCell.h"

@interface MPImageProgressCollectionCell()<UploadFiledProgressDelegate>

@property(nonatomic,strong)M13ProgressViewPie *progressView;

@property(nonatomic)CGFloat propress;

@property (nonatomic, strong) NSMutableArray *picIDArray;

@end

@implementation MPImageProgressCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (!_imgView) {
            _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kImageCollectionCell_Width, kImageCollectionCell_Width)];
            _imgView.contentMode = UIViewContentModeScaleAspectFill;
            _imgView.clipsToBounds = YES;
            _imgView.layer.masksToBounds = YES;
            _imgView.layer.cornerRadius = 2.0;
            self.picIDArray = [NSMutableArray array];
            [self.contentView addSubview:_imgView];
        }
        
        if (!_deleteBtn) {
            _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(kImageCollectionCell_Width-20, 0, 20, 20)];
            _deleteBtn.hidden=YES;
            [_deleteBtn setImage:[UIImage imageNamed:@"btn_right_delete_image"] forState:UIControlStateNormal];
            _deleteBtn.backgroundColor = [UIColor blackColor];
            _deleteBtn.layer.cornerRadius = CGRectGetWidth(_deleteBtn.bounds)/2;
            _deleteBtn.layer.masksToBounds = YES;
            
            [_deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//            [self.contentView addSubview:_deleteBtn];
        }
        
        if (!_progressView) {
            _progressView=[[M13ProgressViewPie alloc]initWithFrame:CGRectMake(kImageCollectionCell_Width-15, kImageCollectionCell_Width-15, 15, 15)];
            _progressView.primaryColor=[UIColor whiteColor];
            _progressView.secondaryColor= MM_MAIN_FONTCOLOR_BLUE;
            [self.contentView addSubview:_progressView];
        }
    }
    return self;
}


-(void)setCurImageItem:(MPImageItemModel *)curImageItem
{
    _curImageItem=curImageItem;
    if (_curImageItem) {
        
        _imgView.image=curImageItem.thumbnailImage;
        if (curImageItem.isUpload) {
            _deleteBtn.hidden = YES;
            
            RAC(self.imgView, image) = [RACObserve(self.curImageItem, thumbnailImage)takeUntil:self.rac_prepareForReuseSignal];
            
            if (self.curImageItem.image&&_curImageItem.uploadState==MPImageUploadStateSuccess) {
                self.deleteBtn.hidden=NO;
                self.progressView.hidden=YES;
            }
            else if (self.curImageItem.image&&_curImageItem.uploadState!=MPImageUploadStateSuccess)
            {
                self.deleteBtn.hidden=YES;
                self.progressView.hidden=NO;
            }
            else
            {
                self.deleteBtn.hidden=YES;
                self.progressView.hidden=YES;
            }
            //上传任务，并赋值给当前propress
            MPWeakSelf(self)
            [[RACObserve(self.curImageItem, image) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(UIImage *imageItem) {
                MPStrongSelf(self)
                if (imageItem&&self.curImageItem.uploadState!=MPImageUploadStateSuccess) {
                    
                    //                                UploadFile *upload = [[UploadFile alloc] init];
                    //                                upload.delegate = self;
                    //                                 NSString *urlString = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"expense/uploadPic.json"];
                    //
                    //                                PHFetchResult *fetchResult = [PHAsset fetchAssetsWithALAssetURLs:@[self.curImageItem.assetURL] options:nil];
                    //                                PHAsset *asset = fetchResult.firstObject;
                    //
                    //                NSData* imageData = UIImagePNGRepresentation(self.curImageItem.thumbnailImage);
                    //                NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                    //                NSString* totalPath = [documentPath stringByAppendingPathComponent:@"userAvatar"];
                    //
                    //                //保存到 document
                    //                [imageData writeToFile:totalPath atomically:NO];
                    //
                    //                //保存到 NSUserDefaults
                    //                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    //                [userDefaults setObject:totalPath forKey:@"avatar"];
                    //
                    //
                    //
                    //                                [upload  uploadFileWithURL:[NSURL URLWithString:urlString] imageUrl:totalPath  imgIndex:_imgIndex successBlock:^(NSDictionary *data) {
                    //                                        MMLog(@"picIds = %@",data);
                    //
                    //                                        /*
                    //                                         errcode = 0;
                    //                                         picIds =     (
                    //                                         11
                    //                                         );
                    //                                         */
                    //                                        if ([[data objectForKey:@"errcode"] integerValue] == 0) {
                    //                                            // 对图片ID加入数组
                    //                                            [_picIDArray addObject:[data objectForKey:@"picIds"][0]];
                    //                                        }
                    //                                        [[NSUserDefaults standardUserDefaults] setObject:_picIDArray forKey:@"picID"];
                    //                                        [[NSNotificationCenter defaultCenter] postNotificationName:kGetPicIDNotifition object:self];
                    //
                    //                                    }];
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    //                UploadFile *upload = [[UploadFile alloc] init];
                    //                upload.delegate = self;
                    //                 NSString *urlString = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"expense/uploadPic.json"];
                    //
                    //                PHFetchResult *fetchResult = [PHAsset fetchAssetsWithALAssetURLs:@[self.curImageItem.assetURL] options:nil];
                    //                PHAsset *asset = fetchResult.firstObject;
                    //
                    //
                    //                [upload getImageFromPHAsset:asset Complete:^(NSData *data, NSString *fileName) {
                    //
                    //                    NSString *str  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    //
                    //
                    //                    MMLog(@"dataStr = %@===fileName =%@",str,fileName);
                    //                    NSURL *UEL   = self.curImageItem.assetURL;
                    //
                    //                    NSString *urlStr = [UEL absoluteString];
                    //                    [upload  uploadFileWithURL:[NSURL URLWithString:urlString] imageUrl:urlStr  imgIndex:_imgIndex successBlock:^(NSDictionary *data) {
                    //                        MMLog(@"picIds = %@",data);
                    //
                    //                        /*
                    //                         errcode = 0;
                    //                         picIds =     (
                    //                         11
                    //                         );
                    //                         */
                    //                        if ([[data objectForKey:@"errcode"] integerValue] == 0) {
                    //                            // 对图片ID加入数组
                    //                            [_picIDArray addObject:[data objectForKey:@"picIds"][0]];
                    //                        }
                    //                        [[NSUserDefaults standardUserDefaults] setObject:_picIDArray forKey:@"picID"];
                    //                        [[NSNotificationCenter defaultCenter] postNotificationName:kGetPicIDNotifition object:self];
                    //
                    //                    }];
                    //
                    //
                    //                }];
                    
                    
                    
                    
                    //1.创建管理者对象
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    NSString *urlString = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"expense/uploadPic.json"];
                    
                    //2.上传文件
                    //                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"image.png",@"uploadFile",nil];
                    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                        
                        
                        NSData* imageData = UIImagePNGRepresentation(self.curImageItem.image);
                        NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                        NSString* totalPath = [documentPath stringByAppendingPathComponent:@"bookImage"];
                        
                        //保存到 document
                        [imageData writeToFile:totalPath atomically:NO];
                        UIImage *selfPhoto = [UIImage imageWithContentsOfFile:totalPath];
                        
                        NSData *photeoData11 = UIImageJPEGRepresentation(selfPhoto, 0.5);
                        
                        
                        // 可以在上传时使用当前的系统事件作为文件名
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        // 设置时间格式
                        formatter.dateFormat            = @"yyyyMMddHHmmss";
                        NSString *str                         = [formatter stringFromDate:[NSDate date]];
                        NSString *fileName               = [NSString stringWithFormat:@"%@.png", str];
                        
                        
                        
                        //上传文件参数
                        [formData appendPartWithFileData:photeoData11 name:@"uploadFile" fileName:fileName mimeType:@"image/png"];
                        
                    } progress:^(NSProgress * _Nonnull uploadProgress) {
                        
                        //打印上传进度
                        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
                        MMLog(@"==============oooooo%.2lf%%", progress);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.propress=progress;
                        });
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        //请求成功
                        MMLog(@"请求成功：%@",responseObject);
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {  
                        
                        //请求失败  
                        MMLog(@"请求失败：%@",error);
                        
                    }];     
                    
                    
                    
                }
            }];
        }
    }
    else
    {
        _imgView.image = [UIImage imageNamed:@"btn_addPicture_BgImage"];
        if (_deleteBtn) {
            _deleteBtn.hidden = YES;
        }
        
        if (_progressView) {
            _progressView.hidden=YES;
        }
    }
}

- (void)uploadFiledProgressDelegateWithSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    
    CGFloat propress = totalBytesWritten*1.0/totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.propress=propress;
    });

}
-(void)setPropress:(CGFloat)propress
{
    _propress=propress;
    MPWeakSelf(self)
    if (_propress) {
        [[RACObserve(self, propress) takeUntil:
          [RACSignal combineLatest:@[self.rac_prepareForReuseSignal, self.rac_willDeallocSignal]]]
         subscribeNext:^(NSNumber *fractionCompleted) {
             MPStrongSelf(self)
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.progressView setProgress:fractionCompleted.floatValue animated:YES];
                 if (fractionCompleted.floatValue>=1) {
                     //上传完成修改一些相应的状态
                     self.curImageItem.uploadState=MPImageUploadStateSuccess;
                     self.progressView.hidden=YES;
                     self.deleteBtn.hidden=NO;
                     
                     //删除沙盒里面的对应图片
                     [MPFileManager deleteUploadDataWithName:self.curImageItem.photoName];
                 }
                 else
                 {
                     self.curImageItem.uploadState=MPImageUploadStateIng;
                     self.progressView.hidden=NO;
                     self.deleteBtn.hidden=YES;
                 }
             });
         }];
    }
    else
    {
        self.progressView.hidden=YES;
    }
}


- (void)deleteBtnClicked:(id)sender{
    if (_deleteImageBlock) {
        _deleteImageBlock(_curImageItem);
    }
}

+(CGSize)ccellSize{
    return CGSizeMake(kImageCollectionCell_Width,kImageCollectionCell_Width);
}

@end
