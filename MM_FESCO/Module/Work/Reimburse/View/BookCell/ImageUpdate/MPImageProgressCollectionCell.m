//
//  MPImageProgressCollectionCell.m
//  MobileProject
//
//  Created by wujunyang on 16/7/22.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "MPImageProgressCollectionCell.h"
#import "UploadFile.h"



@interface MPImageProgressCollectionCell()

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
            [self.contentView addSubview:_deleteBtn];
        }
        
        if (!_progressView) {
            _progressView=[[M13ProgressViewPie alloc]initWithFrame:CGRectMake(kImageCollectionCell_Width-25, kImageCollectionCell_Width-25, 20, 20)];
            _progressView.primaryColor=[UIColor whiteColor];
            _progressView.secondaryColor=[UIColor grayColor];
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
                
                UploadFile *upload = [[UploadFile alloc] init];
                 NSString *urlString = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"expense/uploadPic.json"];
                
                PHFetchResult *fetchResult = [PHAsset fetchAssetsWithALAssetURLs:@[self.curImageItem.assetURL] options:nil];
                PHAsset *asset = fetchResult.firstObject;
                
                
                [upload getImageFromPHAsset:asset Complete:^(NSData *data, NSString *fileName) {
                    
                    NSString *str  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    
                    MMLog(@"dataStr = %@===fileName =%@",str,fileName);
                    
                    
                    [upload  uploadFileWithURL:[NSURL URLWithString:urlString] imageUrl:fileName  imgIndex:_imgIndex successBlock:^(NSDictionary *data) {
                        MMLog(@"picIds = %@",data);
                        
                        /*
                         errcode = 0;
                         picIds =     (
                         11
                         );
                         */
                        if ([[data objectForKey:@"errcode"] integerValue] == 0) {
                            // 对图片ID加入数组
                            [_picIDArray addObject:[data objectForKey:@"picIds"][0]];
                        }
                        [[NSUserDefaults standardUserDefaults] setObject:_picIDArray forKey:@"picID"];
                        [[NSNotificationCenter defaultCenter] postNotificationName:kGetPicIDNotifition object:self];
                        
                    }];
                    
                    
                }];
                
}
        }];
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
