//
//  QYViewController1.m
//  NSURLSessionDemo
//
//  Created by qingyun on 15/3/17.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController1.h"
#define kSongURLStr @"http://music.baidu.com/data/music/file?link=http://yinyueshiting.baidu.com/data2/music/137081688/137078183169200128.mp3?xcode=304ffc058f732bedc2ba021f51f4ae7d0b86fc0e5b731aec&song_id=137078183"


@interface QYViewController1 ()

@end

@implementation QYViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)download:(id)sender {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:kSongURLStr];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:<#(NSURLRequest *)#> completionHandler:<#^(NSURL *location, NSURLResponse *response, NSError *error)completionHandler#>]
    
    
    
    
    
    
    
    
    
}







@end
