//
//  EasySerachViewController.h
//  HCSortAndSearchDemo
//
//  Created by Caoyq on 16/5/17.
//  Copyright © 2016年 Caoyq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedItem)(NSString *item);
@interface EasySerachViewController : UITableViewController

@property (strong, nonatomic) SelectedItem block;

@property (nonatomic, strong) NSArray *dataArray;  /**<排序前的整个数据源*/

- (void)didSelectedItem:(SelectedItem)block;

@end
