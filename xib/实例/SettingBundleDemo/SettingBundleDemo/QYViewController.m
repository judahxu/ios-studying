//
//  QYViewController.m
//  SettingBundleDemo
//
//  Created by qingyun on 15-3-23.
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
- (IBAction)someAction:(id)sender {
    
    // 读取
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *name = [defaults stringForKey:@"name_preference"];
    NSLog(@"%@", name);
    
    // 写操作
    [defaults setObject:@"test" forKey:@"xxx"];
    [defaults synchronize];
    
    
    
}

@end
