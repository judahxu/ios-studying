//
//  QYStatus.h
//  MyWeibo
//
//  Created by qingyun on 15/4/19.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYStatus : NSObject
@property (nonatomic, copy) NSString *text;

+ (instancetype)statusWithDictory:(NSDictionary *)info;
@end
