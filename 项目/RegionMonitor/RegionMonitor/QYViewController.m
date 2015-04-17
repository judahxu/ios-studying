//
//  QYViewController.m
//  RegionMonitor
//
//  Created by qingyun on 15-4-14.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

//添加监听区域, <wpt lat="34.76705250" lon="113.76887056"></wpt>
//确定当前位置
//添加覆盖层
//location & Map delegate


@interface QYViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) MKPointAnnotation *nowAnno;


@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    
    //开启定位
    self.manager  = [[CLLocationManager alloc] init];
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    self.manager.distanceFilter = 10.f;
    self.manager.delegate = self;
    [self.manager startUpdatingLocation];
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(34.76705250, 113.76887056);
    CLRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:1000 identifier:@"region"];
    
    [self.manager startMonitoringForRegion:region];
    
    MKCoordinateRegion mapregion = MKCoordinateRegionMake(center, MKCoordinateSpanMake(0.1, 0.1));
    
    [self.mapView setRegion:mapregion];
    
    
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:center radius:1000];
    [self.mapView addOverlay:circle];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - location delegate

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@">>>>>>>>%@", region.identifier);
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"<<<<<<<<%@",region.identifier);
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = locations.lastObject;
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location.coordinate;
    
    [self.mapView addAnnotation:point];
    
    if (self.nowAnno) {
        [self.mapView removeAnnotation:self.nowAnno];
    }
    self.nowAnno = point;
}

#pragma mark - mapView delegate

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithCircle:overlay];
        renderer.lineWidth = 2.f;
        renderer.strokeColor = [UIColor redColor];
        renderer.fillColor= [UIColor colorWithRed:0 green:1 blue:0 alpha:.5f];
        return renderer;
        
    }
    return nil;
}

@end
