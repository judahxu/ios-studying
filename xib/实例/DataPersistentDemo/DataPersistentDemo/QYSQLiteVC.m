//
//  QYSQLiteVC.m
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-24.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYSQLiteVC.h"
#import "QYSQLiteDBManager.h"

@interface QYSQLiteVC ()
@property (nonatomic, strong) QYSQLiteDBManager *manager;
@end

@implementation QYSQLiteVC

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
    
    NSLog(@"%@", NSHomeDirectory());
}

- (QYSQLiteDBManager *)manager
{
    if (_manager == nil) {
        _manager = [QYSQLiteDBManager sharedDBManager];
    }
    
    return _manager;
}

- (IBAction)createDB:(id)sender {
    [self.manager openDB];
}

- (IBAction)createStudentTbl:(id)sender {
    [self.manager createTable];
}

@end
