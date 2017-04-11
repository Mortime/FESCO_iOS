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
    
    if ([_db open]) {
        // 创建数据库表
        if ([tname isEqualToString:@"t_newPhoneList"]) {
            // 创建联系人数据库表
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY,empID integer,name text,groupName text,mobile text,phone text)",tname];
            BOOL result= [_db executeUpdate:sql];        // 返回创建表的结果
            initDatabaseBlock(result);

        }
        
        if ([tname isEqualToString:@"t_userIconUrl"]) {
            // 创建用户头像数据库表
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY,empID integer,avtar blob)",tname];
            BOOL result= [_db executeUpdate:sql];        // 返回创建表的结果
            initDatabaseBlock(result);
            
        }else if ([tname isEqualToString:t_purchaseRecord]) {
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY,moneyAmount text NOT NULL,spendBegin text NOT NULL,spendEnd text NOT NULL,billNum text NOT NULL,picUrl text NOT NULL,picDesc text NOT NULL,detailMemo text NOT NULL,spendCity text NOT NULL,typeID text NOT NULL,typePurchaseStr text NOT NULL)",tname];
            BOOL result= [_db executeUpdate:sql];        // 返回创建表的结果
            initDatabaseBlock(result);
        }else{
            // 返回创建表的结果
            
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY, itemDict blob NOT NULL, idStr text NOT NULL)",tname];
            BOOL result= [_db executeUpdate:sql];
            initDatabaseBlock(result);
            
        }
        [_db close];
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
    
    
    
}
// 数据库中存没每个字段
+ (void)saveItemWithMoneyAmount:(NSString *)moneyAmount spendBegin:(NSString *)spendBegin  spendEnd:(NSString *)spendEnd billNum:(NSString *)billNum picUrl:(NSString *)picUrl picDesc:(NSString *) picDesc detailMemo:(NSString *)detailMemo  spendCity:(NSString *)spendCity  ID:(NSString *)ID typePurchaseStr:(NSString *)typePurchaseStr{
    
     [_db executeUpdateWithFormat:@"INSERT INTO t_purchaseRecord (moneyAmount,spendBegin,spendEnd,billNum,picUrl,picDesc,detailMemo,spendCity,typeID,typePurchaseStr) VALUES (%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)",moneyAmount,spendBegin,spendEnd,billNum,picUrl,picDesc,detailMemo,spendCity,ID,typePurchaseStr];
}

//返回全部数据
+ (NSDictionary *)allDatalistWithTname:(NSString *)tname {
    
    
    if ([_db open]) {
        NSString *sli = [NSString stringWithFormat:@"SELECT * FROM %@",tname];
        
        FMResultSet *set = [_db executeQuery:sli];
        
        
        while (set.next) {
            
            // 获得当前所指向的数据
            NSData *dictData = [set objectForColumnName:@"itemDict"];
            
            return [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
            
            
            
        }

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

+(void) deleteAll
{
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* path = [docsdir stringByAppendingPathComponent:FESCODATABASE];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    BOOL success =  [_db executeUpdate:@"DELETE FROM t_purchaseRecord"];

    
    [_db close];
    if (success) {
        MMLog(@"表删除成功");

    }
    
//    return success;
    
}



//插入avtar数据
+ (void)addAvtarData:(NSInteger)empID avtar:(NSData *)data baseBlock:(initDatabaseBlock)initDatabaseBlock{
    if ([_db open]) {
        NSString *sql =@"INSERT INTO t_userIconUrl(empID, avtar) VALUES (?, ?)";
        BOOL bResult = [_db executeUpdate:sql, @(empID), data];
        initDatabaseBlock(bResult);
        [_db open];
    }
}

//获取avtar数据
+ (void)getAvtarData{
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_userIconUrl"];
        FMResultSet *resultSet = [_db executeQuery:sql];
        
        while ([resultSet next]) {
            
//            NSInteger emp = [resultSet intForColumn:@"empID"];
//            NSData *data = [resultSet dataForColumn:@"avtar"];
////            UIImage *image = [UIImage imageWithData:data];
//            MMLog(@"emp===image=====%lu======%@",emp,data);
        }
    }
    [_db close];
}


// 更新数据
+ (void)updateAvtarData:(NSInteger)empID avtar:(NSData *)data baseBlock:(initDatabaseBlock)initDatabaseBlock{
    // 查询数据
    if ([_db open]) {
        FMResultSet *rs = [_db executeQuery:@"SELECT * FROM t_userIconUrl"];
        // 遍历结果集
        while ([rs next]) {
            
            NSInteger empIDTable = [rs intForColumn:@"empID"];
            if (empIDTable != empID) {
                // 为新增用户的头像
                [[self class] addAvtarData:empID avtar:data baseBlock:^(BOOL isSuccess) {
                    initDatabaseBlock(isSuccess);
                }];

            }else if (empIDTable == empID){
                // 更新用户头像
                [_db executeUpdate:@"UPDATE t_userIconUrl SET avtar = ? WHERE empID = ?;", data, @(empID)];
            }
            
            
        }
        [_db close];
    }
}

+ (NSData *)getAvtarDateWith:(NSInteger)empID{
    // 查询数据
    NSData *data;
    if ([_db open]) {
        FMResultSet *rs = [_db executeQuery:@"SELECT * FROM t_userIconUrl"];
        // 遍历结果集
        while ([rs next]) {
            
            NSInteger empIDTable = [rs intForColumn:@"empID"];
            if (empIDTable == empID) {
                data = [rs dataForColumn:@"avtar"];
            }
            
        }
        [_db close];
    }
    return data;

}

// 通讯录模块  数据删除和插入

/*插入数据*/
+ (void)addNewPhoneListEmpID:(NSInteger)empID name:(NSString *)name mobile:(NSString *)mobile phone:(NSString *)phone groupName:(NSString *)groupName baseBlock:(initDatabaseBlock)initDatabaseBlock{
    if ([_db open]) {
        NSString *sql =@"INSERT INTO t_newPhoneList(empID, name,groupName,mobile,phone) VALUES (?,?,?,?,?)";
        BOOL bResult = [_db executeUpdate:sql, @(empID),name,groupName,mobile,phone];
        initDatabaseBlock(bResult);
        [_db close];
    }
}
/*删除一条数据*/
+ (void)deletePhoneWithEmpID:(NSInteger)empID baseBlock:(initDatabaseBlock)initDatabaseBlock{
    if ([_db open]) {
        [_db executeUpdate:@"DELETE FROM t_newPhoneList WHERE empID = ?",@(empID)];
        [_db close];
    }
}
/*表中所有数据*/
// 根据表名 得到一个表全部数据
+ (NSArray *)allNewPhoneList{
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* path = [docsdir stringByAppendingPathComponent:FESCODATABASE];
    _db = [FMDatabase databaseWithPath:path];
//    [_db open];
    
    /*
     NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY,empID integer,name text,mobile text,phone text,groupName text)",tname];
     BOOL result= [_db executeUpdate:sql];        // 返回创建表的结果
     initDatabaseBlock(result);
     */
    NSMutableArray *resultArray = [NSMutableArray array];
    if ([_db open]) {
        FMResultSet *resultSet = nil;
        resultSet = [_db executeQuery:@"SELECT * FROM t_newPhoneList"];
        
        // 遍历查询结果
        while (resultSet.next) {
            
            NSInteger empID = [resultSet intForColumn:@"empID"];
            
            NSString *name = [resultSet stringForColumn:@"name"];
            
            NSString *mobile = [resultSet stringForColumn:@"mobile"];
            
            NSString *phone = [resultSet stringForColumn:@"phone"];
            
            NSString *groupName = [resultSet stringForColumn:@"groupName"];
            
            
//            MMLog(@"mobile ===== %@,phone = %@",mobile,groupName);
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lu",empID],@"emp_Id",name,@"emp_Name",groupName,@"group_Name",mobile,@"mobile",phone,@"phone", nil];
            MMLog(@"-===========dic = %@",dic);
            [resultArray addObject:dic];
            
        }
        
        MMLog(@"allNewPhoneList = dict = %@",resultArray);
        
        //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:0 error:NULL];
        //    if (!jsonData) {
        //        return nil;
        //    }
        //
        //    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
 
   }
   return resultArray;
}
@end
