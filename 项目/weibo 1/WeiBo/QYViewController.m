//
//  QYViewController.m
//  WeiBo
//
//  Created by qingyun on 15-4-17.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import "QYStatus.h"
#import "AFNetworking.h"
#import "QYSendweibo.h"
#import "WeiBo-Prefix.pch"
@interface QYViewController ()
@property NSString *accessToken;
@property NSArray *status;
@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSeccess:) name:@"loginSeccess" object:nil];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"sendMassage"]) {
        if (!self.accessToken) {
            return NO;
        }
    }
    return YES;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"sendMassage"]) {
    UINavigationController *nav = segue.destinationViewController;
    QYSendweibo *message = (QYSendweibo *)[[nav viewControllers] firstObject];
        message.accessToken = self.accessToken;
        //[message setValue:self.accessToken forKey:@"accessToken"];

    }
}
-(void)loginSeccess:(NSNotification *)noti{
     self.accessToken = noti.object;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableSet *types = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [types addObject:@"text/plain"];
    manager.responseSerializer.acceptableContentTypes = types;
    
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/public_timeline.json?access_token=%@", self.accessToken];
    
    [manager GET:urlStr parameters:@{@"access_token":self.accessToken} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *result = responseObject[@"statuses"];
        
        NSMutableArray *resultsArray = [NSMutableArray arrayWithCapacity:self.status.count];
        for (NSDictionary *info in result) {
            QYStatus *status = [QYStatus statusWithDictory:info];
            [resultsArray addObject:status];
        }
        self.status = resultsArray;
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - table View delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.status.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCellID" forIndexPath:indexPath];
    cell.textLabel.text = [self.status[indexPath.row] text];
    return cell;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
