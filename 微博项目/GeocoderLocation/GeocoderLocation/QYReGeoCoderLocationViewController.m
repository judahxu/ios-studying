//
//  QYReGeoCoderLocationViewController.m
//  GeocoderLocation
//
//  Created by qingyun on 15-4-13.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYReGeoCoderLocationViewController.h"

@interface QYReGeoCoderLocationViewController ()

@end

@implementation QYReGeoCoderLocationViewController

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
    // Do any additional setup after loading the view.
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.mapView addGestureRecognizer:gesture];
}

-(void)longPress:(UILongPressGestureRecognizer *)gesture{
    //得到用户选择的point
    //将Frame转化为坐标
    //将坐标转化为地理位置信息
    
    CGPoint point = [gesture locationInView:self.mapView];
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    CLGeocoder *grocoder = [[CLGeocoder alloc] init];
    
    [grocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"%@", placemarks.firstObject);
        
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        MKPlacemark *placemark = placemarks.firstObject;
        CLLocation *location = placemark.location;
        point.coordinate = location.coordinate;
        point.title = placemark.name;
        [self.mapView addAnnotation:point];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
