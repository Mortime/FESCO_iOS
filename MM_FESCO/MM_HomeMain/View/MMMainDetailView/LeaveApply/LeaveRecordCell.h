//
//  LeaveRecordCell.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeavaRecordListModel.h"

@protocol LeaveRecordCellDelegate <NSObject>

- (void)leaveRecordCellDelegatewithLeaveID:(NSInteger)index;

@end

@interface LeaveRecordCell : UITableViewCell

@property (nonatomic, strong) LeavaRecordListModel *listModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) id <LeaveRecordCellDelegate> delegate;

@end
