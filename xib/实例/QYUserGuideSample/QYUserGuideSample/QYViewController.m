//
//  QYViewController.m
//  QYUserGuideSample
//
//  Created by qingyun on 15-3-7.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

#define  kQYWidth self.view.bounds.size.width

@interface QYViewController () <UIScrollViewDelegate>

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc ]initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 4, self.view.bounds.size.height);
    scrollView.delegate = self;
    scrollView.minimumZoomScale = 0.5f;
    scrollView.maximumZoomScale = 3.0f;
    //    设置放大、缩小是否允许反弹效果
    scrollView.bouncesZoom = YES;
  
    
    
    for (int i = 1; i < 5; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*(i-1), 0, kQYWidth, self.view.bounds.size.height)];
        NSString *strImgName = [NSString stringWithFormat:@"new_feature_%d",i ];
        imgView.image = [UIImage imageNamed:strImgName];
        [scrollView addSubview:imgView];
        imgView.tag = 1001;
        //        imgView.
    }

    [self.view addSubview:scrollView];
    
    UIPageControl *pagControl = [[UIPageControl alloc] initWithFrame:CGRectMake(40, self.view.bounds.size.height - 50, 240, 40)];
    pagControl.numberOfPages = 4;
    pagControl.currentPageIndicatorTintColor = [UIColor redColor];
    pagControl.pageIndicatorTintColor = [UIColor blackColor];
    pagControl.tag = 1000;
    [self.view addSubview:pagControl];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UISCrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIPageControl *pgControl = (UIPageControl*)[self.view viewWithTag:1000];
    pgControl.currentPage = scrollView.contentOffset.x / 320;

}




////当UIScrollView结束放大，缩小之后会调用这个方法
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"%s",__func__);
}
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    NSLog(@"%s",__func__);
//}
//返回现在想要对scrollView视图上的哪个视图做放大，缩小动作
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView viewWithTag:1001];
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"%s,%f",__func__,scale);
}

@end
