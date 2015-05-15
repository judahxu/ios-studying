//
//  QYPersonDetailTableViewController.m
//  WeiBo
//
//  Created by qingyun on 15-5-9.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYPersonDetailTableViewController.h"
#import "QYUserModel.h"
#import "QYAccountModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "QYPersionSectionHeaderView.h"

@interface QYPersonDetailTableViewController ()

@property (nonatomic)CGRect headerViewFrame;
@property (nonatomic, strong)QYPersionSectionHeaderView *sectionHeaderView;


@end

@implementation QYPersonDetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItΩΩem;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.headerViewFrame = self.backgroundImageView.frame;
    
    //header view
    
    self.sectionHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"PersionSectionHeaderView" owner:nil options:nil] firstObject];
    
    //取出当前登录用户的model
    QYUserModel *userModel = [[QYAccountModel accountModel] userModel];
    
    //设置人物头像为圆形
    self.iconImage.layer.cornerRadius = self.iconImage.frame.size.height / 2;
    self.iconImage.layer.borderWidth = 2.f;
    self.iconImage.layer.masksToBounds = YES;
    self.iconImage.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.3f].CGColor;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image_url]];
    
    self.nameLabel.text = userModel.name;
    self.attributes.text = [NSString stringWithFormat:@"关注 %d", userModel.friends];
    self.fans.text = [NSString stringWithFormat:@"粉丝 %d", userModel.follower];
//    self.description.text = userModel.de
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.tableHeaderView = self.tableView.tableHeaderView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.sectionHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.sectionHeaderView.frame.size.height;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - scroll view delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    NSLog(@"%f", scrollView.contentOffset.y);
    
    //如果小于0， 则扩大显示区域
    
    //增加的区域
    int offsetY = 0 - scrollView.contentOffset.y;
    
    CGRect frame = self.headerViewFrame;
    frame.size.height += offsetY;
    frame.origin.y -= offsetY;
    
    if (offsetY > 0) {
        self.backgroundImageView.frame = frame;
    }
    
}

@end
