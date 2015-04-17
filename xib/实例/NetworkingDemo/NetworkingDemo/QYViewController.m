//
//  QYViewController.m
//  NetworkingDemo
//
//  Created by qingyun on 15-3-12.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

#define kSongURLStr @"http://player.kuwo.cn/MUSIC/MUSIC_6268050#"

@interface QYViewController () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSMutableData *songData;
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
- (IBAction)requestBaidu:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response;
    NSError *error;
    
    // 同步请求
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error) {
        NSLog(@"%@", error);
        return;
    }
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        NSLog(@"%@", response);
    }
    
    NSString *htmlStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", htmlStr);
}
- (IBAction)downloadMp3:(id)sender {
    
    NSURL *url = [NSURL URLWithString:kSongURLStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    // 开始请求
    [connection start];
}

#pragma mark URL data delegate
// 已经收到相应时调用
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        // 成功
        _songData = [NSMutableData data];
    }
}

// 已经收到数据时调用
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_songData appendData:data];
}

// 请求完成后调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_songData writeToFile:@"/Users/qingyun/Desktop/xxx.mp3" atomically:YES];
}
@end
