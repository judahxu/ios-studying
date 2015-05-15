//
//  WMVideoPlayerVC.m
//  WealthManager
//
//  Created by Maser on 15/5/13.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMVideoPlayerVC.h"
#import "WMVideoModel.h"
#import "WMfileManager.h"

@interface WMVideoPlayerVC ()
@property (weak, nonatomic) IBOutlet UIWebView *videoPalyerWeb;
@property (nonatomic,strong)WMVideoModel *videoModel;
@property (nonatomic,strong)NSMutableArray *playArray;

@end

@implementation WMVideoPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *filePath = [WMfileManager dataDocPath:@"collect.plist"];
    [NSThread detachNewThreadSelector:@selector(playVideoWithURL:) toTarget:self withObject:_videoModel.videoPlayUrl];
    _playArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    
}
-(void)playVideoWithURL:(NSString *)url
{
    NSURL *vedioURL = [[NSURL alloc]initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:vedioURL];
    [self performSelectorOnMainThread:@selector(toPlay:) withObject:request waitUntilDone:YES];
   
}
-(void)toPlay:(NSURLRequest *)request
{
    [_videoPalyerWeb loadRequest:request];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveAction:(id)sender
{
    NSString *filePath = [WMfileManager dataDocPath:@"collect.plist"];
  
    NSMutableDictionary *collectDic = [NSMutableDictionary dictionary];
    [collectDic setValue:_videoModel.videoName forKey:@"videoName"];
    [collectDic setValue:_videoModel.videoPic forKey:@"videoPic"];
    [collectDic setValue:_videoModel.videoPlayUrl forKey:@"videoPlayUrl"];
     NSData *collectData = [NSKeyedArchiver archivedDataWithRootObject:collectDic];
    if ([_playArray containsObject:collectData]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该视频以收藏" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    //归档
    [_playArray addObject:collectData];
    
    [_playArray writeToFile:filePath atomically:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
