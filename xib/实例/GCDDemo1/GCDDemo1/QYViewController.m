//
//  QYViewController.m
//  GCDDemo1
//
//  Created by qingyun on 15-3-16.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

@interface QYViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *fetchButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)fetchDataFromServer:(id)sender {
    
    NSDate *startDate = [NSDate date];

    NSString __block *dataStr;
    NSString __block *firstStr;
    NSString __block *secStr;
    NSString __block *thirdStr;
    NSString __block *totalStr;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _fetchButton.enabled = NO;
            _fetchButton.alpha = 0.6;
            [_indicator startAnimating];
        });
        
        // 0. 模拟从服务器请求数据
        dataStr = [self fetchData];
        
        dispatch_group_t group = dispatch_group_create();
        
        // 1. 模拟第一次处理服务器请求回来的数据 ->小写
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            firstStr = [self firstProcessData:dataStr];
        });

        
        // 2. 模拟第二次。。。 e->x
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            secStr = [self secProcessData:dataStr];
        });
        
        // 3. 模拟第三次。。。 count
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            thirdStr = [self thirdProcessData:dataStr];
        });
        
        // 4. 汇总前三次的数据处理结果
        dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            totalStr = [NSString stringWithFormat:@"First:<%@>\nSecond:<%@>\nThird:<%@>\n", firstStr, secStr, thirdStr];

            // 5. 更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                _textView.text = totalStr;
                [_indicator stopAnimating];
                _fetchButton.alpha = 1;
                _fetchButton.enabled = YES;
            });
            
            NSDate *endDate = [NSDate date];
            
            NSLog(@"总共用了<%.2f>S", [endDate timeIntervalSinceDate:startDate]);
        });

        

        
    });
}

- (NSString *)fetchData
{
    [NSThread sleepForTimeInterval:3];
    return @"fetchDataFromServer";
}

- (NSString *)firstProcessData:(NSString *)dataStr
{
    [NSThread sleepForTimeInterval:3];
    
    return [dataStr lowercaseString];
    
}

- (NSString *)secProcessData:(NSString *)string
{
    [NSThread sleepForTimeInterval:3];
    
    // e -> x
    
    return [string stringByReplacingOccurrencesOfString:@"e" withString:@"x"];
}

- (NSString *)thirdProcessData:(NSString *)string
{
    [NSThread sleepForTimeInterval:3];
    
    // 统计
    return [NSString stringWithFormat:@"The number of string is %lu", string.length];
}

@end
