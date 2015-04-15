//
//  QYStudent.m
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-20.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYStudent.h"

@implementation QYStudent


/*
 * 解码方法
 * aDecoder 就是解码器对象
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:kName];
        _age = [aDecoder decodeIntForKey:kAge];
        _ID = [aDecoder decodeObjectForKey:kID];
    }
    
    return self;
}


/*
 * 编码方法
 * aCoder 就是编码器
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:kName];
    [aCoder encodeInt:_age forKey:kAge];
    [aCoder encodeObject:_ID forKey:kID];
}

@end
