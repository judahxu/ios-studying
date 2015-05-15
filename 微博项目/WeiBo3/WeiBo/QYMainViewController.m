//
//  QYMainViewController.m
//  WeiBo
//
//  Created by qingyun on 15-4-20.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

//初始化各个子模块入口

#import "QYMainViewController.h"

#import "QYHomeViewController.h"
#import "QYMessageTableViewController.h"
#import "QYFindTableViewController.h"
#import "QYMeViewController.h"

@interface QYMainViewController ()

@end

@implementation QYMainViewController

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
    
    [self installViewController];
    [self installTabBar];
}

-(void)installViewController{
    //初始化每个子控制器，并且添加到tabbarVC上
    
    QYHomeViewController *homeVC = [[QYHomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    QYMessageTableViewController *message = [[QYMessageTableViewController alloc] init];
    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:message];
    
    QYFindTableViewController *findVC= [[QYFindTableViewController alloc] init];
    UINavigationController *findNav = [[UINavigationController alloc] initWithRootViewController:findVC];
    
    QYMeViewController *meVC = [[QYMeViewController alloc] init];
    UINavigationController *meNav= [[UINavigationController alloc] initWithRootViewController:meVC];
    
    UIViewController *temp = [[UIViewController alloc] init];
    
    self.viewControllers = @[homeNav, messageNav, temp, findNav, meNav];
}

-(void)installTabBar{
    //在tabbar 中间添加加号
    self.tabBar.tintColor = [UIColor orangeColor];
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
