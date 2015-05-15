//
//  WMSelectInPutVCViewController.m
//  WealthManager
//
//  Created by Maser on 15/5/8.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMSelectInPutVC.h"
#import "WMSelectInPutCell.h"
#import "WMInPutModel.h"
#import "FMDatabase.h"
#import "FMDB.h"
#import "WMDataBase.h"

@interface WMSelectInPutVC ()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *PointBtn;


@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)UIToolbar *didToolBar;
@property (nonatomic,strong)UIPickerView *choicePicker;
@property (nonatomic,strong)NSArray *yearData;
@property (nonatomic,strong)NSArray *mouthData;
@property (copy , nonatomic)NSString *yearStr;
@property (copy , nonatomic)NSString *mouthStr;

@property (copy , nonatomic) NSString *selectPoint;
@end

@implementation WMSelectInPutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPickData];
    [self steupView];
    _dataArray = [self selectInPutTable];
    [self.tableView reloadData];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"saveImage.jpg"]];
}

-(void)getPickData
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"date" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    _yearData = dic [@"year"];
    _mouthData = dic [@"mouth"];
}

-(void)getSelectPickeData
{
    NSInteger row = [self.choicePicker selectedRowInComponent:0];
    NSInteger row1 = [self.choicePicker selectedRowInComponent:1];
    _yearStr = _yearData[row];
    _mouthStr = _mouthData[row1];
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



-(NSArray *)selectInPutTable
{ //将数据从数据库请求出来，并且转换成模型类，存入一个可变数组中，然后赋值给属性数组，将可变数组当成tableview的数据源
    NSString *dbPath = [WMDataBase DatabasePathWithName:@"WMSqliteDB.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    NSString *selectSql = [NSString stringWithFormat:@"select * from inPutTable order by inPutID DESC"];
    [db open];
    FMResultSet *result = [db executeQuery:selectSql];
    NSMutableArray *resArray = [NSMutableArray array];
    while ([result next]) {
        int ID = [[result stringForColumn:@"inPutID"]intValue];
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

-(NSArray *)selectInPutTableWithPoint:(NSString *)point
{ //将数据从数据库请求出来，并且转换成模型类，存入一个可变数组中，然后赋值给属性数组，将可变数组当成tableview的数据源
    NSString *dbPath = [WMDataBase DatabasePathWithName:@"WMSqliteDB.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    NSString *selectSql = [NSString stringWithFormat:@"select * from inPutTable where inPutDate = '%@' order by inPutDate DESC",point];
    [db open];
    FMResultSet *result = [db executeQuery:selectSql];
    NSMutableArray *resArray = [NSMutableArray array];
    while ([result next]) {
        int ID = [[result stringForColumn:@"inPutID"]intValue];
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
    WMSelectInPutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor clearColor];
    WMInPutModel *model = _dataArray[indexPath.row];
    cell.inPutModelLabel.text = model.inPutModel;
    cell.inPutMoneyLabel.text = model.inPutMoney;
    cell.inPutDateLabel.text = [NSString stringWithFormat:@"%@-%@",model.inPutDate ,model.inPutDay];
    NSLog(@"%@",model.inPutDay);
    cell.inPutCommentLabel.text = model.inPutComment;
    
    return cell;
}

- (IBAction)selectAction:(id)sender
{
    if ([_PointBtn.title isEqualToString:@"选择日期"]) {
        [self.view bringSubviewToFront:_didToolBar];
        [self.view bringSubviewToFront:_choicePicker];
        [self toolBarAnimation:_didToolBar willHidden:NO];
        [self viewAnimation:_choicePicker willHidden:NO];
        self.tableView.userInteractionEnabled = NO;
        
    }else
    {
        NSString *pointStr = [NSString stringWithFormat:@"%@-0%@",_yearStr,_mouthStr];
        _dataArray = [self selectInPutTableWithPoint:pointStr];
        [self.tableView reloadData];
        _PointBtn.title =@"选择日期";
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
        _PointBtn.title = titleStr;
        [self viewAnimation:_choicePicker willHidden:YES];
        [self toolBarAnimation:_didToolBar willHidden:YES];
        [self.tableView setUserInteractionEnabled:YES];
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
