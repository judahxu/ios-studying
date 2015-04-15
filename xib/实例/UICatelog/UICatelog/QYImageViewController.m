//
//  QYImageViewController.m
//  UICatalogDemo
//
//  Created by qingyun on 14-6-27.
//  Copyright (c) 2014年 hnqingyun. All rights reserved.
//

#import "QYImageViewController.h"

@interface QYImageViewController ()
@property (nonatomic, retain) UIImageView *imageView;
@end

@implementation QYImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Images";
    self.view.backgroundColor = [UIColor blackColor];
    
    // 创建imageView
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 110, 260, 200)];
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"scene%d.jpg", i+1]]];
    }
    _imageView.animationImages = images;
    [_imageView setAnimationDuration:3];
    [self.view addSubview:_imageView];
    
    // 创建slider
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 420, 300, 30)];
    slider.minimumValue = 1;
    slider.maximumValue = 10;
    slider.value = 3;
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
   
    
    // 创建label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120, 455, 80, 20)];
    label.text = @"Duration";
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
   
    
    [_imageView startAnimating];
}

- (void)sliderAction:(UISlider *)slider
{
    [_imageView setAnimationDuration:slider.value];
    [_imageView startAnimating];
}


@end
