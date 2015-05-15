//
//  WMDataBase.h
//  WealthManager
//
//  Created by Maser on 15/5/6.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMDataBase : NSObject

+(NSString *)DatabasePathWithName:(NSString *)dataBaseName;

+ (NSString *)creatInsertOutTableSqlWith:(NSString *)table model:(NSString *)outPutModel money:(NSString *)outPutmoney
                                    date:(NSString *)outPutDate day:(NSString *)outPutDay used:(NSString *)outPutUsed comment:(NSString *)outPutComment;

+ (NSString *)creatInsertInPutTableSqlWith:(NSString *)tablename model:(NSString *)inPutModel money:(NSString *)inPutMoney date:(NSString *)inPutDate day:(NSString *)inPutDay comment:(NSString *)inPutComment;

+(void)copyDataBaseToDocumentWithName:(NSString *)dataBaseName;

+ (void)insertIntoDataBaseWith:(NSString *)sql dataBasePath:(NSString *)Path;



@end
