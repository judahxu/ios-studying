//
//  WMCollectPlayerVC.m
//  WealthManager
//
//  Created by Maser on 15/5/14.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMCollectPlayerVC.h"
#import "WMfileManager.h"
#import "WMPlayerCell.h"
#import "WMVideoModel.h"
#import <UIImageView+WebCache.h>

@interface WMCollectPlayerVC ()
@property (nonatomic,strong)NSArray *playArray;

@end

@implementation WMCollectPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

-(void)loadData
{
    NSString *filePath = [WMfileManager dataDocPath:@"collect.plist"];
    _playArray = [NSArray arrayWithContentsOfFile:filePath];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}
- (IBAction)escAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _playArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WMPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
        NSData *collectData = _playArray[indexPath.row];
    NSDictionary *collectDic = [NSKeyedUnarchiver unarchiveObjectWithData:collectData ];
    
    
    [cell.videoImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:collectDic[@"videoPic"]] andPlaceholderImage:[UIImage imageNamed:@"blackImage.png"] options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    cell.videoName.text = collectDic[@"videoName"];
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WMPlayerCell *cell = (WMPlayerCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:_playArray[indexPath.row]];
    WMCollectPlayerVC *pushVC = segue.destinationViewController;
    [pushVC setValue:dic forKey:@"collectDic"];

}


@end
