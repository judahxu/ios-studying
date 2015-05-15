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
#import "QYAccountModel.h"

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
    
    //添加登陆成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:kLoginSuccess object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:kLogout object:nil];
    
//    [self installViewController];
//    [self installTabBar];
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

#pragma mark - action

-(void)login:(NSNotification *)notification{
    self.selectedIndex = 0;
}

-(void)logout{
    //切换到到发现界面
    self.selectedIndex = 3;
    
    //用故事版初始化登陆控制器
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * loginNav = [story instantiateViewControllerWithIdentifier:@"loginNav"];
    [self presentViewController:loginNav animated:YES completion:nil];
    
    //清除登录信息
    [[QYAccountModel accountModel] logout];
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
