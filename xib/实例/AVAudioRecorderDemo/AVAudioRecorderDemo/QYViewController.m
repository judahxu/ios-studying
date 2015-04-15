//
//  QYViewController.m
//  AVAudioRecorderDemo
//
//  Created by qingyun on 15-4-7.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QYViewController () <AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *recordOrPauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;

@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, strong) NSURL *audioFileURL;

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (AVAudioPlayer *)player
{
    if (_player) {
        return _player;
    }
    
    NSError *error;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.audioFileURL error:&error];
    _player.delegate = self;
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return _player;
}

- (AVAudioRecorder *)recorder
{
    if (_recorder) {
        return _recorder;
    }
    
    NSError *error;
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    
    // 录音设置
    // 格式
    settings[AVFormatIDKey] = @(kAudioFormatAppleIMA4);
    // 采样率
    settings[AVSampleRateKey] = @(44100);
    // 通道数
    settings[AVNumberOfChannelsKey] = @2;
    // 量化位数
    settings[AVLinearPCMBitDepthKey] = @16;
    // 编码质量
    settings[AVEncoderAudioQualityKey] = @(AVAudioQualityHigh);
    
    _recorder = [[AVAudioRecorder alloc] initWithURL:self.audioFileURL settings:settings error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return _recorder;
}

- (NSURL *)audioFileURL
{
    if (_audioFileURL) {
        return _audioFileURL;
    }
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSLog(@"%@", docPath);
    
    NSString *filePath = [docPath stringByAppendingPathComponent:@"test.caf"];
    
    _audioFileURL = [NSURL URLWithString:filePath];
    
    return _audioFileURL;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updatePlayOrPauseBtn:(BOOL)isPlaying
{
    if (isPlaying) {
        [_playOrPauseBtn setTitle:@"暂停播放" forState:UIControlStateNormal];
        [_playOrPauseBtn setTitle:@"暂停播放" forState:UIControlStateHighlighted];
    } else {
        [_playOrPauseBtn setTitle:@"继续播放" forState:UIControlStateNormal];
        [_playOrPauseBtn setTitle:@"继续播放" forState:UIControlStateHighlighted];
    }
}

- (void)updateRecordOrPauseBtn:(BOOL)isRecording
{
    if (isRecording) {
        [_recordOrPauseBtn setTitle:@"暂停录音" forState:UIControlStateNormal];
        [_recordOrPauseBtn setTitle:@"暂停录音" forState:UIControlStateHighlighted];
    } else {
        [_recordOrPauseBtn setTitle:@"继续录音" forState:UIControlStateNormal];
        [_recordOrPauseBtn setTitle:@"继续录音" forState:UIControlStateHighlighted];
    }
}

- (IBAction)recordOrPause:(id)sender {
    if (self.recorder.isRecording) {
        [_recorder pause];
        [self updateRecordOrPauseBtn:NO];
    } else {
        [_recorder record];
        [self updateRecordOrPauseBtn:YES];
    }
}
- (IBAction)stopRecording:(id)sender {
    [_recorder stop];
    _recorder = nil;
    
    [_recordOrPauseBtn setTitle:@"开始录音" forState:UIControlStateNormal];
    [_recordOrPauseBtn setTitle:@"开始录音" forState:UIControlStateHighlighted];
    
}

- (IBAction)playOrPause:(id)sender {
    if (self.player.isPlaying) {
        [_player pause];
        [self updatePlayOrPauseBtn:NO];
    } else {
        [_player play];
        [self updatePlayOrPauseBtn:YES];
    }
}
- (IBAction)stopPlaying:(id)sender {
    [_player stop];
    _player = nil;

    [_playOrPauseBtn setTitle:@"开始播放" forState:UIControlStateNormal];
    [_playOrPauseBtn setTitle:@"开始播放" forState:UIControlStateHighlighted];

}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        [self stopPlaying:nil];
    }
}
@end
