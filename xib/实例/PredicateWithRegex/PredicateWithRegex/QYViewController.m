//
//  QYViewController.m
//  PredicateWithRegex
//
//  Created by qingyun on 15-3-10.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import "QYPerson.h"

@interface QYViewController ()

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    QYPerson *p1 = [QYPerson personWithName:@"niuer" andAge:@(18)];
    QYPerson *p2 = [QYPerson personWithName:@"zhAngsan" andAge:@(19)];
    QYPerson *p3 = [QYPerson personWithName:@"lisi" andAge:@(20)];
    QYPerson *p4 = [QYPerson personWithName:@"wangwu" andAge:@(21)];
    QYPerson *p5 = [QYPerson personWithName:@"zhaoliu" andAge:@(22)];
    QYPerson *p6 = [QYPerson personWithName:@"tianqi" andAge:@(23)];
    
    
    NSArray *personArr = @[p1, p2, p3, p4, p5, p6];
    
    // 谓词中使用通配符
    // 名字中第三个字母是‘a’的
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[cd] '??a*'"];
    NSArray *newArr = [personArr filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", newArr);
    
    // 谓词中使用正则表达式
    // 名字中以w开头，以u结尾的
//    NSString *regex = @"^w.+u$";
    NSString *regex = @"^w.*u$";
    
    predicate = [NSPredicate predicateWithFormat:@"name MATCHES %@", regex];
    newArr = [personArr filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", newArr);
    
    NSString *mobilePhone = @"18088005880";
    
    BOOL res = [QYPerson isValidMobilePhoneNumber:mobilePhone];
    if (res) {
        NSLog(@"OK Phone!");
    }
    
    NSString *emailAddress = @"xxx@gmail.com";
    if ([QYPerson isValidEmailAddress:emailAddress]) {
        NSLog(@"OK Email!");
    }
}


@end
