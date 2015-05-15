//
//  WMDetailVC.m
//  WealthManager
//
//  Created by Maser on 15/5/9.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMDetailVC.h"
#import "WMInAndOutModel.h"
#import "FMDatabase.h"
#import "FMDB.h"
#import "WMInPutModel.h"
#import "WMOutPutModel.h"
#import "WMDataBase.h"


@interface WMDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *usedLabel;
@property (weak, nonatomic) IBOutlet UILabel *usedLabel1;
@property (nonatomic,strong)NSArray *dataArray;


@property (nonatomic,strong)WMInAndOutModel *getModel;

@end

@implementation WMDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",_getModel.ID);
    [self getData];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainImage.jpeg"]];
}

-(void)getData
{
    NSString *dataPoint = [_getModel.ID substringWithRange:NSMakeRange(2, 1)];
    NSString *dataStr = [_getModel.ID substringWithRange:NSMakeRange(0, 2)];
    if ([dataStr isEqualToString:@"支出"]) {
        _dataArray = [self selectOutPutTableWithPoint:dataPoint];
       
        WMOutPutModel *model = _dataArray[0];
        NSString *date = [NSString stringWithFormat:@"%@-%@",model.outPutDate,model.outPutDay];
        _modelLabel.text = model.outPutModel;
        _moneyLabel.text = model.outPutMoney;
        _dateLabel.text = date;
        _usedLabel.text = model.outPutUsed;
        _commentLabel.text = model.outPutComment;
    }
    if ([dataStr isEqualToString:@"收入"]) {
        _dataArray = [self selectInPutTableWithPoint:dataPoint];
        _usedLabel.hidden = YES;
        _usedLabel1.hidden = YES;
        WMInPutModel *model = _dataArray[0];
        NSString *date = [NSString stringWithFormat:@"%@-%@",model.inPutDate,model.inPutDay];
        _modelLabel.text = model.inPutModel;
        _moneyLabel.text = model.inPutMoney;
        _dateLabel.text = date;
        _commentLabel.text = model.inPutComment;
        
    }

}
-(NSArray *)selectInPutTableWithPoint:(NSString *)point
{ //将数据从数据库请求出来，并且转换成模型类，存入一个可变数组中，然后赋值给属性数组，将可变数组当成tableview的数据源
    NSString *dbPath = [WMDataBase DatabasePathWithName:@"WMSqliteDB.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    NSString *selectSql = [NSString stringWithFormat:@"select * from inPutTable where inPutID = '%@'",point];
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
-(NSArray *)selectOutPutTableWithPoint:(NSString *)point
{ //将数据从数据库请求出来，并且转换成模型类，存入一个可变数组中，然后赋值给属性数组，将可变数组当成tableview的数据源
    NSString *dbPath = [WMDataBase DatabasePathWithName:@"WMSqliteDB.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    NSString *selectSql = [NSString stringWithFormat:@"select * from outPutTable where outPutID = '%@'",point];
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
