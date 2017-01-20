//
//  NewReimburseController.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/7.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMBaseViewController.h"
#import "ReimburseModel.h"

typedef void (^NetworkSuccessBlock) (id responseObject);

typedef void (^NetworkFailureBlock) (NSError *failure);

@interface NewReimburseController : MMBaseViewController

@property (nonatomic, assign)  RePurchaseBookType rePurchaseBook;

@property (nonatomic, strong) ReimburseModel *reimburseModel;

@property (nonatomic,strong) NSMutableArray *netWorkRecordArray; //  用于存放保存之后的消费记录模型
@end
