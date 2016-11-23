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

// 数据库中存没每个字段
+ (void)saveItemWithMoneyAmount:(NSString *)moneyAmount spendBegin:(NSString *)spendBegin  spendEnd:(NSString *)spendEnd billNum:(NSString *)billNum picUrl:(NSString *)picUrl picDesc:(NSString *) picDesc detailMemo:(NSString *)detailMemo  spendCity:(NSString *)spendCity  ID:(NSString *)ID typePurchaseStr:(NSString *)typePurchaseStr;


//返回全部数据
+ (NSDictionary *)allDatalistWithTname:(NSString *)tname;

//通过一组数据的唯一标识判断数据是否存在  
+ (void)isExistWithId:(NSString *)idStr tname:(NSString *)tname isExist:(existData)existData;

// 根据表名 得到一个表全部数据
+ (NSArray *)allTableDataListWithTableName:(NSString *)tableName;


@end
