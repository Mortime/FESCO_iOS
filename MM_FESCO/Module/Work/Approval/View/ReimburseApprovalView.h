//
//  ReimburseApprovalView.h
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/4.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReimburseApprovalView : UITableView

@property (nonatomic, strong) UIViewController *parementVC;

@property (nonatomic, assign) ApprovalType approvalType;

// 刷新数据的方法
- (void)refreshUI;

// 请求网络数据的方法
- (void)networkRequest;

// 加载更多
- (void)moreData;

@end
