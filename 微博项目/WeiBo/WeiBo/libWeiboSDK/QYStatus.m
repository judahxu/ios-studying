//
//  QYStatus.m
//  WeiBo
//
//  Created by qingyun on 15-4-16.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYStatus.h"

@implementation QYStatus

+(instancetype)statusWithInfo:(NSDictionary *)info{
    QYStatus *status = [[QYStatus alloc] init];
    status.text = info[@"text"];
    return status;
}

@end
