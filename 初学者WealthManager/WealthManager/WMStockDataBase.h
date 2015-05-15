//
//  QYDataBaseEngine.h
//  WeiBo
//
//  Created by qingyun on 15-4-27.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//处理数据库的创建、增加记录、查询记录

@interface WMStockDataBase : NSObject

//插入
+(void)saveStockToDatabase:(NSArray *)stockArray;

//查询
+(NSArray *)stockArrayFromDataBase;
//删除
+(void)deleteDataWith:(NSString *)tableName;

+(void)deleteDataWith:(NSString *)tableName cloumn:(NSString *)cloumn;

@end
