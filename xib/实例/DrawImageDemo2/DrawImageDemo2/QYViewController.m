//
//  QYViewController.m
//  DrawImageDemo2
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

- (void)adjustTransform4Ctx:(CGContextRef)ctx
{
    // 1. rotate PI
    // 2. scale(-1, 1)
    // 3. translate(0,-h)
    
//    CGContextRotateCTM(ctx, M_PI);
//    CGContextScaleCTM(ctx, -1, 1);
//    CGContextTranslateCTM(ctx, 0, -100);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -100);
}

- (IBAction)drawImage:(id)sender {
    
    CGSize size = CGSizeMake(100, 100);
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self adjustTransform4Ctx:ctx];
    
    UIImage *image  = [UIImage imageNamed:@"test"];
    
    // 重新绘制
    CGContextDrawImage(ctx, CGRectMake(0, 0, 100, 100), image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 250, 100, 100)];
    
    imgView1.image = image;
    imgView2.image = newImage;
    
    [self.view addSubview:imgView1];
    [self.view addSubview:imgView2];
}
@end
