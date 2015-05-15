//
//  QYGeoCoderLocatonViewController.m
//  GeocoderLocation
//
//  Created by qingyun on 15-4-13.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYGeoCoderLocatonViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface QYGeoCoderLocatonViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFild;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation QYGeoCoderLocatonViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)textend:(id)sender {

    //获取用户输入的文字信息，并且编码成地理位置信息
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.textFild.text completionHandler:^(NSArray *placemarks, NSError *error) {
        
        //计算经度纬度的最大最小值
        double minLatitude = 90;
        double maxLatitude = -90;
        
        double minLongtitude = 180;
        double maxLoongtitude = -180;
        
        for (CLPlacemark *placemark in placemarks) {
            CLLocation *location = placemark.location;
            
            minLatitude = location.coordinate.latitude < minLatitude ? location.coordinate.latitude : minLatitude;
            maxLatitude = location.coordinate.latitude > maxLatitude ? location.coordinate.latitude : maxLatitude;
            
            minLongtitude = location.coordinate.longitude < minLongtitude ? location.coordinate.longitude : minLongtitude;
            
            maxLoongtitude = location.coordinate.longitude > maxLoongtitude ? location.coordinate.longitude : maxLoongtitude;
            
            
            //添加注释点
            
            MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
            anno.title = placemark.name;
            anno.coordinate = location.coordinate;
            
        }
        
        //计算区域
        
        double centerLatitude = (minLatitude + maxLatitude)/2;
        double cengerLongtitude = (minLongtitude + maxLoongtitude)/2;
        
        double latitudeSpan = maxLatitude - minLatitude;
        double longtitudeSpan = maxLoongtitude - minLongtitude;
        
        //中心点
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(centerLatitude, cengerLongtitude);
        //span
        MKCoordinateSpan span = MKCoordinateSpanMake(latitudeSpan, longtitudeSpan);
        
        MKCoordinateRegion region =MKCoordinateRegionMake(coordinate, span);
        
        [self.mapView setRegion:region];
    }];
    
    
    
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
