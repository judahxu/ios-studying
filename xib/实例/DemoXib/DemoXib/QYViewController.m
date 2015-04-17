//
//  QYViewController.m
//  DemoXib
//
//  Created by qingyun on 15-3-26.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

@interface QYViewController ()

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"View" owner:nil options:nil];
    
    UINib *nib = [UINib nibWithNibName:@"SomeView" bundle:nil];
    NSArray *views = [nib instantiateWithOwner:nil options:nil];

    
    NSLog(@"%@", views);
    
    self.view = (UIView *)views[0];
    UILabel *label = (UILabel *)views[1];
    
    label.frame = CGRectMake(100, 100, 100, 30);
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
