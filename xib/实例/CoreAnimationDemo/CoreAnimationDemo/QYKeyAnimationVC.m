//
//  QYKeyAnimationVC.m
//  CoreAnimationDemo
//
//  Created by qingyun on 15-4-6.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYKeyAnimationVC.h"

@interface QYKeyAnimationVC ()

@property (nonatomic, strong) CALayer *platformLayer;
@property (nonatomic, strong) CALayer *marioLayer;

@end

@implementation QYKeyAnimationVC

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
    
    _platformLayer = [CALayer layer];
    _platformLayer.backgroundColor = [UIColor brownColor].CGColor;
    _platformLayer.anchorPoint = CGPointZero;
    _platformLayer.frame = CGRectMake(160, 200, 160, 44);
    _platformLayer.cornerRadius = 4;
    
    _marioLayer = [CALayer layer];
    _marioLayer.contents = (__bridge id)([UIImage imageNamed:@"mario"].CGImage);
    _marioLayer.bounds = CGRectMake(0, 0, 32, 64);
    _marioLayer.contentsRect = CGRectMake(0.5, 0, 0.5, 1);
    _marioLayer.anchorPoint = CGPointMake(0, 1);
    _marioLayer.position = CGPointMake(0, self.view.bounds.size.height);
    
    [self.view.layer addSublayer:_platformLayer];
    [self.view.layer addSublayer:_marioLayer];
}


- (IBAction)jump:(id)sender {
    
    [CATransaction begin];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _marioLayer.contentsRect = CGRectMake(0, 0, 0.5, 1);
    [CATransaction commit];
    
    [CATransaction setCompletionBlock:^{
        [CATransaction setDisableActions:YES];
        _marioLayer.position = CGPointMake(170, 200);
        _marioLayer.contentsRect = CGRectMake(0.5, 0, 0.5, 1);
    }];
    
    // 创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, self.view.bounds.size.height);
    
    CGPathAddCurveToPoint(path, NULL, 30, 140, 170, 140, 170, 200);
    
    // 创建关键帧动画
    CAKeyframeAnimation *jumpAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    jumpAnim.duration = 1;
    jumpAnim.path = path;
    jumpAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // 将动画添加到layer上
    [_marioLayer addAnimation:jumpAnim forKey:@"marioJump"];
    
    [CATransaction commit];
    
//    [self performSelector:@selector(adjustMarioPosition) withObject:nil afterDelay:1];
    
}

//- (void)adjustMarioPosition
//{
//    _marioLayer.position = CGPointMake(170, 200);
//}



@end
