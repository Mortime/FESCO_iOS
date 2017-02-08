//
//  DVVImagePickerControllerManager.m
//  studentDriving
//
//  Created by 大威 on 16/1/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVImagePickerControllerManager.h"
#import "PFActionSheetView.h"
#import "BLPFAlertView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation DVVImagePickerControllerManager

+ (void)showImagePickerControllerFrom:(UIViewController *)fromController delegate:(id)delegate {
    
    [PFActionSheetView showAlertWithTitle:nil message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"拍照",@"从相册选取"] withVc:fromController completion:^(NSUInteger selectedOtherButtonIndex) {
        
        if (selectedOtherButtonIndex == 0) {
            
            // 检测摄像头的状态
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == AVAuthorizationStatusDenied) {
                // 用户拒绝App使用
                
                [BLPFAlertView showAlertWithTitle:@"相机不可用" message:@"请在设置中开启相机服务" cancelButtonTitle:@"知道了" otherButtonTitles:@[ @"去设置" ] completion:^(NSUInteger selectedOtherButtonIndex) {
                    
                    if (0 == selectedOtherButtonIndex) {
                        // 打开应用设置面板
                        [self goAppSet];
                    }
                    
                }];
                
                return ;
            }
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                NSLog(@"camera");
                
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.view.backgroundColor = [UIColor whiteColor];
                picker.allowsEditing = YES;
                picker.delegate = delegate;
                UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeCamera;
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    type = UIImagePickerControllerSourceTypePhotoLibrary;
                }
                picker.sourceType = type;
                
                picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
                
                picker.navigationBar.titleTextAttributes = fromController.navigationController.navigationBar.titleTextAttributes;
                
                [fromController presentViewController:picker animated:YES completion:nil];
                
            }
            
        }else if (selectedOtherButtonIndex == 1) {
            
            // 检测照片库授权状态
            ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
            if (authStatus == ALAuthorizationStatusDenied) {
                // 用户拒绝App使用
                
                [BLPFAlertView showAlertWithTitle:@"相册不可用" message:@"请在设置中开启相册服务" cancelButtonTitle:@"知道了" otherButtonTitles:@[ @"去设置" ] completion:^(NSUInteger selectedOtherButtonIndex) {
                    
                    if (0 == selectedOtherButtonIndex) {
                        // 打开应用设置面板
                        [self goAppSet];
                    }
                    
                }];
                
                return ;
            }
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.view.backgroundColor = [UIColor whiteColor];
                picker.allowsEditing = YES;
                picker.delegate = delegate;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
                picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
                
                picker.navigationBar.titleTextAttributes = fromController.navigationController.navigationBar.titleTextAttributes;
                
                [fromController presentViewController:picker animated:YES completion:nil];
                
                //0x00007ff7f587e0a0
            }
        }
        
    }];
}

+ (void)goAppSet {
    
    // 打开应用设置面板
    NSURL *appSettingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:appSettingUrl];
}

@end
