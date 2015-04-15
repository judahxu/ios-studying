//
//  QYUserDefaults.m
//  DataPersistentDemo
//
//  Created by qingyun on 15-3-20.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYUserDefaults.h"

@interface QYUserDefaults ()
@property (weak, nonatomic) IBOutlet UISwitch *switchCtrl;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UITextField *progressTextField;

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@end

@implementation QYUserDefaults

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

    [self loadData];
}

- (IBAction)saveData:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:_switchCtrl.on forKey:@"switch"];
    
    [defaults setFloat:[_progressTextField.text floatValue] forKey:@"progress"];
    [defaults setObject:_inputTextField.text forKey:@"input"];
    
    [defaults synchronize];
}

- (void)loadData
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    _switchCtrl.on = [defaults boolForKey:@"switch"];
    _progressView.progress = [defaults floatForKey:@"progress"];
    _inputTextField.text = [defaults stringForKey:@"input"];
}

@end
