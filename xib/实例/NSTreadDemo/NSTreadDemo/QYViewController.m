//
//  QYViewController.m
//  NSTreadDemo
//
//  Created by qingyun on 15-3-16.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

#define kImgURLStr  @"http://d.hiphotos.baidu.com/zhidao/pic/item/562c11dfa9ec8a13e028c4c0f603918fa0ecc0e4.jpg"

@interface QYViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSThread *thread;
@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 1. 类方法
    [NSThread detachNewThreadSelector:@selector(changeLabel:) toTarget:self withObject:@"detachNewThreadSelector"];
    
    // 2. 实例方法
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(fetchImageData:) object:kImgURLStr];
    
}

- (void)updateLabelString:(NSString *)string
{
    _label.text = string;
    NSLog(@"%s", __func__);
}

- (void)changeLabel:(NSString *)string
{
    if ([[NSThread currentThread] isMainThread]) {
        NSLog(@"主线程!");
    } else {
        NSLog(@"对等线程!");
    }
    
    [NSThread sleepForTimeInterval:3];
    
    [self performSelectorOnMainThread:@selector(updateLabelString:) withObject:string waitUntilDone:YES];
    NSLog(@"%s", __func__);
}

- (void)updateImageView:(UIImage *)image
{
    _imageView.image = image;
}

- (void)fetchImageData:(NSString *)urlStr
{
    [NSThread sleepForTimeInterval:5];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    
    UIImage *image = [UIImage imageWithData:data];
    
    [self performSelectorOnMainThread:@selector(updateImageView:) withObject:image waitUntilDone:YES];
}

- (IBAction)fetchAndLoadImage:(id)sender {
    [_thread start];
}
@end
