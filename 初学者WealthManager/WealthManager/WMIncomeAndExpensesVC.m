//
//  WMIncomeAndExpensesVC.m
//  WealthManager
//
//  Created by Maser on 15/4/29.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMIncomeAndExpensesVC.h"
#import "FMDatabase.h"
#import "FMDB.h"
#import "WMDataBase.h"
#import "WMOutPutModel.h"
#import "WMInPutModel.h"
#import "WMInAndOutSelectCell.h"
#import "WMInAndOutModel.h"
#import "WMDetailVC.h"


@interface WMIncomeAndExpensesVC ()
@property (nonatomic,strong)NSArray *allArray;

@end

@implementation WMIncomeAndExpensesVC

- (void)viewDidLoad {
    [super viewDidLoad];
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sortDataSource) name:@"saveInPutSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sortDataSource) name:@"saveOutPutSuccess" object:nil];
    [self sortDataSource];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainImage.jpeg"]];

   
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"saveInPutSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"saveOutPutSuccess" object:nil];
}

-(void)sortDataSource
{
    NSMutableArray *mediaArray = [self getDataSource];
    if (mediaArray.count >30) {
        NSArray *sortArray = [mediaArray sortedArrayUsingComparator:^NSComparisonResult(WMInAndOutModel *obj1, WMInAndOutModel *obj2) {
        NSComparisonResult result = [obj1.date compare:obj2.date];
        
        return result;
    }];
        NSMutableArray *allArray = [[NSMutableArray alloc]initWithArray:sortArray];
        [allArray removeObject:allArray.lastObject];
        
    }
    NSArray *sortArray = [mediaArray sortedArrayUsingComparator:^NSComparisonResult(WMInAndOutModel *obj1, WMInAndOutModel *obj2) {
        NSComparisonResult result = [obj2.date compare:obj1.date];
        
        return result;
    }];

    _allArray = sortArray;
    [self.tableView reloadData];
    
}
-(NSMutableArray *)getDataSource
{
    NSArray *inPutArray = [self selectInPutTable];
    NSArray *outPutArray = [self selectOutPutTable];
    NSMutableArray *allArray = [[NSMutableArray alloc]initWithCapacity:inPutArray.count+outPutArray.count];
    for (int i =0; i<outPutArray.count; i++) {
        WMOutPutModel *model = outPutArray[i];
        NSString *ID = [NSString stringWithFormat:@"支出%d",model.outPutID];
        WMInAndOutModel *newModel = [[WMInAndOutModel alloc]initWithID:ID money:model.outPutMoney date:[NSString stringWithFormat:@"%@-%@",model.outPutDate,model.outPutDay]];
        [allArray addObject:newModel];
    }
    for (int i = 0; i<inPutArray.count; i++) {
        WMInPutModel *model = inPutArray[i];
        NSString *ID = [NSString stringWithFormat:@"收入%d",model.inPutID];
        WMInAndOutModel *newModel = [[WMInAndOutModel alloc]initWithID:ID money:model.inPutMoney date:[NSString stringWithFormat:@"%@-%@",model.inPutDate,model.inPutDay]];
        [allArray addObject:newModel];
    }
    return allArray;
}
-(NSArray *)selectInPutTable
{ //将数据从数据库请求出来，并且转换成模型类，存入一个可变数组中，然后赋值给属性数组，将可变数组当成tableview的数据源
    NSString *dbPath = [WMDataBase DatabasePathWithName:@"WMSqliteDB.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    NSString *selectSql = [NSString stringWithFormat:@"select * from inPutTable order by inPutID DESC"];
    [db open];
    FMResultSet *result = [db executeQuery:selectSql];
    NSMutableArray *resArray = [NSMutableArray array];
    while ([result next]) {
        int ID = [[result stringForColumn:@"inPutID"] intValue];
        NSString *model = [result stringForColumn:@"inPutModel"];
        NSString *money = [result stringForColumn:@"inPutMoney"];
        NSString *date = [result stringForColumn:@"inPutDate"];
        NSString *day = [result stringForColumn:@"inPutDay"];
        NSString *comment = [result stringForColumn:@"inPutComment"];
        WMInPutModel *models = [[WMInPutModel alloc]initWithID:ID inPutModel:model money:money date:date day:day comment:comment];
            [resArray addObject:models];
        
    }
    [db close];
    return resArray;
}


-(NSArray *)selectOutPutTable
{ //将数据从数据库请求出来，并且转换成模型类，存入一个可变数组中，然后赋值给属性数组，将可变数组当成tableview的数据源
    NSString *dbPath = [WMDataBase DatabasePathWithName:@"WMSqliteDB.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    NSString *selectSql = [NSString stringWithFormat:@"select * from outPutTable order by outPutID DESC"];
    [db open];
    FMResultSet *result = [db executeQuery:selectSql];
    NSMutableArray *resArray = [NSMutableArray array];
    while ([result next]) {
        int ID = [[result stringForColumn:@"outPutID"]intValue];
        NSString *model = [result stringForColumn:@"outPutModel"];
        NSString *money = [result stringForColumn:@"outPutMoney"];
        NSString *date = [result stringForColumn:@"outPutDate"];
        NSString *day = [result stringForColumn:@"outPutDay"];
        NSString *used = [result stringForColumn:@"outPutUsed"];
        NSString *comment = [result stringForColumn:@"outPutComment"];
        WMOutPutModel *models = [WMOutPutModel initWithID:ID outPutModel:model outPutMoney:money outPutDate:date outPutDay:day outPutUsed:used outPutComment:comment];
        [resArray addObject:models];
        
    }
    [db close];
    return resArray;
}

- (IBAction)escAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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

    return _allArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WMInAndOutSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"allCell" forIndexPath:indexPath];
    WMInAndOutModel *model = _allArray[indexPath.row];
    NSString *myStr = model.ID;
    NSString *enStr = [myStr substringWithRange:NSMakeRange(0, 2)];
    if ([enStr isEqualToString:@"支出"]) {
        cell.modelLable.text = [NSString stringWithFormat:@"支出%@",model.money];
    }else
    {
        cell.modelLable.text = [NSString stringWithFormat:@"收入%@",model.money];
    }
    cell.timeLable.text = model.date;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark notifition

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
    UITableViewCell *cell = (UITableViewCell *)sender;
    NSIndexPath *newIndexPath = [self.tableView indexPathForCell:cell];
    if ([segue.identifier isEqualToString:@"myPush"]) {
        
    
    WMInAndOutModel *model = _allArray[newIndexPath.row];
    WMDetailVC *pushVC = segue.destinationViewController;
    [pushVC setValue:model forKey:@"getModel"];
    }
    
}


@end
