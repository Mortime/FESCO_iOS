//
//  OverTimeViewModel.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//
#import "MMBaseViewModel.h"

@interface ApprovalViewModel : MMBaseViewModel

@property (nonatomic, strong) NSMutableArray *overTimeListArray;

@property (nonatomic, strong) NSMutableArray *signUpListArray;

@property (nonatomic, strong) NSMutableArray *LeaveListArray;

@property (nonatomic, assign) ApprovalType approvalType;

@end
