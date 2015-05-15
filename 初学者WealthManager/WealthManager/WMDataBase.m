//
//  WMDataBase.m
//  WealthManager
//
//  Created by Maser on 15/5/6.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMDataBase.h"
#import "FMDB.h"
#import "FMDatabase.h"
@implementation WMDataBase
//插入支出表的语句
+ (NSString *)creatInsertOutTableSqlWith:(NSString *)table model:(NSString *)outPutModel money:(NSString *)outPutmoney
                                    date:(NSString *)outPutDate day:(NSString *)outPutDay used:(NSString *)outPutUsed comment:(NSString *)outPutComment
{
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (outPutModel, outPutmoney,outPutDate,outPutDay,outPutUsed,outPutComment) values('%@', '%@', '%@', '%@' ,'%@','%@')",table , outPutModel,outPutmoney,outPutDate,outPutDay,outPutUsed,outPutComment];
    return sql;
}
//插入收入表的语句
+ (NSString *)creatInsertInPutTableSqlWith:(NSString *)tablename model:(NSString *)inPutModel money:(NSString *)inPutMoney date:(NSString *)inPutDate day:(NSString *)inPutDay comment:(NSString *)inPutComment
{
    NSString *inPutSql = [NSString stringWithFormat:@"insert into %@(inPutModel,inPutMoney,inPutDate,inPutDay,inPutComment) values('%@','%@','%@','%@','%@')",tablename,inPutModel,inPutMoney,inPutDate, inPutDay,inPutComment];
    return  inPutSql;
}


+(NSString *)DatabasePathWithName:(NSString *)dataBaseName{
    //查找documents文件路径，
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //数据库文件的路径
    return [documentsPath stringByAppendingPathComponent:dataBaseName];
}

+(void)copyDataBaseToDocumentWithName:(NSString *)dataBaseName
{NSString *dataPath = [WMDataBase DatabasePathWithName:dataBaseName];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:dataPath]) {
        NSString *sourcePath = [[NSBundle mainBundle]pathForResource:dataBaseName ofType:nil];
        [manager copyItemAtPath:sourcePath toPath:dataPath error:nil];
        
    }
    
}


+ (void)insertIntoDataBaseWith:(NSString *)sql dataBasePath:(NSString *)Path
{
    
    FMDatabase *db = [FMDatabase databaseWithPath:Path];
    [db open];
    BOOL relse = [db executeUpdate:sql];
    
    [db close];
    if (relse == NO ) {
        return;
    }
}

@end
