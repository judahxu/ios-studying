//
//  QYSecViewController.m
//  BlockDemo
//
//  Created by qingyun on 15-4-7.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYSecViewController.h"

@interface QYSecViewController ()
@property (nonatomic, strong) Blk_t blk;
@end

@implementation QYSecViewController


- (void)dealloc
{
    NSLog(@"%s", __func__);
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

void miscOp(void)
{
    NSLog(@"%s", __func__);
}

- (void)handleSomething
{
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     QYSecViewController __weak *weakSelf = self;
    
    self.blk = ^{
        miscOp();
        [weakSelf handleSomething];
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
