//
//  ProgressStatusCell.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/29.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressShowModel.h"

@interface ProgressStatusCell : UITableViewCell


@property (nonatomic, strong) ProgressShowModel *showModel;

@property (nonatomic, assign) NSInteger statusTag;

@property (nonatomic, strong) NSString *appleMan;

@property (nonatomic, strong) NSString *memo;

@end
