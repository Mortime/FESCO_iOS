//
//  ProgressPuschaseCell.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/29.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPurchaseRecordModel.h"

@interface ProgressPuschaseCell : UITableViewCell

@property (nonatomic, strong) NewPurchaseRecordModel *model;

@property (nonatomic, strong) NSDictionary *dic;
@end
