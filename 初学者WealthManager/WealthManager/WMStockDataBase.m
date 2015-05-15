//
//  QYDataBaseEngine.m
//  WeiBo
//
//  Created by qingyun on 15-4-27.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "WMStockDataBase.h"
#import "FMDB.h"
#import "WMStockModel.h"



//保存table的字段数组
static NSArray *stockArrayColumn;

@implementation WMStockDataBase

#pragma mark - creat database

+(void)initialize{
    //创建数据库数据库
    [WMStockDataBase copyDatabaseToDocuments];
    
    //得到status的字段数组
    stockArrayColumn = [WMStockDataBase tableColumn:@"stockTable"];
    
}

+(NSString *)DatabasePath{
    //查找documents文件路径，
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //数据库文件的路径
    return [documentsPath stringByAppendingPathComponent:@"WMStockDB.db"];
}

+(void)copyDatabaseToDocuments{
    //判断documents下有没有数据库
    NSString *dataPath = [WMStockDataBase DatabasePath];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:dataPath]) {
        //找到man bundle下数据库的路径
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"WMStockDB" ofType:@"db"];
        //copy 到 documents下
        [manager copyItemAtPath:sourcePath toPath:dataPath error:nil];
    }
    
}

#pragma mark - save data

//查询表中所有字段
+(NSArray *)tableColumn:(NSString *)tableName{
    FMDatabase *db = [FMDatabase databaseWithPath:[WMStockDataBase DatabasePath]];
    [db open];
    //将名字转化为全小写
    
    //使用Database的扩展方法，查询字段名字
    FMResultSet *result = [db getTableSchema:tableName];
    //接收查询的结果
    NSMutableArray *columnArray = [NSMutableArray array];
    while ([result next]) {
        [columnArray addObject:[result stringForColumn:@"name"]];
    }
    [result close];
    [db close];
    return columnArray;
    
}

//创建插入语句，table column ，插入的数据

+(NSString *)createInsertSql4Table:(NSString *)tableName valueDictionary:(NSDictionary *)values {
    //得到插入的数据的key的集合
    NSArray *dicKayArray = [values allKeys];
    
    // 构造insert into tableName (column1, column2) values(:column1, :column2)
    //构造column
    NSString *columnString = [dicKayArray componentsJoinedByString:@", "];
    
    //构造key
    NSString *keyString = [dicKayArray componentsJoinedByString:@", :"];
    keyString = [@":" stringByAppendingString:keyString];
    
    NSString *sql = [NSString stringWithFormat:@"insert into %@(%@) values(%@)", tableName, columnString, keyString];

    return sql;
}

+(void)saveStockToDatabase:(NSArray *)stockArray{
    NSString *dbPath = [WMStockDataBase DatabasePath];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    [queue inDatabase:^(FMDatabase *db) {
        for (NSDictionary *statusInfo in stockArray) {
            //过滤字典中无用值
            NSMutableDictionary *muStatusInfo = [NSMutableDictionary dictionaryWithDictionary:statusInfo];
            NSArray *allKey = [statusInfo allKeys];
            for (NSString *key in allKey) {
                //判断key是否在数据库中存在
                if (![stockArrayColumn containsObject:key]) {
                    [muStatusInfo removeObjectForKey:key];
                }else{
                    //如果存在, 取出来内容，判断类型是否需要归档
                    id object = statusInfo[key];
                    
                    if ([object isKindOfClass:[NSDictionary class]] || [object isKindOfClass:[NSArray class]]) {
                        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
                        [muStatusInfo setObject:data forKey:key];
                    }
                }
                
            }
            NSString *sql = [WMStockDataBase createInsertSql4Table:@"stockTable" valueDictionary:muStatusInfo];
//            执行插入语句
            BOOL result = [db executeUpdate:sql withParameterDictionary:muStatusInfo];
        }
    }];
}

#pragma mark - select

+(void)deleteDataWith:(NSString *)tableName
{
    NSString *dbPath = [WMStockDataBase DatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    NSString *sql = [NSString stringWithFormat:@"delete from %@",tableName];
    [db open];
    BOOL reslt = [db executeUpdate:sql];
    [db close];
    
}
+(NSArray *)stockArrayFromDataBase{
    NSString *dbPath = [WMStockDataBase DatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    //查询语句
    NSString *sql = @"select * from stockTable";
    
    //执行查询
    FMResultSet *result = [db executeQuery:sql];
    NSMutableArray *modelArray = [NSMutableArray array];
    
    while ([result next]) {
        //将结果转化为字典
        NSDictionary *stockInfo = [result resultDictionary];
        //转化为model并且保存
        WMStockModel *stockModel = [WMStockModel initWithAllData:stockInfo];
            [modelArray addObject:stockModel];
       
    }
    [db close];
    return modelArray;
}

+(void)deleteDataWith:(NSString *)tableName cloumn:(NSString *)cloumn
{
    NSString *dbPath = [WMStockDataBase DatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where stockID = '%@'",tableName,cloumn];
    [db open];
    BOOL reslt = [db executeUpdate:sql];
    [db close];
    
}

@end
