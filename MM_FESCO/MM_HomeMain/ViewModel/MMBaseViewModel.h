//
//  MMBaseViewModel.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/5.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMBaseViewModel : NSObject

typedef void(^BaseViewModelUpdataBlock)();

//** 调用刷新和加载回调Block **//
- (BOOL)successRefreshBlock;
- (BOOL)errorRefreshBlock;

- (BOOL)successLoadMoreBlock;
- (BOOL)errorLoadMoreBlock;
- (BOOL) successLoadMoreBlockAndNoData;

//** 设置刷新和加载回调Block **//
// 刷新成功时：回调Block
- (void)successRefreshBlock:(BaseViewModelUpdataBlock)successRefreshBlock;
// 刷新失败时：回调Block
- (void)errorRefreshBlock:(BaseViewModelUpdataBlock)errorRefreshBlock;

// 加载成功时：回调Block
- (void)successLoadMoreBlock:(BaseViewModelUpdataBlock)successLoadMoreBlock;


// 加载成功时：回调Block
- (void)successLoadMoreBlockAndNoData:(BaseViewModelUpdataBlock)successLoadMoreBlockAndNoData;
// 加载失败时：回调Block
- (void)errorLoadMoreBlock:(BaseViewModelUpdataBlock)errorLoadMoreBlock;

// 1、下拉刷新时的网络请求
- (void)networkRequestRefresh;
// 2、上拉加载时的网络请求
- (void)networkRequestLoadMore;

@end
