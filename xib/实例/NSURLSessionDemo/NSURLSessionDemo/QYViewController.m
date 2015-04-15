//
//  QYViewController.m
//  NSURLSessionDemo
//
//  Created by qingyun on 15-3-13.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

#define kSongURLStr @"http://music.baidu.com/data/music/file?link=http://yinyueshiting.baidu.com/data2/music/137081688/137078183169200128.mp3?xcode=304ffc058f732bedc2ba021f51f4ae7d0b86fc0e5b731aec&song_id=137078183"

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
- (IBAction)download:(id)sender {
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:kSongURLStr];
    
    // 创建下载任务
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSLog(@"%@", location);
        
        if (error) {
            NSLog(@"%@", error);
            return ;
        }
        
        // 服务器建议名字
        NSString *name = @"一首歌.mp3";
        
        // 将文件从location拷贝到桌面，命名为name
        NSString *desktop = @"/Users/qingyun/Desktop/";
        desktop = [desktop stringByAppendingPathComponent:name];
        NSURL *dstURL = [NSURL fileURLWithPath:desktop];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        NSError *fileError;
        [manager copyItemAtURL:location toURL:dstURL error:&fileError];
        if (fileError) {
            NSLog(@"%@", fileError);
        }
        
    }];
    
    // 开始下载任务
    [downloadTask resume];
}

- (IBAction)search:(id)sender {
    
    NSString *urlStr = @"http://www.baidu.com/s?wd=河南青云";
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            return ;
        }
        
        NSString *resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", resultStr);
        
        [resultStr writeToFile:@"/Users/qingyun/Desktop/baidu-qingyun.html" atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            NSLog(@"%@", error);
            return;
        }
    }];
    
    [task resume];
}


@end
