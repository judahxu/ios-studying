//
//  QYPerson.h
//  PredicateWithRegex
//
//  Created by qingyun on 15-3-10.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYPerson : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *age;


+ (instancetype)personWithName:(NSString *)name andAge:(NSNumber *)age;

/* 该函数判断一个给定手机号是否是合法号码
 * 如果是，返回YES，否则，返回NO
 * 如果是合法手机号，还要再判断出，是移动、联通还是电信号码，并打印输出
 */
+ (BOOL)isValidMobilePhoneNumber:(NSString *)number;

+ (BOOL)isValidEmailAddress:(NSString *)email;


@end
