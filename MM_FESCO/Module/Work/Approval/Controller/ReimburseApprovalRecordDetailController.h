//
//  ReimburseApprovalRecordDetailController.h
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/11.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "MMBaseViewController.h"
#import "QBImagePickerController.h"
#import "cameraHelper.h"
#import "MPUploadImageHelper.h"
#import "MPImageItemModel.h"
#import "MPImageUploadProgressCell.h"

@interface ReimburseApprovalRecordDetailController : MMBaseViewController

@property (nonatomic, assign) NSInteger dateType;

@property (nonatomic, assign) NSInteger needCity;

@property (nonatomic, strong) NSString *icon; // 标题名称

@property (nonatomic, strong) NSString *endTime; // 标题名称

@property (nonatomic, strong) NSString *startTime; // 标题名称
@property (nonatomic, strong) NSDictionary *dic;


@end
