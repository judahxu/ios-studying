//
//  QYSQLiteDBManager.m
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-24.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYSQLiteDBManager.h"
#import <sqlite3.h>
#import "QYStudentModel.h"

static QYSQLiteDBManager *_manager;
static sqlite3 *_sqlite;

@implementation QYSQLiteDBManager

+ (instancetype)sharedDBManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _manager = [[self alloc] init];
    });
    
    return _manager;
}

- (NSString *)docPath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

- (BOOL)openDB
{
    if (_sqlite) {
        return YES;
    }
    
    int result = sqlite3_open([[[self docPath] stringByAppendingPathComponent:kDBName] UTF8String], &_sqlite);
    if (result != SQLITE_OK) {
        NSLog(@"%s", sqlite3_errmsg(_sqlite));
        return NO;
    }
    
    NSLog(@"Open database success!");
    return YES;
}

- (BOOL)closeDB
{
    int result = sqlite3_close(_sqlite);
    if (result != SQLITE_OK) {
        NSLog(@"Close database failed!");
        return NO;
    }
    
    _sqlite = NULL;
    return YES;
}

- (BOOL)createTable
{
    // 1. 打开数据库
    [self openDB];
    
    // 2. 编写SQL语句
    NSString *sql = @"create table if not exists Students(ID integer primary key, name text not null, age integer, sex text, icon blob)";
    
    // 3. 执行SQL语句
    char *errmsg;
    int result = sqlite3_exec(_sqlite, [sql UTF8String], NULL, NULL, &errmsg);
    if (result != SQLITE_OK) {
        NSLog(@"%s", errmsg);
        [self closeDB];
        return  NO;
    }

    // 4. 关闭数据库
    [self closeDB];
    NSLog(@"Create table success!");
    return YES;
}

- (BOOL)insertStudent:(QYStudentModel *)student
{
    // 1. 打开数据库
    [self openDB];
    
    // 2. 编写SQL语句
    NSString *sql = @"insert into Students(ID, name, age, sex, icon) values(?, ?, ?, ?, ?)";
    
    // 3. 编译SQL语句
    sqlite3_stmt *stmt;
    int result = sqlite3_prepare_v2(_sqlite, [sql UTF8String], -1, &stmt, NULL);
    if (result != SQLITE_OK) {
        NSLog(@"%s", sqlite3_errmsg(_sqlite));
        [self closeDB];
        return NO;
    }
    
    // 4. 绑定参数
    sqlite3_bind_int(stmt, 1, student.ID);
    sqlite3_bind_text(stmt, 2, [student.name UTF8String], -1, NULL);
    sqlite3_bind_int(stmt, 3, student.age);
    sqlite3_bind_text(stmt, 4, [student.sex UTF8String], -1, NULL);
    
    NSData *iconData = UIImagePNGRepresentation(student.icon);
    sqlite3_bind_blob(stmt, 5, [iconData bytes], (int)iconData.length, NULL);
    
    // 5. 执行 step函数
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        NSLog(@"%s", sqlite3_errmsg(_sqlite));
        sqlite3_finalize(stmt);
        [self closeDB];
        return NO;
    }
    
    // 6. 销毁预编译语句对象
    sqlite3_finalize(stmt);
    
    // 7. 关闭数据库
    [self closeDB];
    NSLog(@"Insert sucess!");
    
    return YES;
}

- (BOOL)deleteStudentByID:(int)ID
{
    // 1. 打开数据库
    [self openDB];
    
    // 2. 编写SQL语句
    NSString *sql = @"delete from Students where ID = ?";
    
    // 3. 编译SQL语句
    sqlite3_stmt *stmt;
    int result = sqlite3_prepare_v2(_sqlite, [sql UTF8String], -1, &stmt, NULL);
    if (result != SQLITE_OK) {
        NSLog(@"%s", sqlite3_errmsg(_sqlite));
        [self closeDB];
        return NO;
    }
    
    // 4. 绑定参数
    sqlite3_bind_int(stmt, 1, ID);
    
    // 5. 执行 step函数
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        NSLog(@"%s", sqlite3_errmsg(_sqlite));
        sqlite3_finalize(stmt);
        [self closeDB];
        return NO;
    }
    
    // 6. 销毁预编译语句对象
    sqlite3_finalize(stmt);
    
    // 7. 关闭数据库
    [self closeDB];
    NSLog(@"Delete sucess!");
    
    return YES;
}

- (BOOL)updateStudent:(QYStudentModel *)student
{
    // 1. 打开数据库
    [self openDB];
    
    // 2. 编写SQL语句
    NSString *sql = @"update Students set name = ?, age = ?, sex = ?, icon = ? where ID = ?";
    
    // 3. 编译SQL语句
    sqlite3_stmt *stmt;
    int result = sqlite3_prepare_v2(_sqlite, [sql UTF8String], -1, &stmt, NULL);
    if (result != SQLITE_OK) {
        NSLog(@"%s", sqlite3_errmsg(_sqlite));
        [self closeDB];
        return NO;
    }
    
    // 4. 绑定参数
    sqlite3_bind_text(stmt, 1, [student.name UTF8String], -1, NULL);
    sqlite3_bind_int(stmt, 2, student.age);
    sqlite3_bind_text(stmt, 3, [student.sex UTF8String], -1, NULL);
    
    NSData *iconData = UIImagePNGRepresentation(student.icon);
    sqlite3_bind_blob(stmt, 4, [iconData bytes], (int)iconData.length, NULL);
    
    sqlite3_bind_int(stmt, 5, student.ID);
    
    // 5. 执行 step函数
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        NSLog(@"%s", sqlite3_errmsg(_sqlite));
        sqlite3_finalize(stmt);
        [self closeDB];
        return NO;
    }
    
    // 6. 销毁预编译语句对象
    sqlite3_finalize(stmt);
    
    // 7. 关闭数据库
    [self closeDB];
    NSLog(@"Update sucess!");
    
    return YES;

}

- (QYStudentModel *)extractModelFrom:(sqlite3_stmt *)stmt
{
    // 1. 提取学号
    int ID = sqlite3_column_int(stmt, 0);
    
    // 2. 提取姓名
    const unsigned char *name = sqlite3_column_text(stmt, 1);
    NSString *nameStr;
    if (name) {
        nameStr = [NSString stringWithCString:(const char *)name encoding:NSUTF8StringEncoding];
    }

    // 3. 提取年龄
    int age = sqlite3_column_int(stmt, 2);
    
    // 4. 提取性别
    const unsigned char *sex = sqlite3_column_text(stmt, 3);
    NSString *sexStr;
    if (sex) {
        sexStr = [NSString stringWithCString:(const char *)sex encoding:NSUTF8StringEncoding];
    }
    
    // 5. 提取头像
    const void *iconData = sqlite3_column_blob(stmt, 4);
    int length = sqlite3_column_bytes(stmt, 4);
    NSData *imageData = [NSData dataWithBytes:iconData length:length];
    UIImage *icon = [UIImage imageWithData:imageData];
    
    // 6. 组装成学生模型对象并返回
    QYStudentModel *student = [[QYStudentModel alloc] init];
    student.ID = ID;
    student.name = nameStr;
    student.age = age;
    student.sex = sexStr;
    student.icon = icon;
    
    return student;
}

- (NSArray *)selectAllStudents
{
    // 1. 打开数据库 open
    [self openDB];
    
    // 2. 编写SQL语句
    NSString *sql = @"select * from Students";
    
    // 3. 编译SQL语句 prepare
    sqlite3_stmt *stmt;
    int result = sqlite3_prepare_v2(_sqlite, [sql UTF8String], -1, &stmt, NULL);
    if (result != SQLITE_OK) {
        NSLog(@"%s", sqlite3_errmsg(_sqlite));
        [self closeDB];
        return nil;
    }
    
    // 4. 执行SQL语句 step
    NSMutableArray *students = [NSMutableArray array];
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        // 5. 按列提取查询每一行的记录 column
        QYStudentModel *student = [self extractModelFrom:stmt];
        if (student) {
            [students addObject:student];
        }
    }
    
    // 6. 销毁预编译的语句对象 finalize
    sqlite3_finalize(stmt);
    
    // 7. 关闭数据库 close
    [self closeDB];
    NSLog(@"Select all sucess!");
    return students;
}

- (QYStudentModel *)selectStudentByID:(int)ID
{
    // 1. 打开数据库 open
    [self openDB];
    
    // 2. 编写SQL语句
//    NSString *sql = @"select * from Students where ID = ?";
    NSString *sql = [NSString stringWithFormat:@"select * from Students where ID = %d", ID];
    
    // 3. 编译SQL语句 prepare
    sqlite3_stmt *stmt;
    int result = sqlite3_prepare_v2(_sqlite, [sql UTF8String], -1, &stmt, NULL);
    if (result != SQLITE_OK) {
        NSLog(@"%s", sqlite3_errmsg(_sqlite));
        [self closeDB];
        return nil;
    }
    
    // 4. 执行SQL语句 step
    QYStudentModel *student;
    if (sqlite3_step(stmt) == SQLITE_ROW) {
        // 5. 按列提取查询每一行的记录 column
        student = [self extractModelFrom:stmt];
    }
    
    // 6. 销毁预编译的语句对象 finalize
    sqlite3_finalize(stmt);
    
    // 7. 关闭数据库 close
    [self closeDB];
    NSLog(@"Select by ID sucess!");
    return student;
}

@end
