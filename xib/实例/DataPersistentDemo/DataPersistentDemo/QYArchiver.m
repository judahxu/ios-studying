//
//  QYArchiver.m
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-20.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYArchiver.h"
#import "QYStudent.h"

@interface QYArchiver ()

@property (nonatomic, strong) NSString *path;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *ID;

@property (nonatomic, strong) QYStudent *student;

@end

@implementation QYArchiver

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)miscInit
{
    _path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"archiver.data"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self miscInit];
    
    [self loadData];
}

- (IBAction)saveData:(id)sender {
    _student = [[QYStudent alloc] init];
    _student.name = _name.text;
    _student.age = [_age.text intValue];
    _student.ID = _ID.text;
    
    [NSKeyedArchiver archiveRootObject:_student toFile:_path];
}

- (void)loadData
{
    _student = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
    if (_student == nil) {
        NSLog(@"Error!");
        return;
    }
    
    _name.text = _student.name;
    _age.text = [@(_student.age) stringValue];
    _ID.text = _student.ID;
}

@end
