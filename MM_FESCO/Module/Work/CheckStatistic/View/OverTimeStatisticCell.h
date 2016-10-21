//
//  OverTimeStatisticCell.h
//  MM_FESCO
//
//  Created by Mortimey on 16/10/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverTimeStatisticModel.h"

@interface OverTimeStatisticCell : UITableViewCell

@property (nonatomic, strong) OverTimeStatisticModel *model;

@property (nonatomic, assign) NSInteger index;
@end
