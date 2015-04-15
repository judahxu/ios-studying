//
//  QYView.m
//  DemoBezierPath
//
//  Created by qingyun on 15-3-31.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYView.h"

@implementation QYView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    // 绘制圆角矩形
    // 1. 创建bezier path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(50, 100)];
    // 2. 设置填充颜色
    [[UIColor greenColor] setFill];
    
    // 3. 填充
    [path fill];
    
    // 绘制3次贝塞尔曲线
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(30, 30)];
    [bezierPath addCurveToPoint:CGPointMake(200, 300) controlPoint1:CGPointMake(100, 150) controlPoint2:CGPointMake(150, 100)];
    [[UIColor magentaColor] setStroke];
    [bezierPath stroke];
    
#if 0
    /**
     *  绘制不带箭尾的箭
     *  UIBezierPath
     */
    
    // 1. 黑色的箭shaft(轴)
    UIBezierPath *p = [UIBezierPath bezierPath];
    [p setLineWidth:20];
    [p moveToPoint:CGPointMake(100, 100)];
    [p addLineToPoint:CGPointMake(100, 25)];
    [[UIColor blackColor] setStroke];
    [p stroke];
    
    // 2. 红色的箭头(arrow)
    [[UIColor redColor] setFill];
    [p moveToPoint:CGPointMake(80, 25)];
    [p addLineToPoint:CGPointMake(100, 0)];
    [p addLineToPoint:CGPointMake(120, 25)];
    [p fill];
    
#endif
    
    // 获取当前绘图上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
#if 0
    // > 设置箭尾的三角区为不绘制区域(clipping)
    
//    CGContextSaveGState(ctx);
    
    CGContextMoveToPoint(ctx, 90, 100);
    CGContextAddLineToPoint(ctx, 100, 90);
    CGContextAddLineToPoint(ctx, 110, 100);
    
    CGRect flipRect = CGContextGetClipBoundingBox(ctx);
    
    CGContextAddRect(ctx, flipRect);
    
    CGContextEOClip(ctx);
    

    
    // > shaft
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 20);
    
    CGContextMoveToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 100, 25);
    
    CGContextStrokePath(ctx);
    
//    CGContextRestoreGState(ctx);
    
//    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
//    CGContextMoveToPoint(ctx, 90, 100);
//    CGContextAddLineToPoint(ctx, 100, 90);
//    CGContextAddLineToPoint(ctx, 110, 100);
//    CGContextFillPath(ctx);
    
    // > arrow
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    
    CGContextMoveToPoint(ctx, 80, 25);
    CGContextAddLineToPoint(ctx, 100, 0);
    CGContextAddLineToPoint(ctx, 120, 25);
    
    CGContextFillPath(ctx);
#endif
    
    [self drawArrowWithGradient:ctx];
}

- (void)drawArrowWithGradient:(CGContextRef)ctx
{
    // 坐标系转换
    CGContextTranslateCTM(ctx, 80, 0);
    
    // > 设置箭尾的三角区为不绘制区域(clipping)
    
    CGContextSaveGState(ctx);
    
    CGContextMoveToPoint(ctx, 10, 100);
    CGContextAddLineToPoint(ctx, 20, 90);
    CGContextAddLineToPoint(ctx, 30, 100);
    
    CGRect flipRect = CGContextGetClipBoundingBox(ctx);
    
    CGContextAddRect(ctx, flipRect);
    
    CGContextEOClip(ctx);

    // > shaft
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 20);
    
    CGContextMoveToPoint(ctx, 20, 100);
    CGContextAddLineToPoint(ctx, 20, 25);
    
    CGContextReplacePathWithStrokedPath(ctx);
    
    CGContextClip(ctx);
    
    //CGContextStrokePath(ctx);
    
    // 给shaft添加渐变
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    const CGFloat components[] = {0.6, 0.6, 0.6, 0.6,
                                    0.0, 0.0, 0.0, 1.0,
                                    0.6,0.6,0.6,0.6};
    const CGFloat locations[] = {0, 0.618, 1};
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 3);
    CGContextDrawLinearGradient(ctx, gradient, CGPointMake(10, 100), CGPointMake(30, 100), 0);
    
    CGContextRestoreGState(ctx);
    
    CGColorSpaceRelease(colorSpace);
    
    // > arrow
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    
    CGContextMoveToPoint(ctx, 0, 25);
    CGContextAddLineToPoint(ctx, 20, 0);
    CGContextAddLineToPoint(ctx, 40, 25);
    
    CGContextFillPath(ctx);
}


@end
