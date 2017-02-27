//
//  PhoneListCell.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/25.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneListTableController.h"

//@class PhoneListTableController;

@interface PhoneListCell : UICollectionViewCell

@property (nonatomic, strong) PhoneListTableController *phoneListVC;
@property (nonatomic, copy  ) NSString  *urlString;
@property (nonatomic, strong) NSArray *personListArray;

@property (nonatomic, strong) UIViewController *pareVC;

@end
