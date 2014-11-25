//
//  MapViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-19.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "MapViewController.h"
#import "UIImageView+WebCache.h"

#pragma mark - ShopAnnotation

@interface ShopAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) Shop *shop;


- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end


@implementation ShopAnnotation

- (NSString*)title{
    return self.shop.title;
}

- (NSString*)subtitle{
    return self.shop.address;
}

- (id)initWithLocation:(CLLocationCoordinate2D)coord{

    if (self = [super init]) {
        _coordinate = coord;
    }
    
    return self;
}


@end

#pragma mark - MapViewController

@interface MapViewController (){


    ShopAnnotation *_shopAnnotation;
}


@end

@implementation MapViewController



- (void)setShop:(Shop *)shop{
    _shop = shop;
    
    CLLocationCoordinate2D coord;
    

    if (ISEMPTY(shop.location)) {
        
        coord = CLLocationCoordinate2DMake(31.1, 121.1);

    }else{
/*
 
 double x = bd_lon - 0.0065, y = bd_lat - 0.006;
 double z = Math.sqrt(x * x + y * y) - 0.00002 * Math.sin(y * x_pi);
 double theta = Math.atan2(y, x) - 0.000003 * Math.cos(x * x_pi);
 gg_lon = z * Math.cos(theta);
 gg_lat = z * Math.sin(theta);
 

 */
 
         double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
        double x = shop.location.coordinate.longitude - 0.0065, y = shop.location.coordinate.latitude - 0.006;
        double z = sqrt(x*x + y*y) - 0.00002 * sin(y * x_pi);
        double theta = atan2(y, x) - 0.000003 *cos(x * x_pi);
        double longitude = z * cos(theta);
        double latitude = z *sin(theta);
        
//        NSLog(@"lon # %f, lat # %f",longitude,latitude);
//        coord = shop.location.coordinate;
        coord = CLLocationCoordinate2DMake(latitude, longitude);
    }
    
    _shopAnnotation = [[ShopAnnotation alloc] initWithLocation:coord];
    _shopAnnotation.shop = shop;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"地图";
    
    if (isIOS7) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    self.navigationController.navigationBar.translucent = NO;
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
 
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance(_shopAnnotation.coordinate, 10000, 10000) animated:YES];
    [_mapView addAnnotation:_shopAnnotation];
  

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(ShopAnnotation*)annotation{

    // If the annotation is the user location, just return nil.
    
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        
        return nil;
    }
        // Try to dequeue an existing pin view first.
        
    MKPinAnnotationView*  pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
    if (!pinView){
            // If an existing pin view was not available, create one.
            
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:@"CustomPinAnnotationView"];
        
            pinView.annotation = annotation;
        
            pinView.pinColor = MKPinAnnotationColorRed;
            
            pinView.animatesDrop = YES;
            
            pinView.canShowCallout = YES;
        
        
    }
    
        
        return pinView;
        
    
}
@end
