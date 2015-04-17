//
//  QYQueryStudents.m
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-25.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYQueryStudents.h"
#import "QYStudentModel.h"
#import "QYStudentCell.h"
#import "QYSQLiteDBManager.h"

@interface QYQueryStudents ()
@property (nonatomic, strong) NSArray *students;
@property (nonatomic, strong) QYSQLiteDBManager *manager;
@property (weak, nonatomic) IBOutlet UITextField *ID;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation QYQueryStudents

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

    _manager = [QYSQLiteDBManager sharedDBManager];
}

#pragma mark - table delegate

#pragma mark - table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _students.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYStudentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCellID" forIndexPath:indexPath];
    
    QYStudentModel *student = _students[indexPath.row];
    
    cell.ID.text = [@(student.ID) stringValue];
    cell.name.text = student.name;
    cell.age.text = [@(student.age) stringValue];
    cell.sex.text = student.sex;
    cell.icon.image = student.icon;
    
    return cell;
}

- (IBAction)selectAll:(id)sender {
    _students = [_manager selectAllStudents];
    [_tableView reloadData];
}

- (IBAction)selectByID:(id)sender {
    QYStudentModel *student = [_manager selectStudentByID:_ID.text.intValue];
    if (student) {
        _students = @[student];
        [_tableView reloadData];
    }
}

- (IBAction)textFieldDidEndOnExit:(id)sender {
    [sender resignFirstResponder];
}

@end
