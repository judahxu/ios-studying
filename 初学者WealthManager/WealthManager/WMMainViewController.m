//
//  WMMainViewController.m
//  WealthManager
//
//  Created by Maser on 15/5/9.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMMainViewController.h"
#import "WMDataBase.h"
#import "FMDatabase.h"
#import "FMDB.h"





@interface WMMainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *allInPutMoney;
@property (weak, nonatomic) IBOutlet UILabel *allOutPutMoney;

@end

@implementation WMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [WMDataBase copyDataBaseToDocumentWithName:@"WMSqliteDB.db"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getInPutSum) name:@"saveInPutSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getOutPutSum) name:@"saveOutPutSuccess" object:nil];
    [self getInPutSum];
     [self getOutPutSum];
    _lookBtn.layer.cornerRadius = 5.0;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainImage.jpeg"]];
}

-(void)getInPutSum
{
    NSArray *inPutMoney = [self selectInPutTable];
    NSString *allInPutMoney;
    double sum = 0;
    for (NSString *money in inPutMoney) {
        sum +=[money doubleValue];
    }
    allInPutMoney = [NSString stringWithFormat:@"%.2f",sum];
    _allInPutMoney.text = allInPutMoney;
}

-(void)getOutPutSum
{
    NSArray *outPutMoney = [self selectOutPutTable];
    NSString *allOutPutMoney;
    double sum = 0;
    for (NSString *money in outPutMoney) {
        sum +=[money doubleValue];
    }
    allOutPutMoney = [NSString stringWithFormat:@"%.2f",sum];
    _allOutPutMoney.text = allOutPutMoney;
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
        NSString * money = [result stringForColumn:@"inPutMoney"];
       [resArray addObject:money];
        
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
        NSString *money = [result stringForColumn:@"outPutMoney"];
        
        [resArray addObject:money];
    }
    [db close];
    return resArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
