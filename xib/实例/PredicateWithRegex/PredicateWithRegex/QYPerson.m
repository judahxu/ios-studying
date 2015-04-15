//
//  QYPerson.m
//  PredicateWithRegex
//
//  Created by qingyun on 15-3-10.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYPerson.h"

@implementation QYPerson


+ (instancetype)personWithName:(NSString *)name andAge:(NSNumber *)age
{
    QYPerson *person = [[QYPerson alloc] init];
    person.name = name;
    person.age = age;
    
    return person;
}

- (NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"Person: <name:%@, age:%@>", _name, _age];
    
    return desc;
}

+ (BOOL)isValidMobilePhoneNumber:(NSString *)number
{
    /**
     *  移动: 134[0-8],13[5-9],15[0-27-9],18[2-478],147,178
     *  联通: 13[0-2],15[56],18[56],145,176
     *  电信: 133,134[9],153,18[019],177
     *手机号: 13[0-9],14[57],15[0-35-9],17[6-8],18[0-9]
     */
    
//    NSString *mobilePhone = @"^1()[0-9]{8}$";
    NSString *mobilePhone = @"^1(3[0-9]|4[57]|5[0-35-9]|7[6-8]|8[0-9])\\d{8}$";
    NSString *cmPhone = @"^1(34[0-8]|(3[5-9]|47|5[0-27-9]|78|8[2-478])\\d)\\d{7}$";
    NSString *cuPhone = @"^1(3[0-2]|45|5[56]|76|8[56])\\d{8}$";
    NSString *ctPhone = @"^1((33|53|77|8[019])\\d|349)\\d{7}$";
    
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobilePhone];
    NSPredicate *regexCM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cmPhone];
    NSPredicate *regexCU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cuPhone];
    NSPredicate *regexCT = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ctPhone];
    
    if (![regexMobile evaluateWithObject:number]) {
        NSLog(@"Not a valid mobile phone number!");
        return NO;
    }
    
    NSLog(@"It's a valid mobile phone number.");
    
    if ([regexCM evaluateWithObject:number]) {
        NSLog(@"It's a China Mobile phone number.");
        return YES;
    } else if ([regexCU evaluateWithObject:number]) {
        NSLog(@"It's a China Unicom phone number.");
        return YES;
    } else if ([regexCT evaluateWithObject:number]) {
        NSLog(@"It's a China Telecom phone number.");
        return YES;
    } else {
        NSLog(@"It will never go here...");
        return NO;
    }
}

+ (BOOL)isValidEmailAddress:(NSString *)email
{
    NSString *emailRegex = @"^[A-Za-z0-9_.%+-]{3,}@[A-Za-z0-9]+\\.[A-Za-z]{1,6}";
    
    NSLog(@"%@", emailRegex);
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([predicate evaluateWithObject:email]) {
        NSLog(@"Valid Email address.");
        return YES;
    }
    
    return NO;
    
}

@end
