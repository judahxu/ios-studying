//
//  QYViewController.m
//  BarrierDemo
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
    dispatch_queue_t queue = dispatch_queue_create("com.hnqingyun.gcd", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"First job");
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"Sec job");
    });

    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Third job");
    });

    
    NSLog(@"XXX");
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Fourth job");
    });

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Fifth job");
    });

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Sixth job");
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"Seventh job");
    });
    
    
}

@end
