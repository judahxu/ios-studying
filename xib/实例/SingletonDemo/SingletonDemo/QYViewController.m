//
//  QYViewController.m
//  SingletonDemo
//
//  Created by qingyun on 15-3-17.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import "QYSomeClass.h"

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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        QYSomeClass *manager1 = [QYSomeClass sharedInstance];
        NSLog(@"manager1:%@", manager1);
    });                                                                                                                                                                                                                                                                             
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        QYSomeClass *manager2 = [QYSomeClass sharedInstance];
        NSLog(@"manager2:%@", manager2);
        
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        QYSomeClass *manager3 = [QYSomeClass sharedInstance];
        NSLog(@"manager3:%@", manager3);
        
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        QYSomeClass *manager4 = [QYSomeClass sharedInstance];
        NSLog(@"manager4:%@", manager4);
        
    });
    
}

@end
