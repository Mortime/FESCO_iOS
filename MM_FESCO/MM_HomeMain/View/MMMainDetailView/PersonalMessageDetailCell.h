//
//  PersonalMessageDetailCell.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalMessageModel.h"

@interface PersonalMessageDetailCell : UITableViewCell

@property (nonatomic, strong) NSString *imgStr;

@property (nonatomic, strong) NSString *dataStr;

@property (nonatomic, strong) PersonalMessageModel *personalMessageModel;

@property (nonatomic, assign) NSInteger index;


@end
