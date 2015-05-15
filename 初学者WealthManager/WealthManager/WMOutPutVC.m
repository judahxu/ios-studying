//
//  WMOutPutVC.m
//  WealthManager
//
//  Created by Maser on 15/4/29.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMOutPutVC.h"
#import "WMfileManager.h"
#import "WMInsertDataVC.h"




@interface WMOutPutVC ()
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBtn;
@property (weak, nonatomic) IBOutlet UITextField *addDataTextField;
@property (copy, nonatomic)NSString *fileDocPath;
@end

@implementation WMOutPutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self.tabBarController setHidesBottomBarWhenPushed:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"saveImage.jpg"]];
}
- (IBAction)escAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)editAction:(id)sender
{
   
   
    if ([_editBtn.title  isEqualToString: @"编辑"] ) {
        [self.tableView setEditing:YES animated:YES];
         _editBtn.title = @"完成";
        _addDataTextField.hidden = NO;
        
    }else
    {
        [self.tableView setEditing:NO animated:YES];
        _editBtn.title = @"编辑";
        _addDataTextField.hidden = YES;
            }
    
    
}
- (void)loadData
{
    [WMfileManager copyDataToDocuments:@"outPut.plist"];
    _fileDocPath = [WMfileManager dataDocPath:@"outPut.plist"];
    _dataArray = [[NSMutableArray alloc]initWithContentsOfFile:_fileDocPath];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"outCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return UITableViewCellEditingStyleInsert;
        
    }
    return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //将数据从数据记录中移除
        [_dataArray removeObjectAtIndex:indexPath.row];
        //将修改后的数据重新写入Plist文件中
        [_dataArray writeToFile:_fileDocPath atomically:YES];
        //从UI界面中将单元格移除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
                if ([_addDataTextField.text isEqualToString:@""]||_addDataTextField.text.length==0) {
        
            return;
        }else {
        [_dataArray insertObject:_addDataTextField.text atIndex:indexPath.row+1];
        //更新Plist文件
        [_dataArray writeToFile:_fileDocPath atomically:YES];
        //在界面上穿件一个新的indexpath的对象，然后将数据显示出来
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            _addDataTextField.text = nil;
        }
        
    }   
}


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
    
    if ([segue.identifier isEqualToString:@"cellPush"]) {
    UITableViewCell *cell = (UITableViewCell *)sender;
    NSIndexPath *newIndexPath = [self.tableView indexPathForCell:cell];
    
    NSString *outModel = _dataArray[newIndexPath.row];
    WMInsertDataVC *pushVC = segue.destinationViewController;
    [pushVC setValue:outModel forKey:@"outModel"];
    }
    
}


@end
