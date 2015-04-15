//
//  QYView.m
//  ArchiverDemo
//
//  Created by qingyun on 15-3-23.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYView.h"

@implementation QYView

+ (void)initialize
{
    NSLog(@"%s", __func__);
}

+ (void)load
{
    NSLog(@"%s", __func__);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        NSLog(@"%s", __func__);
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.cornerRadius = 10;
        NSLog(@"%s", __func__);
    }
    return self;
}

- (void)awakeFromNib
{
    NSLog(@"%s", __func__);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
