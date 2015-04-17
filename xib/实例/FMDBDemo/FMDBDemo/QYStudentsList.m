//
//  QYStudentsList.m
//  FMDBDemo
//
//  Created by qingyun on 15-3-25.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYStudentsList.h"
#import "FMDB.h"
#import "common.h"
#import "AFHTTPRequestOperationManager.h"
#import "QYStudentModel.h"

@interface QYStudentsList ()
@property (nonatomic, strong) FMDatabase *database;
@property (nonatomic, strong) NSMutableArray *students;
@end

@implementation QYStudentsList

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 创建学生表
    [self createStuTable];
    
    // 加载学生信息，并更新界面
    [self loadStudentsInfo];
    
    // 注册详情页面修改后的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadStudentsInfoLocal) name:kStuInfoModified object:nil];
}

- (NSString *)docPath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

- (FMDatabase *)database
{
    if (_database == nil) {
        _database= [FMDatabase databaseWithPath:[[self docPath] stringByAppendingPathComponent:kDatabaseName]];
    }
    
    return _database;
}

- (void)createStuTable
{
    // 1. 打开数据库
    if (![self.database open]) {
        NSLog(@"Open database failed!");
        return;
    }
    
    // 2. 编写SQL语句
    NSString *sql = @"create table if not exists Students(stu_id integer primary key, name text, age integer)";
    
    // 3. 执行SQL操作
    if ([self.database executeUpdate:sql]) {
        NSLog(@"Create table sucess!");
    }
    
    // 4. 关闭数据库
    [self.database close];
}

- (void)update2Database
{
    // 1. 打开数据库
    if (![self.database open]) {
        NSLog(@"Open database failed!");
        return;
    }
    
    // 2. 执行插入操作
    BOOL result = NO;
    for (NSDictionary *student in _students) {
        NSString *sql = [NSString stringWithFormat:@"insert into Students(stu_id, name, age) values(:%@, :%@, :%@)", kStuID, kName, kAge];
        result = [self.database executeUpdate:sql withParameterDictionary:student];
        if (result == NO) {
            NSLog(@"%@", [self.database lastErrorMessage]);
            [self.database close];
            return;
        }
    }
    
    // 3. 关闭数据
    [self.database close];
    
    // 4. 设置标记为位非第一次
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kDataExists];
}

- (void)loadStudentsInfoLocal
{
    // 1. 打开数据库
    if (![self.database open]) {
        NSLog(@"Open database failed!");
        return;
    }
    
    // 2. 执行查询操作
    NSString *sql = @"select * from Students";
    FMResultSet *rs = [self.database executeQuery:sql];
    
    // 位数据源申请内存
    _students = [NSMutableArray array];
    
    while ([rs next]) {
        NSString *name = [rs stringForColumn:kName];
        NSString *stuID = [rs stringForColumn:kStuID];
        int age = [rs intForColumn:kAge];
        
        QYStudentModel *student = [QYStudentModel studentWithName:name ID:stuID andAge:age];
        [_students addObject:student];
    }
    
    // 3. 关闭数据库
    [self.database close];
    
    // 4. 更新数据源
    [self.tableView reloadData];
}

/**
 *  获取学生记录信息，并更新数据源
 *  1. 如果，本地数据库有内容，就从本地数据库更新
 *  2. 否则，从远端服务器请求
 */
- (void)loadStudentsInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults boolForKey:kDataExists]) { // 不是第一次
        [self loadStudentsInfoLocal];
        return;
    }
    
    // 第一次，从网络请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    NSDictionary *parameters = @{@"person_type":@"student"};
    
    NSString *urlStr = [kBaseURL stringByAppendingPathComponent:@"persons.json"];
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        _students = [responseObject valueForKey:@"data"];
        NSLog(@"%@", _students);
        
        [self.tableView reloadData];
        
        // 持久化到数据库中
        [self update2Database];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *cell = (UITableViewCell *)sender;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    id model = _students[indexPath.row];
    
    NSString *name = [model valueForKey:kName];
    NSString *ID = [model valueForKey:kStuID];
    int age = [[model valueForKey:kAge] intValue];
    
    QYStudentModel *student = [QYStudentModel studentWithName:name ID:ID andAge:age];
    
    UIViewController *dstVC = segue.destinationViewController;
    
    [dstVC setValue:student forKey:@"student"];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _students.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStuListCellID forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [_students[indexPath.row] valueForKey:kName];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        // 删除内存中(数据源)的数据
        id student = _students[indexPath.row];
        NSString *stuID = [student valueForKey:kStuID];
        [_students removeObjectAtIndex:indexPath.row];
        
        // 更新界面  ?
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // 更新数据库（删除数据库中的指定记录）
        [self removeStudentFromDBByID:stuID];
    }
}

- (void)removeStudentFromDBByID:(NSString *)ID
{
    // 1. 打开数据库
    if (![self.database open]) {
        NSLog(@"Open database failed!");
        return;
    }
    
    // 2. 执行删除操作
//    NSString *sql = @"delete from Students where ";
    NSString *sql = [NSString stringWithFormat:@"delete from Students where %@ = %@", kStuID, ID];
    [self.database executeUpdate:sql];
    
    // 3. 关闭数据库
    [self.database close];
}



@end
