//
//  QYViewController.m
//  NotificationDemo
//
//  Created by qingyun on 15-3-26.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

@interface QYViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) NSOperationQueue *otherQueue;

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(demoNoti:) name:@"Suibianxie" object:@"first"];
    
    _otherQueue = [[NSOperationQueue alloc] init];
    
    if ([NSOperationQueue mainQueue] == [NSOperationQueue currentQueue]) {
        NSLog(@"1.当前线程是主线程");
    }
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"Suibianxie" object:@"first" queue:_otherQueue usingBlock:^(NSNotification *note) {
        [NSThread sleepForTimeInterval:3];
        
        if ([NSOperationQueue mainQueue] == [NSOperationQueue currentQueue]) {
            NSLog(@"2.当前线程是主线程");
        } else {
            NSLog(@"2.当前线程不是主线程");
        }
        
        if ([NSOperationQueue currentQueue] == _otherQueue) {
            NSLog(@"Other queue");
        }

        
        [self performSelectorOnMainThread:@selector(demoNoti:) withObject:note waitUntilDone:YES];
        
   
    }];
    
    
}


- (void)demoNoti:(NSNotification *)noti
{
    [NSThread sleepForTimeInterval:5];
    NSLog(@"%@", noti.userInfo);
    NSLog(@"noti:%@", noti);
    _label.text = (NSString *)(noti.userInfo)[@"textField"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(UIStoryboardSegue *)sender
{
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Suibianxie" object:nil];
}

@end
