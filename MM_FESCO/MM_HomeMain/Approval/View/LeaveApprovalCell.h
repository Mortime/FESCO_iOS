//
//  LeaveApprovalCell.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeaveApprovalListModel.h"

@interface LeaveApprovalCell : UITableViewCell

@property (nonatomic, strong)LeaveApprovalListModel *listModel;

@property (nonatomic, assign) NSInteger index;

@end
