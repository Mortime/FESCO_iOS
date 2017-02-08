//
//  BaseTableController.m
//  Principal
//
//  Created by dawei on 15/11/25.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

#pragma mark 默认从图片中心点开始拉伸图片
+ (UIImage *)resizedImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

#pragma mark 改变图片的大小
+ (UIImage *)resizeImage:(UIImage *)image newSize:(CGSize)newSize;

@end
