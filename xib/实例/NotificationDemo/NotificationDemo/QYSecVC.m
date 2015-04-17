//
//  QYSecVC.m
//  NotificationDemo
//
//  Created by qingyun on 15-3-26.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYSecVC.h"

@interface QYSecVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation QYSecVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self performSelectorInBackground:@selector(postNoti) withObject:nil];
    
}

- (void)postNoti
{
    NSLog(@"backGroundThread:%@", [NSOperationQueue currentQueue]);
        NSDictionary *userInfo = @{@"name":@"zhangsan",@"foo":@"bar",@"age":@"18",@"textField":_textField.text};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Suibianxie" object:@"first" userInfo:userInfo];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    NSLog(@"%s", __func__);
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
