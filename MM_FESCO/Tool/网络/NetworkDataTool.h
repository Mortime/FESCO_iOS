//
//  NetworkDataTool.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/22.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NOBookChooseModel.h"
#import "EditMessageModel.h"

@interface NetworkDataTool : NSObject

// 未制单消费
+ (NSString *)MM_initWithModel:(NSArray *)noBookArray;

// 编辑时从网络获取
+ (NSString *)MM_initWithEditMessageModelArray:(NSArray *)editMessageModelArray;

// 新增消费记录保存到本地
+ (NSString *)MM_initWithNewPurchaseRecordModelArray:(NSArray *)newPurchaseRecordModelArray;
@end
