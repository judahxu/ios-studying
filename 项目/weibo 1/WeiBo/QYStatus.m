//
//  QYStatus.m
//  MyWeibo
//
//  Created by qingyun on 15/4/19.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "QYStatus.h"

@implementation QYStatus

+ (instancetype)statusWithDictory:(NSDictionary *)info
{
    QYStatus *status = [[QYStatus alloc] init];
    status.text = info[@"text"];
    return status;
}

@end
