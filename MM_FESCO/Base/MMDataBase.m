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
// 创建数据库表
+ (void)initializeDatabaseWithTableName:(NSString *)tname  baseBlock:(initDatabaseBlock)initDatabaseBlock{
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* path = [docsdir stringByAppendingPathComponent:FESCODATABASE];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    if ([tname isEqualToString:t_purchaseRecord]) {
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY,moneyAmount text NOT NULL,spendBegin text NOT NULL,spendEnd text NOT NULL,billNum text NOT NULL,picUrl text NOT NULL,picDesc text NOT NULL,detailMemo text NOT NULL,spendCity text NOT NULL,typeID text NOT NULL,typePurchaseStr text NOT NULL)",tname];
        BOOL result= [_db executeUpdate:sql];        // 返回创建表的结果
        initDatabaseBlock(result);
    }else{
        /*
         
         @"moneyAmount":_moneyNumber,
         @"spendBegin":_startTime,
         @"spendEnd":_endTime,
         @"billNum":_billNumber,
         @"picUrl":_picUrl,
         @"picDesc":_picStr,
         @"detailMemo":_memo,
         @"spendCity":_cityName
         
         */
        
        // 返回创建表的结果
        
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY, itemDict blob NOT NULL, idStr text NOT NULL)",tname];
        BOOL result= [_db executeUpdate:sql];
        initDatabaseBlock(result);
        
    }
    

}

//存入数据库
+ (void)saveItemDict:(NSMutableDictionary *)itemDict tname:(NSString *)tname {
    //此处把字典归档成二进制数据直接存入数据库，避免添加过多的数据库字段
    NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:itemDict];
    
    if ([tname isEqualToString:t_applySignup]) {
        [_db executeUpdateWithFormat:@"INSERT INTO t_applySignup (itemDict, idStr) VALUES (%@, %@)",dictData, itemDict[@"ID"]];
    }
    if ([tname isEqualToString:@"t_phoneList"]) {
        
        [_db executeUpdateWithFormat:@"INSERT INTO t_phoneList (itemDict, idStr) VALUES (%@, %@)",dictData, itemDict[@"ID"]];
    }
    
    if ([tname isEqualToString:t_purchaseRecord]) {
        
        [_db executeUpdateWithFormat:@"INSERT INTO t_purchaseRecord (itemDict) VALUES (%@)",dictData];
    }
    
    
}
// 数据库中存没每个字段
+ (void)saveItemWithMoneyAmount:(NSString *)moneyAmount spendBegin:(NSString *)spendBegin  spendEnd:(NSString *)spendEnd billNum:(NSString *)billNum picUrl:(NSString *)picUrl picDesc:(NSString *) picDesc detailMemo:(NSString *)detailMemo  spendCity:(NSString *)spendCity  ID:(NSString *)ID typePurchaseStr:(NSString *)typePurchaseStr{
    
     [_db executeUpdateWithFormat:@"INSERT INTO t_purchaseRecord (moneyAmount,spendBegin,spendEnd,billNum,picUrl,picDesc,detailMemo,spendCity,typeID,typePurchaseStr) VALUES (%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)",moneyAmount,spendBegin,spendEnd,billNum,picUrl,picDesc,detailMemo,spendCity,ID,typePurchaseStr];
}

//返回全部数据
+ (NSDictionary *)allDatalistWithTname:(NSString *)tname {
    
    NSString *sli = [NSString stringWithFormat:@"SELECT * FROM %@",tname];
    
    FMResultSet *set = [_db executeQuery:sli];
    
    
    while (set.next) {
        
        // 获得当前所指向的数据
        NSData *dictData = [set objectForColumnName:@"itemDict"];

        return [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        
    
        
    }
    return nil;
}

//通过一组数据的唯一标识判断数据是否存在  t_phoneList
+ (void)isExistWithId:(NSString *)idStr tname:(NSString *)tname isExist:(existData)existData
{
    BOOL isExist = NO;
    
    NSString *spi = [NSString stringWithFormat:@"SELECT * FROM %@",tname];
    FMResultSet *resultSet= [_db executeQuery:spi];
    while (resultSet.next) {
        if([resultSet stringForColumn:@"idStr"]) {
            isExist = YES;
        }else{
            isExist = NO;
        }
    }
    existData(isExist);
}

// 根据表名 得到一个表全部数据
+ (NSArray *)allTableDataListWithTableName:(NSString *)tableName{
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* path = [docsdir stringByAppendingPathComponent:FESCODATABASE];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];

    
    FMResultSet *resultSet = nil;
    resultSet = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@;",tableName]];
    NSMutableArray *resultArray = [NSMutableArray array];
    // 遍历查询结果
    while (resultSet.next) {
        
        NSString *moneyAmount = [resultSet stringForColumn:@"moneyAmount"];
        
        NSString *spendBegin = [resultSet stringForColumn:@"spendBegin"];
        
        NSString *spendEnd = [resultSet stringForColumn:@"spendEnd"];
        
        NSString *billNum = [resultSet stringForColumn:@"billNum"];
        
        NSString *picUrl = [resultSet stringForColumn:@"picUrl"];
        
        NSString *picDesc = [resultSet stringForColumn:@"picDesc"];
        
        NSString *detailMemo = [resultSet stringForColumn:@"detailMemo"];
        
        NSString *spendCity = [resultSet stringForColumn:@"spendCity"];
        
        NSString *typeID = [resultSet stringForColumn:@"typeID"];
        
        NSString *typePurchaseStr = [resultSet stringForColumn:@"typePurchaseStr"];
        
        
         NSString *value = [resultSet stringForColumnIndex:0];
        
        MMLog(@"moneyAmount ===== %@,spendBegin = %@",moneyAmount,spendBegin);
       
            
            NSArray *array = @[moneyAmount,spendBegin,spendEnd,billNum,picUrl,picDesc,detailMemo,spendCity,typeID,typePurchaseStr];
            MMLog(@"array = %@",array);
        [resultArray addObject:array];
        
    }

    MMLog(@"dict = %@",resultArray);
    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:0 error:NULL];
//    if (!jsonData) {
//        return nil;
//    }
//    
//    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return resultArray;

}


@end
