//
//  DVVImagePickerControllerManager.h
//  studentDriving
//
//  Created by 大威 on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVVImagePickerControllerManager : NSObject

+ (void)showImagePickerControllerFrom:(UIViewController *)fromController delegate:(id)delegate;

@end
