//
//  QYViewController.m
//  POSTDemo
//
//  Created by qingyun on 15-3-13.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

@interface QYViewController ()

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


- (IBAction)login:(id)sender {
    NSString *loginURLStr = @"http://jw.zzu.edu.cn/scripts/freeroom/freeroom.dll/mylogin";
    
    NSURL *url = [NSURL URLWithString:loginURLStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [request setHTTPMethod:@"POST"];

    
    NSString *params = @"zhanghao=20132450412&mima=8998264978&B1=登录";
    
    NSData *bodyData = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:bodyData];
    
    NSURLResponse *response;
    NSError *error;
    
    NSData *rcvData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  
    if (error) {
        NSLog(@"%@", error);
        return;
    }
    
    NSLog(@"%@", response);
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString *result = [[NSString alloc] initWithData:rcvData encoding:enc];
    
    NSLog(@"%@", result);
    
}


- (IBAction)query:(id)sender {
    NSString *loginURLStr = @"http://jw.zzu.edu.cn/Scripts/freeroom/freeroom.dll/submit?userid=2D2034F2E835D28F652924D75EC563536428EDE4D936ED";
    
    NSURL *url = [NSURL URLWithString:loginURLStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *params = @"xqsort=5&jcsort=3&chaxun=查询空闲教室";
    
    NSData *bodyData = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:bodyData];
    
    NSURLResponse *response;
    NSError *error;
    
    NSData *rcvData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error) {
        NSLog(@"%@", error);
        return;
    }
    
    NSLog(@"%@", response);
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString *result = [[NSString alloc] initWithData:rcvData encoding:enc];
    
    NSLog(@"%@", result);

}

@end
