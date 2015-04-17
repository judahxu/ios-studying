//
//  QYViewController.m
//  B
//
//  Created by qingyun on 15-4-15.
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
- (IBAction)openApp:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"a://"]];
}

@end
