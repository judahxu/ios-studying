//
//  QYSQLiteDBManager.h
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-24.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define kDBName @"students.db"

@class QYStudentModel;

@interface QYSQLiteDBManager : NSObject

//static QYSQLiteDBManager *_manager;
//static sqlite3 *_sqlite;

//@property (nonatomic, strong) QYSQLiteDBManager *manager;
//@property (nonatomic) sqlite3 *sqlite;


/**
 *  数据库引擎单例对象的创建
 *
 *  @return 数据库引擎单例对象
 */
+ (instancetype)sharedDBManager;

/**
 *  打开数据库，即创建数据库连接对象
 *
 *  @return YES代表成功，NO代表失败
 */
- (BOOL)openDB;

/**
 *  关闭数据库，即销毁数据库连接对象
 *
 *  @return YES代表成功，NO代表失败
 */
- (BOOL)closeDB;

/**
 *  创建学生表
 *
 *  @return YES代表成功，NO代表失败
 */
- (BOOL)createTable;

/**
 *  向学生表中插入一条学生记录
 *
 *  @param student 学生数据模型对象
 *
 *  @return YES代表成功，NO代表失败
 */
- (BOOL)insertStudent:(QYStudentModel *)student;

/**
 *  从学生表中删除一条学生记录
 *
 *  @param ID 学生的学号
 *
 *  @return YES代表成功，NO代表失败
 */
- (BOOL)deleteStudentByID:(int)ID;

/**
 *  更新学生记录
 *
 *  @param student 学生数据模型对象
 *
 *  @return YES代表成功，NO代表失败
 */
- (BOOL)updateStudent:(QYStudentModel *)student;

/**
 *  根据学号查询指定学生记录
 *
 *  @param ID 学生的学号
 *
 *  @return 学生记录的数据模型对象
 */
- (QYStudentModel *)selectStudentByID:(int)ID;

/**
 *  查找所有学生记录
 *
 *  @return 学生记录的数组
 */
- (NSArray *)selectAllStudents;

@end
