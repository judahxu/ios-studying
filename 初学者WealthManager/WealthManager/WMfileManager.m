//
//  WMfileManager.m
//  WealthManager
//
//  Created by Maser on 15/4/30.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMfileManager.h"

@implementation WMfileManager
+(void)initialize
{
}

+(NSString *)dataDocPath:(NSString *)dataName
{
    //根据文件名创建沙盒路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dataDocPath = [docPath stringByAppendingPathComponent:dataName];
    return dataDocPath;
}

+(void)copyDataToDocuments:(NSString *)dataName
{
    NSString *dataPath = [WMfileManager dataDocPath:dataName];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:dataPath]) {
        NSString *sourcePath = [[NSBundle mainBundle]pathForResource:dataName ofType:nil];
        [manager copyItemAtPath:sourcePath toPath:dataPath error:nil];
    }
}
@end
