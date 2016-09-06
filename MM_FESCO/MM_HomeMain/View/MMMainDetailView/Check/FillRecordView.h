//
//  FillRecordView.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/31.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "TTRefreshFooter.h"

@interface FillRecordView : TTRefreshFooter

@property (nonatomic, strong) UIViewController *parementVC;

@property (nonatomic, assign) RecodeType recodeType;

// 刷新数据的方法
- (void)refreshUI;

// 请求网络数据的方法
- (void)networkRequest;

// 加载更多
- (void)moreData;

@end
