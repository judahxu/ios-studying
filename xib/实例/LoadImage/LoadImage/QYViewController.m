//
//  QYViewController.m
//  LoadImage
//
//  Created by qingyun on 15-3-16.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

#define kImgURLStr  @"http://d.hiphotos.baidu.com/zhidao/pic/item/562c11dfa9ec8a13e028c4c0f603918fa0ecc0e4.jpg"

@interface QYViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

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

- (IBAction)fetchAndLoadImage:(id)sender {

    // 请求data
    NSData *imgData;
    
    [NSThread sleepForTimeInterval:5];
    
    imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:kImgURLStr]];
    
    _imageView.image = [UIImage imageWithData:imgData];
    
}


@end
