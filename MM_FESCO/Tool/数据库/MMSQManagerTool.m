//
//  MMSQManagerTool.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/24.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMSQManagerTool.h"
#import <sqlite3.h>


#define FESCODATABASE  @"catalog.sqlite"


static sqlite3 *database;

@implementation MMSQManagerTool


// 数据库创建
+ (void)initializeDatabaseWith:(initializeDatabaseBlock)initializeDatabaseBlock{
    // 确认可操作数据是否存在
    BOOL success;
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 数据库文件路径
    NSString *writableDB =  [[self class] pathWithDatabase];
    // 文件是否存在
    success = [fileManager fileExistsAtPath:writableDB];
    
    if (success) {
        // 数据库已经存在
        MMLog(@"数据库已经存在");
        initializeDatabaseBlock(YES,YES);
    }
    if (!success) {
        // 数据库不存在就创建
        MMLog(@"数据库不存在");
        initializeDatabaseBlock(NO,NO);
        
        NSString *defaultPath = [[[NSBundle mainBundle]
                                  resourcePath]
                                 stringByAppendingPathComponent:FESCODATABASE];
        // 拷贝文件到某文件路径
        success = [fileManager copyItemAtPath:defaultPath
                                       toPath:writableDB
                                        error:&error];
        //        if (!success) {
        //            NSAssert1(0, @"Failed to create writable database file:'%@'.",
        //                      [error localizedDescription]);
        //        }
        if (success) {
            // 数据库已经创建成功
            MMLog(@"数据库已经创建成功");
            initializeDatabaseBlock(YES,YES);
        }
    }
    
    
    
    NSArray *resultPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *restltDocumentDirectory = [resultPaths lastObject];
    NSLog(@"------%@",restltDocumentDirectory);

    

}

// 数据打开
+ (void)openDataBaseWith:(openDataBaseBlock)openDataBaseBlock{
    
    NSString *path = [[self class] pathWithDatabase];
    BOOL isOpen =  sqlite3_open([path UTF8String], &database) == SQLITE_OK;
    if (isOpen) {
        // 数据库打开成功
        MMLog(@"数据库打开成功");
        openDataBaseBlock(YES);
    }else{
        // 数据库打开失败
        MMLog(@"数据库打开失败");
        openDataBaseBlock(NO);
        // 打开数据库失败
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database: '%s'.", sqlite3_errmsg(database));
    }
}






/** 要操作的数据库文件路径 */
+ (NSString *)pathWithDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *documentDirectory = [paths lastObject];
    return [documentDirectory stringByAppendingPathComponent:FESCODATABASE];
}

@end
