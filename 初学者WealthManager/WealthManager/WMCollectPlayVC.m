//
//  WMCollectPlayVC.m
//  WealthManager
//
//  Created by Maser on 15/5/14.
//  Copyright (c) 2015年 Maser. All rights reserved.
//

#import "WMCollectPlayVC.h"

@interface WMCollectPlayVC ()
@property (weak, nonatomic) IBOutlet UIWebView *playView;
@property (nonatomic,strong)NSDictionary *collectDic;
@end

@implementation WMCollectPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSThread detachNewThreadSelector:@selector(getWebRequest) toTarget:self withObject:nil];
}
- (void)getWebRequest
{
    NSURL *url = [NSURL URLWithString:_collectDic[@"videoPlayUrl"]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self performSelectorOnMainThread:@selector(playWith:) withObject:request waitUntilDone:YES];
}

-(void)playWith:(NSURLRequest *)request
{
    [_playView loadRequest:request];
    
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

@end
