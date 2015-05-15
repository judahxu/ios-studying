//
//  QYViewController.m
//  RunPath
//
//  Created by qingyun on 15-4-13.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "QYAnnotation.h"


//1.开始，开始定位
//2.位置更新方法，添加开始点，添加当前点，更新路线
//3.实现暂停和结束事件
//4.实现MapView的代理，返回注释和覆盖层视图



@interface QYViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong)QYAnnotation *nowLocation;
@property (nonatomic, strong)NSMutableArray *allLocations;

@property (nonatomic) BOOL hasLocation;//是否有位置信息

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //配置locationManager
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    manager.desiredAccuracy = kCLLocationAccuracyBest;//精确度
    manager.distanceFilter = 15.f;//位置更新距离
    manager.delegate = self;
    [self setValue:manager forKey:@"locationManager"];
    
    self.allLocations = [NSMutableArray array];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)begin:(id)sender {
    [self.locationManager startUpdatingLocation];
    
}
- (IBAction)suspause:(id)sender {
    //添加一个暂停点
    QYAnnotation *annotaion = [[QYAnnotation alloc] init];
    annotaion.coordinate = self.nowLocation.coordinate;
    annotaion.type = kAnnotationSuspend;
    [self.mapView addAnnotation:annotaion];
    
    //停止定位
    
    [self.locationManager stopUpdatingLocation];
}
- (IBAction)end:(id)sender {
    //添加一个结束点
    
    QYAnnotation *annotation = [[QYAnnotation alloc] init];
    annotation.coordinate = self.nowLocation.coordinate;
    annotation.type = kAnnotationEnd;
    [self.mapView addAnnotation:annotation];
    
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - locationManager Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //位置更新的代理方法
    
    CLLocation *location = locations.lastObject;//最后一个为最新点
    
    QYAnnotation *annotation = [[QYAnnotation alloc] init];
    annotation.coordinate = location.coordinate;
    annotation.type = kAnnotutionNow;
    
    //nowLocation为空，则是第一个位置
    if (self.nowLocation) {
        [self.mapView removeAnnotation:self.nowLocation];
    }else{
        //如果为空，当前点为第一个点，添加开始点
        self.hasLocation = YES;
        QYAnnotation *beginAnno = [[QYAnnotation alloc] init];
        beginAnno.coordinate = location.coordinate;
        beginAnno.type = kAnnotationGo;
        [self.mapView addAnnotation:beginAnno];
        
        //设置地图的显示区域,只设置一次
        
        MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.05f, 0.05f));
        [self.mapView setRegion:region];
    }
    //添加当前点
    [self.mapView addAnnotation:annotation];
    //更新当前点的保存
    self.nowLocation = annotation;
    
    //保存所有点
    [self.allLocations addObject:location];
    
    
    //申请内存
    MKMapPoint *mapPoint = malloc(sizeof(MKMapPoint) * self.allLocations.count);
    //设置内容
    for (int i = 0; i < self.allLocations.count; i ++) {
        CLLocation *location = self.allLocations[i];
        mapPoint[i] = MKMapPointForCoordinate(location.coordinate);
    }
    
    MKPolyline *polyLine = [MKPolyline polylineWithPoints:mapPoint count:self.allLocations.count];

    
    [self.mapView addOverlay:polyLine];
    
    
}


#pragma mark - mapView delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[QYAnnotation class]]) {
       
        //确定是QYAnnotaion类型的对象
        QYAnnotation *anno = (QYAnnotation *)annotation;
        
        //复用AnnotaionView
        static NSString *indentifier = @"QYAnnotaion";
        MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:indentifier];
        if (!annoView) {
            annoView = [[MKAnnotationView alloc] initWithAnnotation:anno reuseIdentifier:indentifier];
        }
        
        switch (anno.type) {
            case kAnnotationGo:
            {
                [annoView setImage:[UIImage imageNamed:@"map_start_icon"]];
                //设置内容的偏移
                [annoView setCenterOffset:CGPointMake(0, -12)];
                //注释可以拖动
                annoView.draggable = YES;
                
            }
                break;
            case kAnnotationSuspend:
            {
                [annoView setImage:[UIImage imageNamed:@"map_susoend_icon"]];
                [annoView setCenterOffset:CGPointMake(0, -12)];
            }
                break;
            case kAnnotationEnd:
            {
                [annoView setImage:[UIImage imageNamed:@"map_stop_icon"]];
                [annoView setCenterOffset:CGPointMake(0, -12)];
            }
                break;
            case kAnnotutionNow:
            {
                [annoView setImage:[UIImage imageNamed:@"currentlocation"]];
            }
                break;
                
            default:
                break;
        }
        
        return annoView;
        
        
    }
    return nil;
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
//    MKPolylineRenderer
    //判断数据类型
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        renderer.lineWidth=3.f;
        renderer.strokeColor = [UIColor redColor];
        return renderer;
        
    }
    
    return nil;
}


@end
