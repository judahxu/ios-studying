//
//  QYViewController.m
//  AVPlayerDemo
//
//  Created by qingyun on 15-4-7.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import <AVFoundation/AVFoundation.h>

#define kSongURLStr @"https://api.soundcloud.com/tracks/187029784/download?client_id=b45b1aa10f1ac2941910a7f0d10f8e28"

@interface QYViewController ()
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:[kSongURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"%@", url);
    
    _player = [[AVPlayer alloc] initWithURL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    
}
- (IBAction)play:(id)sender {
    
    NSLog(@"%@", self.player.currentItem);
    
    NSLog(@"currentTime:%f", CMTimeGetSeconds(self.player.currentTime));
    NSLog(@"duration:%f", CMTimeGetSeconds(self.player.currentItem.asset.duration));
    
    [self.player play];
    
}

@end
