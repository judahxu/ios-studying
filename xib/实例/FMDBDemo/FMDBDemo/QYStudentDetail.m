//
//  QYStudentDetail.m
//  FMDBDemo
//
//  Created by qingyun on 15-3-25.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYStudentDetail.h"
#import "QYStudentModel.h"
#import "common.h"
#import "FMDB.h"

@interface QYStudentDetail ()
@property (nonatomic, strong) QYStudentModel *student;
@property (nonatomic, getter = isContentChanged) BOOL contentChanged;
@property (nonatomic, strong) FMDatabase *database;
@end

@implementation QYStudentDetail

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _ID.text = _student.stu_id;
    _name.text = _student.name;
    _age.text = [@(_student.age) stringValue];
}

- (BOOL)isContentChanged
{
    if ([_name.text isEqualToString:_student.name]
        && [_age.text isEqualToString:[@(_student.age) stringValue]]) {
        return NO;
    }
    return YES;
}

- (IBAction)textFieldDidEndOnExit:(id)sender {
    
    [sender resignFirstResponder];
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


- (void)updateStudentInfo
{
    // 1. 打开数据库
    if (![self.database open]) {
        NSLog(@"Open database failed!");
        return;
    }
    
    // 2. 执行更新操作
    [self.database executeUpdate:@"update Students set name = ?, age = ? where stu_id = ?", _name.text, _age.text, _ID.text];
    
    // 3. 关闭数据库
    [self.database close];
    
    // 4. 更新传入的基准数据
    _student.name = _name.text;
    _student.age = [_age.text intValue];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kStuInfoModified object:nil userInfo:nil];
}

- (IBAction)saveData:(id)sender {
    
    if (![self isContentChanged]) {
        NSLog(@"Not changed!");
        return;
    }
    
    [self updateStudentInfo];
}



@end
