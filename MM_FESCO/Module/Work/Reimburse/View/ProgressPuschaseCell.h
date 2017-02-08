//
//  ProgressPuschaseCell.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/29.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPurchaseRecordModel.h"
#import "ProgressReimburseModel.h"

@interface ProgressPuschaseCell : UITableViewCell

@property (nonatomic, strong) NewPurchaseRecordModel *model;

@property (nonatomic, strong) NSDictionary *dic;

@property (nonatomic, strong) ProgressReimburseModel *progressModel;

@end
