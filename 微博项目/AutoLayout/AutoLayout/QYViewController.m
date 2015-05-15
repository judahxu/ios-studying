//
//  QYViewController.m
//  AutoLayout
//
//  Created by qingyun on 15-4-14.
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
    [self demo8];
}

//demo1

-(void)demo1{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    
    //使用 Auto Layout 布局
    view.translatesAutoresizingMaskIntoConstraints = NO;
    CGRect viewFrame = CGRectMake(50, 150, 100, 100);
    
    [self.view addSubview:view];
    
    //view的左边距离self.view的左边距离50
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:CGRectGetMinX(viewFrame)];
    
    //view的top 距离self.view的top 距离 150
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:CGRectGetMinY(viewFrame)];
    
    //view 的宽度 大于等于 100
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:CGRectGetWidth(viewFrame)];
    
    //view 的高度 大于等于 100
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:CGRectGetHeight(viewFrame)];
    
//    将约束添加到父视图上
    [self.view addConstraints:@[leftConstraint, topConstraint, width, height]];
}

//FVL

-(void)demo2{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    //使用 Auto Layout 布局
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    //视图绑定字典
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    
    //创建水平方向上的约束
    NSArray *hConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[view(>=150)]" options:0 metrics:nil views:views];
    [self.view addConstraints:hConstraint];
    
    NSArray *VConstrain = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view(>=150)]" options:0 metrics:nil views:views];
    [self.view addConstraints:VConstrain];
    
}

//在右侧添加一个视图

-(void)demo3{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view2];
    
    //使用 Auto Layout 布局
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    
    //视图绑定字典
    NSDictionary *views = NSDictionaryOfVariableBindings(view, view2);
    
    //创建水平方向上的约束
    NSArray *hConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[view(>=150)]" options:0 metrics:nil views:views];
    [self.view addConstraints:hConstraint];
    
    NSArray *VConstrain = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view(>=150)]" options:0 metrics:nil views:views];
    [self.view addConstraints:VConstrain];
    
    NSString *formatString = @"H:[view]-[view2(>=50)]";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:views]];
    
    formatString = @"V:|-100-[view2(>=50)]";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:views]];
    
}

//简化VFL语言

-(void)demo4{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view2];
    
    //使用 Auto Layout 布局
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    
    //视图绑定字典
    NSDictionary *views = NSDictionaryOfVariableBindings(view, view2);
    
    
    NSArray *VConstrain = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view(>=150)]" options:0 metrics:nil views:views];
    [self.view addConstraints:VConstrain];
    
    NSString *formatString = @"H:|-50-[view(>=150)]-[view2(>=50)]";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:views]];
    
    formatString = @"V:|-100-[view2(>=50)]";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:views]];
    
}

//添加一个视图

-(void)demo5{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view2];
    
    UIView *view3 = [UIView new];
    view3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view3];
    
    //使用 Auto Layout 布局
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    view3.translatesAutoresizingMaskIntoConstraints = NO;
    
    //视图绑定字典
    NSDictionary *views = NSDictionaryOfVariableBindings(view, view2, view3);
    
    NSString *formatString = @"H:|-50-[view(>=150)]-[view2(>=50)]";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:views]];
    
    formatString = @"H:[view]-[view3(>=50)]";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:views]];
    
    
    
    formatString = @"V:|-100-[view(>=150)]";
    NSArray *VConstrain = [NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:views];
    [self.view addConstraints:VConstrain];
    
    formatString = @"V:|-100-[view2(>=50)][view3(>=100)]";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:views]];
    
}

//options

-(void)demo6{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view2];
    
    //使用 Auto Layout 布局
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    
    //视图绑定字典
    NSDictionary *views = NSDictionaryOfVariableBindings(view, view2);
    
    
    NSArray *VConstrain = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view(>=150)]" options:0 metrics:nil views:views];
    [self.view addConstraints:VConstrain];
    
    
    //options 顶部对齐
    NSString *formatString = @"H:|-50-[view(>=150)]-[view2(>=50)]";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatString options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    
    formatString = @"V:[view2(>=50)]";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:views]];
    
}

//metrics

-(void)demo7{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    //使用 Auto Layout 布局
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    //视图绑定字典
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    
    NSNumber *left = @50;
    NSNumber *top = @100;
    NSNumber *width = @150;
    NSNumber *height = @150;
    
    NSDictionary *metrics = NSDictionaryOfVariableBindings(left, top, width, height);
    
    //创建水平方向上的约束
    NSArray *hConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[view(>=width)]" options:0 metrics:metrics views:views];
    [self.view addConstraints:hConstraint];
    
    NSArray *VConstrain = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[view(>=height)]" options:0 metrics:metrics views:views];
    [self.view addConstraints:VConstrain];
    
}

//修改约束的优先级
-(void)demo8{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    
    //使用 Auto Layout 布局
    view.translatesAutoresizingMaskIntoConstraints = NO;
    CGRect viewFrame = CGRectMake(50, 150, 100, 100);
    
    [self.view addSubview:view];
    
    //view的左边距离self.view的左边距离50
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:CGRectGetMinX(viewFrame)];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    
    leftConstraint.priority = UILayoutPriorityDefaultHigh;
    
    //view的top 距离self.view的top 距离 150
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:CGRectGetMinY(viewFrame)];
    
    //view 的宽度 大于等于 100
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:CGRectGetWidth(viewFrame)];
    
    //view 的高度 大于等于 100
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:CGRectGetHeight(viewFrame)];
    
    //    将约束添加到父视图上
    [self.view addConstraints:@[leftConstraint, left,  topConstraint, width, height]];
}


@end
