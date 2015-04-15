//
//  QYViewController.m
//  DrawImageDemo
//
//  Created by qingyun on 15-3-31.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

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
- (IBAction)drawImage:(id)sender {
    CGSize size = CGSizeMake(100, 100);
    // 创建了一个位图上下文
    UIGraphicsBeginImageContextWithOptions(size, YES, 1.0);
    
    // 获取该位图上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 绘制
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    const CGPoint points[] = {50, 0, 0, 100, 100, 100};
    CGContextAddLines(ctx, points, 3);
    
    CGContextFillPath(ctx);
    
    // 从当前位图上下文中，取出当前画布上的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭位图上下文
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150, 100, 100)];
    imageView.image = image;
    
    [self.view addSubview:imageView];
    
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:@"/Users/qingyun/Desktop/testOpaque.png" atomically:YES];
    
}

@end
