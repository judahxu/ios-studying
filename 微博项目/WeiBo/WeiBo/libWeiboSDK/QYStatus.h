//
//  QYStatus.h
//  WeiBo
//
//  Created by qingyun on 15-4-16.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYStatus : NSObject

@property (nonatomic, copy)NSString *text;

+(instancetype)statusWithInfo:(NSDictionary *)info;

@end
