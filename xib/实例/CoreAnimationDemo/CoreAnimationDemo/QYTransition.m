//
//  QYTransition.m
//  CoreAnimationDemo
//
//  Created by qingyun on 15-4-6.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYTransition.h"

@interface QYTransition ()
@property (nonatomic, strong) CALayer *containerLayer;
@property (nonatomic, strong) CALayer *redLayer;
@property (nonatomic, strong) CALayer *blueLayer;
@property (weak, nonatomic) IBOutlet UISegmentedControl *type;
@property (weak, nonatomic) IBOutlet UISegmentedControl *subType;
@end

@implementation QYTransition

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
    
    CGRect rect = CGRectMake(0, 0, 240, 240);
    
    _containerLayer = [CALayer layer];
    _containerLayer.position = self.view.center;
    _containerLayer.bounds = rect;
    
    [self.view.layer addSublayer:_containerLayer];
    
    _redLayer = [CALayer layer];
    _redLayer.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.6].CGColor;
    _redLayer.position = CGPointMake(120, 120);
    _redLayer.bounds = rect;
    _redLayer.hidden = YES;
    
    [_containerLayer addSublayer:_redLayer];
    
    _blueLayer = [CALayer layer];
    _blueLayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.6].CGColor;
    _blueLayer.position = CGPointMake(120, 120);
    _blueLayer.bounds = rect;
    _blueLayer.hidden = NO;
    
    [_containerLayer addSublayer:_blueLayer];
}

- (IBAction)transition:(id)sender {
    CATransition *transition = [CATransition animation];
    
    NSArray *types = @[kCATransitionFade, kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal];
    NSArray *subTypes = @[kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom];
    
    transition.type = types[_type.selectedSegmentIndex];
    transition.subtype = subTypes[_subType.selectedSegmentIndex];
    
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [_containerLayer addAnimation:transition forKey:@"transition"];
    
    _redLayer.hidden = !_redLayer.hidden;
    _blueLayer.hidden = !_blueLayer.hidden;
    
}


@end
