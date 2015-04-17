//
//  QYViewController.m
//  NSOperationDemo
//
//  Created by qingyun on 15-3-16.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

#define kImgURLStr  @"http://d.hiphotos.baidu.com/zhidao/pic/item/562c11dfa9ec8a13e028c4c0f603918fa0ecc0e4.jpg"

@interface QYViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSBlockOperation *blockOp;

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    _queue = queue;
    
    // 1. invocation
    NSInvocationOperation *invocationOp = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(updateLabel:) object:@"NSInvocationOperation"];
    
    [queue addOperation:invocationOp];
    
    // 2. block
    _blockOp = [NSBlockOperation blockOperationWithBlock:^{
        [self fetchImage:kImgURLStr];
    }];
}

- (void)updateImageView:(UIImage *)image
{
    _imageView.image = image;
}

- (void)fetchImage:(NSString *)urlStr
{
    [NSThread sleepForTimeInterval:5];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    
    UIImage *image = [UIImage imageWithData:data];
    
    // 在主线程更新UI
    [self performSelectorOnMainThread:@selector(updateImageView:) withObject:image waitUntilDone:YES];
}

- (void)updateLabelText:(NSString *)string
{
    _label.text = string;
}

- (void)updateLabel:(NSString *)string
{
    [NSThread sleepForTimeInterval:3];
    
    [self performSelectorOnMainThread:@selector(updateLabelText:) withObject:string waitUntilDone:YES];
}

- (IBAction)fetchAndLoadImage:(id)sender {
    [_queue addOperation:_blockOp];
}

@end
