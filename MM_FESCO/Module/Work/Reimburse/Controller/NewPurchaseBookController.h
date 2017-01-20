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
#import "NOBookPurchaseModel.h"


@protocol NewPurchaseBookControllerDelegate <NSObject>

- (void)newPurchaseBookControllerDelegateWith:(NSMutableArray *)array sectionTag:(NSInteger)sectionTag;

@end

@interface NewPurchaseBookController : MMBaseViewController


@property (nonatomic, assign) NSInteger dateType;

@property (nonatomic, assign) NSInteger needCity;

@property (nonatomic, strong) NSString *typePurchaseStr; //  长途-飞机 或者  补助 ...

@property (nonatomic, assign) RePurchaseBookType bookType;

@property (nonatomic, strong) NSMutableArray *urlArray;

// 保存时提交服务器数据

@property (nonatomic, strong) NSString *moneyNumber;  // 金额

@property (nonatomic, strong) NSString *startTime; // 开始时间

@property (nonatomic, strong) NSString *endTime; // 结束时间

@property (nonatomic, strong) NSString *billNumber; // 发票

@property (nonatomic, strong) NSString *picUrl; // 照片链接

@property (nonatomic, strong) NSString *memo; // 我的描述

@property (nonatomic, strong) NSString *cityName; // 选择的城市

@property (nonatomic, assign) NSInteger indexTag;  //

@property (nonatomic, assign) NSInteger sectionTag;

@property (nonatomic, strong) NSMutableArray *networkArrayEdit;
@property (nonatomic, weak) id <NewPurchaseBookControllerDelegate>delegate;

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *icon; // 标题名称
@property (nonatomic, strong) NOBookPurchaseModel *noBookmodel;


// 加载图片相关信息
@property (nonatomic, strong) NSArray *EditPicArray; // 网络编辑图片展示





@end
