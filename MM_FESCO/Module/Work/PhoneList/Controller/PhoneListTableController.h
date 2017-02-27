//
//  PhoneListTableController.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/25.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneListTableController : UITableViewController

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, strong) NSArray *allPersonListArray;

@property (nonatomic, strong) UIViewController *pareVC; 
@end
