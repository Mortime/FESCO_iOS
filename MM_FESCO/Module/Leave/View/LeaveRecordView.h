//
//  LeaveRecordView.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveRecordView : UIView

@property (nonatomic, strong) UIViewController *parementVC;


// 刷新数据的方法
- (void)refreshUI;

// 请求网络数据的方法
- (void)networkRequest;
@end
