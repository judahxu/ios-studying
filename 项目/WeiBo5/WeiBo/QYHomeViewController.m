//
//  QYHomeViewController.m
//  WeiBo
//
//  Created by qingyun on 15-4-20.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYHomeViewController.h"
#import "QYAccountModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "QYStatusTableViewCell.h"



@interface QYHomeViewController ()

@property (nonatomic, strong) NSArray *statusesArray;

@end

@implementation QYHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.title = @"发现";
        
        UIImage *image = [[UIImage imageNamed:@"12"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:image selectedImage:image];
        
        NSDictionary *att = @{NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: [UIColor orangeColor]};
//
        [self.tabBarItem setTitleTextAttributes:att forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    
    //添加观察者，档登陆成功后请求最新的数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:kLoginSuccess object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    //模拟从网络请求数据
    //获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"statues" ofType:nil];
    
    NSString *statusdString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //转化为二进制数据
    NSData *statusData = [statusdString dataUsingEncoding:NSUTF8StringEncoding];
    //解析位json对象
    NSDictionary *statusDic = [NSJSONSerialization JSONObjectWithData:statusData options:0 error:nil];
    
    //从返回的结果中，取出微博列表
    NSArray *status = statusDic[@"statuses"];
    self.statusesArray = status;
    //更新UI

    
    
    return;
    //获取access_token
    NSMutableDictionary *dic = [[QYAccountModel accountModel] requestParameters];
    //根据是否为空，是否可以请求
    if (!dic) {
        return;
    }
    //请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"url" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //从返回的结果中，取出微博列表
        NSArray *status = responseObject[@"statuses"];
        self.statusesArray = status;
        //更新UI
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark - table View data source delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QYStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell" forIndexPath:indexPath];
    //绑定cell上的内容
    NSDictionary *status = self.statusesArray[indexPath.row];;
    //从微博字典中取出用户字典
    NSDictionary *userDic = status[kStatusUserInfo];
    cell.nameLabel.text = userDic[kUserInfoName];
    //设置正文
    cell.contentText.text = status[kStatusText];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121;
}

@end
