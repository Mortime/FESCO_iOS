//
//  OverTimeStatisticHeaderView.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/10/24.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverTimeStatisticModel.h"

@interface OverTimeStatisticHeaderView : UIView

@property (nonatomic, strong) OverTimeStatisticModel *model;

@property (nonatomic,assign) BOOL isShowFlage; // 默认是显示的

@end
