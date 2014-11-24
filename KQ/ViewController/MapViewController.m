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
        coord = shop.location.coordinate;
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
