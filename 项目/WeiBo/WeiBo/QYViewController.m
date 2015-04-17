//
//  QYViewController.m
//  WeiBo
//
//  Created by qingyun on 15-4-16.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import "WeiboSDK.h"
#import "QYStatus.h"

@interface QYViewController ()<WBHttpRequestDelegate>

@property (nonatomic, strong)NSArray *statuses;

@end

@implementation QYViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kloginsuccess object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:kloginsuccess object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action

-(void)loginSuccess:(NSNotification *)noti{
    //请求的参数
    NSString *accessToken = noti.object;
    
    //请求的URL
    NSString *urlString = @"https://api.weibo.com/2/statuses/home_timeline.json";
    [WBHttpRequest requestWithURL:urlString httpMethod:@"GET" params:@{@"access_token": accessToken} delegate:self withTag:nil];
    
    
}


- (IBAction)login:(id)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"QYViewController"};
    [WeiboSDK sendRequest:request];
}

- (IBAction)sendStatus:(id)sender {
}

#pragma mark - weibo http delegate

-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"%@", response);
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"%@", result);
    
    NSDictionary * response = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    NSArray *statusesArray = response[@"statuses"];
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:statusesArray.count];
    
    for (NSDictionary *info in statusesArray) {
        QYStatus *status = [QYStatus statusWithInfo:info];
        [resultArray addObject:status];
    }
    self.statuses = resultArray;
    
    [self.tableView reloadData];
}

-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    
}

#pragma table View delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weibocell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.statuses[indexPath.row] text];
    return cell;
}

@end
