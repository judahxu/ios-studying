//
//  QYPlistVC.m
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-20.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYPlistVC.h"

@interface QYPlistVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSString *path;

@end

@implementation QYPlistVC

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
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    _path = [docPath stringByAppendingPathComponent:@"plist.plist"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self miscInit];
    
    [self loadData];
}

- (IBAction)saveData:(id)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"textField"] = _textField.text;
    
    dict[@"string"] = @"hello";
    dict[@"number"] = @123;
    dict[@"date"] = [NSDate date];
    dict[@"data"] = [[NSData alloc] initWithBytes:[@"world" UTF8String] length:5];
    
    BOOL result = [dict writeToFile:_path atomically:YES];
    
    if (result) {
        NSLog(@"Save OK!");
    }
}

- (void)loadData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:_path];
    
    NSLog(@"%@", dict);
    
    _textField.text = dict[@"textField"];
}


@end
