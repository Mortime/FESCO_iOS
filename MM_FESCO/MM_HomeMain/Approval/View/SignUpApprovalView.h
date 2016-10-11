//
//  SignUpApprovalView.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpApprovalView : UITableView

@property (nonatomic, strong) UIViewController *parementVC;

@property (nonatomic, assign) ApprovalType approvalType;


// 刷新数据的方法
- (void)refreshUI;

// 请求网络数据的方法
- (void)networkRequest;

// 加载更多
- (void)moreData;


@end
