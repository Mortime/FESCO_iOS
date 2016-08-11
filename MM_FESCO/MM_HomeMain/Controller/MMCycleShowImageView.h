//
//  MMCycleShowImageView.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/11.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMCycleShowImageView : UIView


typedef void(^ImagesTouchUpInsideBlock)(NSUInteger selectedIdx);

//未下载成功、预显示的替换图片
@property (nonatomic, strong) UIImage * placeImage;

//点击图片的回调方法
- (void)dvCycleShowImagesViewTouchUpInside:(ImagesTouchUpInsideBlock)handle;

//存储所有图片路径
@property (nonatomic, strong) NSArray * imagesUrlArray;

//设置方法
- (void)setPageControlLocation:(NSUInteger)location
                       isCycle:(BOOL)cycle;

//刷新数据
- (void)reloadDataWithArray:(NSArray *)array;
@end
