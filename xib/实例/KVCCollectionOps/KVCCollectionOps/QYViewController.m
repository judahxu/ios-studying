//
//  QYViewController.m
//  KVCCollectionOps
//
//  Created by qingyun on 15-3-10.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import "QYTransaction.h"

@interface QYViewController ()

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    QYTransaction *t1 = [[QYTransaction alloc] init];
    t1.payee = @"zhangsan";
    t1.amount = 100;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    components.year = 2009;
    components.month = 12;
    components.day = 1;
    
    NSDate *date = [calendar dateFromComponents:components];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = kCFDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    formatter.locale = usLocale;
    
    NSLog(@"%@", [formatter stringFromDate:date]);
    
    t1.date = date;

    
    QYTransaction *t2 = [[QYTransaction alloc] init];
    t2.payee = @"lisi";
    t2.amount = 200;
    
    components.year = 2010;
    components.month = 1;
    components.day = 1;
    
    t2.date = [calendar dateFromComponents:components];
    
    QYTransaction *t3 = [[QYTransaction alloc] init];
    t3.payee = @"wangwu";
    t3.amount = 300;
    
    components.year = 2015;
    components.month = 3;
    components.day = 10;
    
    t3.date = [calendar dateFromComponents:components];
    
    NSArray *transactions = @[t1, t2, t3];
    
    NSNumber *avg = [transactions valueForKeyPath:@"@avg.amount"];
    
    NSLog(@"avg:%@", avg);
    
    
    NSLog(@"Count of transactions is : %@", [transactions valueForKeyPath:@"@count"]);
    
    NSDate *latestDate = [transactions valueForKeyPath:@"@max.date"];
    
    NSLog(@"latestDate:%@", [formatter stringFromDate:latestDate]);
    
    NSDate *earlistDate = [transactions valueForKeyPath:@"@min.date"];
    
    NSLog(@"earliestDate:%@", [formatter stringFromDate:earlistDate]);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
