//
//  MMDataBase.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/29.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void (^d);

typedef void (^initDatabaseBlock)(BOOL isSuccess);  // 数据库创建

typedef void (^existData) (BOOL isExist); // 判断数据是否存在

@interface MMDataBase : NSObject

// 创建数据库
+ (void)initializeDatabaseWith:(initDatabaseBlock)initializeDatabaseBlock;

//存入数据库
+ (void)saveItemDict:(NSDictionary *)itemDict;

//返回全部数据
+ (NSDictionary *)allDatalist;

// 打开数据库
+ (void)isExistWithId:(NSString *)idStr isExist:(existData)existData;


@end
