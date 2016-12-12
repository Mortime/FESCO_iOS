//
//  NewPurchaseBookController.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMBaseViewController.h"

#import "QBImagePickerController.h"
#import "cameraHelper.h"
#import "MPUploadImageHelper.h"
#import "MPImageItemModel.h"
#import "MPImageUploadProgressCell.h"
@interface NewPurchaseBookController : MMBaseViewController

@property (nonatomic, assign) NSInteger dateType;

@property (nonatomic, assign) NSInteger needCity;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSString *typePurchaseStr; //  长途-飞机 或者  补助 ...

@property (nonatomic, strong) NSString *icon; // 标题名称

@end
