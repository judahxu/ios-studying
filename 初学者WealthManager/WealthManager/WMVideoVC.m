//
//  WMVideoVC.m
//  WealthManager
//
//  Created by Maser on 15/5/12.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMVideoVC.h"
#import "AFNetworking.h"
#import "WMVideoModel.h"
#import "WMVideoCell.h"
#import "WMVideoHeaderView.h"
#import "WMVideoPlayerVC.h"
#import "WMfileManager.h"

#define kTuDouAppKey @"c282fed9faebd09c"
@interface WMVideoVC ()<UITextFieldDelegate>
@property (nonatomic,strong)NSArray *vedioArray;
@property (nonatomic,strong)WMVideoCell *calculateCell;

@property (nonatomic,strong)WMVideoHeaderView *headerView;
@property (copy, nonatomic)NSString *videoName;
@end

@implementation WMVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setShouCangPlist];
    UINib *nib = [UINib nibWithNibName:@"WMVideoHeaderView" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:@"WMVideoHeaderView"];
    
    [self loadDataWithName:@"刘彦斌"];
}
-(void)setShouCangPlist
{
    [WMfileManager copyDataToDocuments:@"collect.plist"];
}
-(void)loadDataWithName:(NSString *)name
{
    
    
    NSDictionary *parameter = @{@"app_key":kTuDouAppKey,@"format":@"json", @"kw":name};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableSet *types = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [types addObject:@"text/plain"];
    manager.responseSerializer.acceptableContentTypes = types;
    [manager GET:@"http://api.tudou.com/v6/video/search" parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSMutableArray *myArray = [NSMutableArray array];
        NSMutableArray *dataArray = responseObject[@"results"];
        for (NSDictionary *dic in dataArray) {
            WMVideoModel *model = [WMVideoModel getVideoWithDic:dic];
            [myArray addObject:model];
        }
        _vedioArray = myArray;
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _vedioArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WMVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell" forIndexPath:indexPath];
    WMVideoModel *videoModel = _vedioArray[indexPath.row];
    [cell setVideoModel:videoModel];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    WMVideoHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WMVideoHeaderView"];
    headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
    headerView.videoNameTextField.delegate = self;
    headerView.videoNameTextField.returnKeyType = UIReturnKeySearch;
    headerView.videoNameTextField.keyboardType = UIKeyboardAppearanceDefault;
    
    
    
    
    
      return headerView;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length == 0) {
        
        return YES;
    }
    _videoName = textField.text;
    [self loadDataWithName:_videoName];
        return  YES;
}

#pragma mark -- textField deledage

/*
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMVideoCell *cell = self.calculateCell;
    WMVideoModel *model = _vedioArray[indexPath.row];
    [cell setVideoModel:model];
    return cell;
}
 */
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"playPush"]) {
        
    
    WMVideoCell *cell = (WMVideoCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    WMVideoPlayerVC *pushVC = segue.destinationViewController;
    WMVideoModel *model = _vedioArray[indexPath.row];
    [pushVC setValue:model forKey:@"videoModel"];
    }
    
}


@end
