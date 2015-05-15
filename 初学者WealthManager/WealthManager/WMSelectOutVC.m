//
//  WMSelectOutVC.m
//  WealthManager
//
//  Created by Maser on 15/5/7.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMSelectOutVC.h"
#import "WMSelectOutPutCell.h"
#import "WMDataBase.h"
#import "FMDatabase.h"
#import "FMDB.h"
#import "WMOutPutModel.h"


@interface WMSelectOutVC ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)UIToolbar *didToolBar;
@property (nonatomic,strong)UIPickerView *choicePicker;
@property (nonatomic,strong)NSArray *yearData;
@property (nonatomic,strong)NSArray *mouthData;
@property (copy , nonatomic)NSString *yearStr;
@property (copy , nonatomic)NSString *mouthStr;



@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBtn;
@property (copy , nonatomic) NSString *selectPoint;
@end

@implementation WMSelectOutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [self selectOutPutTable];
    [self.tableView reloadData];
    [self steupView];
    [self getPickData];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"saveImage.jpg"]];
}

-(void)getPickData
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"date" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    _yearData = dic [@"year"];
    _mouthData = dic [@"mouth"];
}
-(void)steupView
{
    
    UIBarButtonItem *escBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(endAction:)];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneAction:)];
    UIBarButtonItem *spaceBtn = [[UIBarButtonItem alloc]init];
    
    NSArray *btnArray = [[NSArray alloc]initWithObjects:escBtn,spaceBtn,spaceBtn,
                         spaceBtn,spaceBtn,spaceBtn,spaceBtn,spaceBtn,spaceBtn,spaceBtn,spaceBtn,doneBtn, nil];
    _didToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44)];
    [_didToolBar setItems:btnArray];
    _didToolBar.hidden = YES;
    _choicePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height+1, self.view.bounds.size.width, 162)];
    _choicePicker.tag = 10000;
    _choicePicker.backgroundColor = [UIColor whiteColor];
    _choicePicker.hidden = YES;
    _choicePicker.delegate =self;
    _choicePicker.dataSource = self;
    
    [self.view addSubview:_didToolBar];
    [self.view addSubview:_choicePicker];
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
-(NSArray *)selectOutPutTableWithPoint:(NSString *)point
{ //将数据从数据库请求出来，并且转换成模型类，存入一个可变数组中，然后赋值给属性数组，将可变数组当成tableview的数据源
    NSString *dbPath = [WMDataBase DatabasePathWithName:@"WMSqliteDB.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    NSString *selectSql = [NSString stringWithFormat:@"select * from outPutTable where outPutDate = '%@' order by outPutID DESC",point];
    [db open];
    FMResultSet *result = [db executeQuery:selectSql];
    NSMutableArray *resArray = [NSMutableArray array];
    while ([result next]) {
        NSString *model = [result stringForColumn:@"outPutModel"];
        NSString *money = [result stringForColumn:@"outPutMoney"];
        NSString *date = [result stringForColumn:@"outPutDate"];
        NSString *day = [result stringForColumn:@"outPutDay"];
        NSString *used = [result stringForColumn:@"outPutUsed"];
        NSString *comment = [result stringForColumn:@"outPutComment"];
        WMOutPutModel *models = [WMOutPutModel initWithID:0 outPutModel:model outPutMoney:money outPutDate:date outPutDay:day outPutUsed:used outPutComment:comment];
        [resArray addObject:models];
        
    }
    [db close];
    return resArray;
}

-(void)getSelectPickeData
{
    NSInteger row = [self.choicePicker selectedRowInComponent:0];
    NSInteger row1 = [self.choicePicker selectedRowInComponent:1];
    _yearStr = _yearData[row];
    _mouthStr = _mouthData[row1];
}


- (void)viewAnimation:(UIView *)view willHidden:(BOOL)hidden
{
    //重用动画
    [UIView animateWithDuration:0.3 animations:^{
        if (hidden) {
            view.frame = CGRectMake(0, self.view.bounds.size.height+44, self.view.bounds.size.width, 162);
        }else
        {
            //[view setHidden:YES];
            view.frame = CGRectMake(0, self.view.bounds.size.height - 162, self.view.bounds.size.width, 162);
        }
        
    } completion:^(BOOL finished) {
        [view setHidden:hidden];
    }];
}

- (void)toolBarAnimation:(UIToolbar *)toolBar willHidden:(BOOL)hidden
{
    [UIView animateWithDuration:0.3 animations:^{
        if (hidden) {
            toolBar.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44);
        }else
        {
            // [toolBar setHidden:YES];
            toolBar.frame = CGRectMake(0, self.view.bounds.size.height-206, self.view.bounds.size.width, 44);
        }
    }completion:^(BOOL finished) {
        [toolBar setHidden:hidden];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --pickview dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 2;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _yearData.count;
    }else
    {
        return _mouthData.count;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSString *yearStr ;
    if (component == 0) {
        yearStr = _yearData[row];
    }else
    {
        yearStr = _mouthData[row];
    }
    return yearStr;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WMSelectOutPutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    WMOutPutModel *model = _dataArray[indexPath.row];
    cell.modelLabel.text = model.outPutModel;
    cell.moneyLabel.text = model.outPutMoney;
    cell.dateLabel.text = [NSString stringWithFormat:@"%@-%@",model.outPutDate,model.outPutDay];
    cell.usedLabel.text = model.outPutUsed;
    cell.commentLable.text = model.outPutComment;
    
    return cell;
}

#pragma mark --ButtonAction
- (IBAction)selectAction:(id)sender
{
    if ([_editBtn.title isEqualToString:@"选择日期"]) {
        [self.view bringSubviewToFront:_didToolBar];
        [self.view bringSubviewToFront:_choicePicker];
        [self toolBarAnimation:_didToolBar willHidden:NO];
        [self viewAnimation:_choicePicker willHidden:NO];
        self.tableView.userInteractionEnabled = NO;
        
    }else
    {
        NSString *pointStr = [NSString stringWithFormat:@"%@-0%@",_yearStr,_mouthStr];
       _dataArray = [self selectOutPutTableWithPoint:pointStr];
        [self.tableView reloadData];
        _editBtn.title =@"选择日期";
    }
}
-(void)endAction:(id)sender
{
    if (_choicePicker.hidden == NO) {
        [self viewAnimation:_choicePicker willHidden:YES];
        [self toolBarAnimation:_didToolBar willHidden:YES];
    }
    [self.tableView setUserInteractionEnabled:YES];

}
-(void)doneAction:(id)sender
{
    if (_choicePicker.hidden ==NO) {
        //获取支出类型的值
        [self getSelectPickeData];
        NSString *titleStr = [NSString stringWithFormat:@"查询%@年%@月",_yearStr,_mouthStr];
        _editBtn.title = titleStr;
        [self viewAnimation:_choicePicker willHidden:YES];
        [self toolBarAnimation:_didToolBar willHidden:YES];
        [self.tableView setUserInteractionEnabled:YES];
        
}
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
