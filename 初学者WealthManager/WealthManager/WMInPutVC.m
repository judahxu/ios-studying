//
//  WMInPutVC.m
//  WealthManager
//
//  Created by Maser on 15/4/29.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMInPutVC.h"
#import "WMfileManager.h"
#import "WMInsertInPutDataVC.h"


@interface WMInPutVC ()
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editAction;
@property (weak, nonatomic) IBOutlet UITextField *addDataTextField;
@property (copy, nonatomic) NSString *fileDocPath;
@end

@implementation WMInPutVC

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
- (IBAction)addAction:(id)sender
{
    if ([_editAction.title isEqualToString:@"编辑"]) {
        [self.tableView setEditing:YES animated:YES];
        _editAction.title = @"完成";
        _addDataTextField.hidden = NO;
    }else
    {
        [self.tableView setEditing:NO animated:YES];
        _addDataTextField.hidden = YES;
        _editAction.title = @"编辑";
    }
}

- (void)loadData
{
    [WMfileManager copyDataToDocuments:@"inPut.plist"];
    _fileDocPath = [WMfileManager dataDocPath:@"inPut.plist"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inCell" forIndexPath:indexPath];
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
    if (indexPath.row ==0) {
       return  UITableViewCellEditingStyleInsert;
    }
    return  UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据记录中的数据
        [_dataArray removeObjectAtIndex:indexPath.row];
        //将修改后的数据记录重新写入Plist文件中
        [_dataArray writeToFile:_fileDocPath atomically:YES];
        //将数据从界面上删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        if ([_addDataTextField.text isEqualToString:@""]||_addDataTextField.text.length ==0) {
            return;
        }else {
        //在数据记录中插入一条数据，因为第一行不能换，所以要用Indexpath.row+1
        [_dataArray insertObject:_addDataTextField.text atIndex:indexPath.row+1];
        //将修改过后的数据重新写入Plist文件中
        [_dataArray writeToFile:_fileDocPath atomically:YES];
        //在界面中插入这条数据
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
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
    
    
    if ([segue.identifier isEqualToString:@"inPush"]) {
        
    
    
    UITableViewCell *cell = (UITableViewCell *)sender;
    NSIndexPath *newIndexPath = [self.tableView indexPathForCell:cell];
    
    NSString *outModel = _dataArray[newIndexPath.row];
    WMInsertInPutDataVC *pushVC = segue.destinationViewController;
    [pushVC setValue:outModel forKey:@"inModel"];
    }
    
}


@end
