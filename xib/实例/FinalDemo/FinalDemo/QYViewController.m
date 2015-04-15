//
//  QYViewController.m
//  FinalDemo
//
//  Created by qingyun on 15-3-17.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

@interface QYViewController ()

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startProcess:(id)sender {
    
    dispatch_queue_t queue = dispatch_queue_create("com.hnqingyun.final", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"First...");
        dispatch_sync(queue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"Second...");
        });
        NSLog(@"Third...");
    });
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Fourth...");
    });
    
    NSLog(@"Final...");
    
}
@end
