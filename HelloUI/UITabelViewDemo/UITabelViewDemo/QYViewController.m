//
//  QYViewController.m
//  UITabelViewDemo
//
//  Created by qingyun on 15-2-10.
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
    
    UITableView *table = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
    
    table.separatorColor = [UIColor redColor];
    //table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    table.rowHeight = 80;
    table.sectionHeaderHeight = 60;
    table.sectionFooterHeight = 60;
    
    table.backgroundColor = [UIColor greenColor];
    //table.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_introduce_bg4-586h.jpg"]];
    
    _dataArray = @[@"kaiguo",@"laoxu",@"junjie",@"liqi",@"chengzhi",@"xiaogang",@"wangduo",@"haipeng"];
    
    table.delegate = self;
    table.dataSource = self;
    
    
    [self.view addSubview:table];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    headerView.backgroundColor = [UIColor cyanColor];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 30)];
    headerLabel.text = @"花名册";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.backgroundColor = [UIColor greenColor];
    [headerView addSubview:headerLabel];
    table.tableHeaderView = headerView;
    NSLog(@"tableview.header >>>> %@", table.tableHeaderView);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Datasource required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_dataArray count]-5;
    }
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ssssefjwlafj";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    //检测、查询是否有闲置的单元格
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
    NSLog(@"indexPath.section, indexPath.row >>>>>>> %lu,%lu", indexPath.section, indexPath.row);
    if (indexPath.row == 0) {
        cell.textLabel.text = @"xxx";
    } else {
        cell.textLabel.text = _dataArray[indexPath.row];
    }
    
    //cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - Datasource optional
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"第一组";
    } else {
        return @"第二组";
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return @"第一组end";
    } else {
        return @"第二组end";
    }
}
@end
