//
//  QYViewController.m
//  SystemSoundDemo
//
//  Created by qingyun on 15-4-6.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface QYViewController ()
// 添加属性 (系统声⾳音ID对象的URL)
@property (nonatomic) CFURLRef soundFileURLRef;
// 添加属性 (系统声⾳音ID对象)
@property (nonatomic) SystemSoundID soundFileObject;

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *sndURL = [[NSBundle mainBundle] URLForResource:@"tap" withExtension:@"caf"];
    // ⽤用__bridge修饰,不转移对象的所有权。所以,后⾯面也就不再需要释放_soundFileURLRef的内存了
    _soundFileURLRef = (__bridge CFURLRef)sndURL;
    
    // 根据声⾳音⽂文件的URL,创建⼀一个系统声⾳音ID对象
    AudioServicesCreateSystemSoundID(_soundFileURLRef, &_soundFileObject);
    
    // 创建完系统声⾳音ID对象之后,注册移除对象的回调函数
    AudioServicesAddSystemSoundCompletion(_soundFileObject, nil, nil, SoundFinished, nil);
    // 这是该回调函数的实现,⾸首先移除该回调函数,然后移除系统ID对象
    // 注意,不需要再释放_soundFileURLRef了
}

void SoundFinished (SystemSoundID snd, void* context) {
    AudioServicesRemoveSystemSoundCompletion(snd);
    AudioServicesDisposeSystemSoundID(snd);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playSound:(id)sender {
    AudioServicesPlaySystemSound (_soundFileObject);
}
@end
