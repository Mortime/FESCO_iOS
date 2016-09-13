//
//  OverTimeView.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "TTRefreshFooter.h"

@interface OverTimeView : TTRefreshFooter

@property (nonatomic, strong) UIViewController *parementVC;

@property (nonatomic, assign) ApprovalType approvalType;

@end
