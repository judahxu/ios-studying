//
//  WMStockVC.m
//  WealthManager
//
//  Created by Maser on 15/5/10.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMStockVC.h"
#import "AFNetworking.h"
#import "WMStockModel.h"
#import "WMStockDapanModel.h"
#import "WMStockDaPanCell.h"
#import "WMStockBodyData.h"
#import "WMStockMoreVC.h"
#import "WMStockDataBase.h"
#import "WMfileManager.h"
#import "WMStockMoreVC.h"

@interface WMStockVC ()
@property (nonatomic,strong) NSArray *allArray;

@property (nonatomic,strong)NSMutableArray *dapanArray;
@property (nonatomic,strong)NSMutableArray *stockGidArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBtn;
@property (copy , nonatomic) NSString *filePath;
@end

@implementation WMStockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _filePath = [WMfileManager dataDocPath:@"stockGid.plist"];
    
    [self creatStockGid];
    [self creatDataBase];
    [self loadDataLocal];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getStockData) name:@"saveGidAccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDapanData) name:@"getSuccess" object:nil];
    [self getStockData];
            // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)creatStockGid
{
   
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:_filePath]) {
        [WMfileManager copyDataToDocuments:@"stockGid.plist"];
    }
    _stockGidArray = [[NSMutableArray alloc]initWithContentsOfFile:_filePath];
    
}
-(void)creatDataBase
{
    [WMStockDataBase initialize];
}
-(void)getDapanData
{
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:_allArray.count];
    for (WMStockModel *stock in _allArray) {
        NSDictionary *models = stock.stockData;
        NSString *name = models[@"name"];
        NSString *gid = models[@"gid"];
        NSString *starPri = models[@"todayStartPri"];
        NSString *endPri = models[@"yestodEndPri"];
        NSString *nowPri = models[@"nowPri"];
        NSString *maxPri = models[@"todayMax"];
        NSString *minPri = models[@"todayMin"];
        NSString *traNumber = models[@"traNumber"];
        NSString *date = models[@"date"];
        NSString *time = models[@"time"];
        WMStockBodyData *model = [WMStockBodyData initWitStockName:name stockGid:gid stockTodayStarPri:starPri stockYesTodEndPri:endPri stockNowPri:nowPri stockTodayMax:maxPri stockTodayMin:minPri stockDate:date stockTime:time stockTarsNumber:traNumber];
        [array addObject:model];
    
    }
    _dapanArray = array;
    [self.tableView reloadData];
}

-(void)loadDataLocal
{
    
    
        NSArray *dataArray = [WMStockDataBase stockArrayFromDataBase];
    if (dataArray == nil) {
        return;
    }else{
       _allArray = dataArray;
        [self getDapanData];}
}
-(void)getStockData
{
    _stockGidArray = [[NSMutableArray alloc]initWithContentsOfFile:_filePath];
    
    NSMutableArray *muArray = [[NSMutableArray alloc]initWithCapacity:_stockGidArray.count];
    NSMutableArray *saveArray = [NSMutableArray arrayWithCapacity:muArray.count];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableSet *types = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [types addObject:@"text/html"];
     manager.responseSerializer.acceptableContentTypes = types;
    for (NSString *number in _stockGidArray) {
        NSString *url = @"http://apis.haoservice.com/lifeservice/stock/hs";
    NSDictionary *parameters = @{@"gid":number,@"key":@"0bf02648114e4462a6bae329a6c89402"};
        [manager    GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            NSDictionary *dic = responseObject[@"result"];
            NSDictionary *data = dic[@"data"];
            NSString *ID = data[@"gid"];
            NSMutableDictionary *stockDic =[NSMutableDictionary dictionary];
            [stockDic addEntriesFromDictionary:dic];
            [stockDic setValue:ID forKey:@"stockID"];
            NSLog(@"%@",dic);
            WMStockModel *Stmodel = [WMStockModel initWithAllData:stockDic];
            [saveArray addObject:stockDic];
            [muArray addObject:Stmodel];
            if (muArray.count == _stockGidArray.count) {
                 _allArray = muArray;
                [WMStockDataBase deleteDataWith:@"stockTable"];
                [WMStockDataBase saveStockToDatabase:saveArray];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"getSuccess" object:nil];
            }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
                
       }];
    
    }
   

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
    return _dapanArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WMStockDaPanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stockCell" forIndexPath:indexPath];
    WMStockBodyData *model = _dapanArray[indexPath.row];
    [cell initCellWith:model];
    
    return cell;
}
- (IBAction)reloadAction:(id)sender
{
    [self getStockData];
}
- (IBAction)editAction:(id)sender
{
    if ([_editBtn.title isEqualToString:@"编辑"]) {
        [self.tableView setEditing:YES animated:YES];
        _editBtn.title = @"完成";
    }else{
        [self.tableView setEditing:NO animated:YES];
        _editBtn.title = @"编辑";
    }
}


   

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dapanArray removeObjectAtIndex:indexPath.row];
        [_stockGidArray removeObjectAtIndex:indexPath.row];
        [_stockGidArray writeToFile:_filePath atomically:YES];
        WMStockModel *model = _allArray[indexPath.row];
        [WMStockDataBase deleteDataWith:@"stockTable" cloumn:model.stockID];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"saveGidSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"getSuccess" object:nil];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WMStockDaPanCell *cell = (WMStockDaPanCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if ([segue.identifier isEqualToString:@"infoPush"]) {
        WMStockModel *model = _allArray[indexPath.row];
        WMStockMoreVC *pushVC = segue.destinationViewController;
        [pushVC setValue:model forKey:@"stockModel"];
    }
}


@end
