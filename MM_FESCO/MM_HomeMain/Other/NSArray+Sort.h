//
//  NSArray+Sort.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/30.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Sort)

// 对数组中字典进行排序分组
+ (NSArray  *)sortGroupWithDataSouce:(NSArray *)array  keyStr:(NSString *)keyStr;
@end
