//
//  NewPurchaseSubController.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMBaseViewController.h"

@interface NewPurchaseSubController : MMBaseViewController

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic, assign) NSInteger dateType;

@property (nonatomic, assign) NSInteger needCity;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSString *icon;  // 标题名称

@property (nonatomic, assign) RePurchaseBookType bookType;

@end
