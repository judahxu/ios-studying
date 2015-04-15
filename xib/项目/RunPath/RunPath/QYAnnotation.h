//
//  QYAnnotation.h
//  RunPath
//
//  Created by qingyun on 15-4-13.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


typedef enum{
    kAnnotationGo,
    kAnnotationSuspend,
    kAnnotationEnd,
    kAnnotutionNow
} kAnnotationType;

//实现MKAnnotaion协议的对象
@interface QYAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;//实现MkAnnotaion协议


@property (nonatomic) kAnnotationType type;//区分不同的点

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
-(void)getCoordinate;

@end
