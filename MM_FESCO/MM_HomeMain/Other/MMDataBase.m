//
//  MMDataBase.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/29.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMDataBase.h"


@interface MMDataBase ()

@property (nonatomic, strong) NSDictionary  *dataDic;

@end

@implementation MMDataBase

static FMDatabase *_db;

- (instancetype)init{
    
    if (self = [super init]) {
//        self.dataArray = [NSMutableArray array];
    }
    return self;
}
// 创建数据库
+ (void)initializeDatabaseWith:(initDatabaseBlock)initDatabaseBlock{
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* path = [docsdir stringByAppendingPathComponent:FESCODATABASE];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    BOOL result= [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_phoneList (id integer PRIMARY KEY, itemDict blob NOT NULL, idStr text NOT NULL)"];
    // 返回创建表的结果
    initDatabaseBlock(result);

}

//存入数据库
+ (void)saveItemDict:(NSMutableDictionary *)itemDict {
    //此处把字典归档成二进制数据直接存入数据库，避免添加过多的数据库字段
    NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:itemDict];
    
    [_db executeUpdateWithFormat:@"INSERT INTO t_phoneList (itemDict, idStr) VALUES (%@, %@)",dictData, itemDict[@"ID"]];
}

//返回全部数据
+ (NSDictionary *)allDatalist {
    
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_phoneList"];
    
    
    while (set.next) {
        
        // 获得当前所指向的数据
        NSData *dictData = [set objectForColumnName:@"itemDict"];

        return [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        
    
        
    }
    return nil;
}

//通过一组数据的唯一标识判断数据是否存在
+ (void)isExistWithId:(NSString *)idStr isExist:(existData)existData
{
    BOOL isExist = NO;
    
    FMResultSet *resultSet= [_db executeQuery:@"SELECT * FROM t_phoneList"];
    while (resultSet.next) {
        if([resultSet stringForColumn:@"idStr"]) {
            isExist = YES;
        }else{
            isExist = NO;
        }
    }
    existData(isExist);
}




@end
