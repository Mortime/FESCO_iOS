//
//  MMLoginTool.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMLoginTool : NSObject


/**
 *  检查是否请求网络获取新的tonkey
 *
 *  @param beginTime 开始的时间（后台返回的UTC时间）
 *
 *  @return YES:可以签到
 */
+ (BOOL)checkCancelAppointmentWithBeginTime;

@end
