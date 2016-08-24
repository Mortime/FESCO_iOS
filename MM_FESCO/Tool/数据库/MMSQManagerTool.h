//
//  MMSQManagerTool.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/24.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^initializeDatabaseBlock)(BOOL dataBaseIsExit,BOOL initResult);  // 数据库创建

typedef void (^openDataBaseBlock)(BOOL dataBaseIsOpen);

@interface MMSQManagerTool : NSObject

// 创建数据库
+ (void)initializeDatabaseWith:(initializeDatabaseBlock)initializeDatabaseBlock;

// 打开数据库
+ (void)openDataBaseWith:(openDataBaseBlock)openDataBaseBlock;
@end
