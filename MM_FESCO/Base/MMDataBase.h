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

// 创建数据库表
+ (void)initializeDatabaseWithTableName:(NSString *)tname  baseBlock:(initDatabaseBlock)initDatabaseBlock;

//存入数据库
+ (void)saveItemDict:(NSMutableDictionary *)itemDict tname:(NSString *)tname;

//返回全部数据
+ (NSDictionary *)allDatalistWithTname:(NSString *)tname;

//通过一组数据的唯一标识判断数据是否存在  
+ (void)isExistWithId:(NSString *)idStr tname:(NSString *)tname isExist:(existData)existData;


@end
