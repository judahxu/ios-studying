//
//  QYSomeClass.m
//  SingletonDemo
//
//  Created by qingyun on 15-3-17.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYSomeClass.h"

@implementation QYSomeClass

+ (instancetype)sharedInstance
{
#if 0
    static QYSomeClass *manager;

    if (manager == nil) {
        // 创建
        [NSThread sleepForTimeInterval:3];
        manager = [[QYSomeClass alloc] init];
    }
#endif
    
    static QYSomeClass *manager;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        [NSThread sleepForTimeInterval:3];
        manager = [[QYSomeClass alloc] init];
    });
    
    return manager;
}

@end
