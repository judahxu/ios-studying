//
//  QYViewController.m
//  WeiBo
//
//  Created by qingyun on 15-4-17.
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSeccess:) name:@"loginSeccess" object:nil];
}

-(void)loginSeccess:(NSNotification *)noti{
    // self.token = noti.object;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
