//
//  MapViewController.m
//  KQ
//
//  Created by AppDevelopper on 14-6-19.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "MapViewController.h"
#import "UIImageView+WebCache.h"

@interface ShopAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) Shop *shop;


- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end


@implementation ShopAnnotation

- (NSString*)title{
    return self.shop.title;
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
    
//    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(31.1, 121.1);
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
    _mapView.delegate = self;
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
        
//        Shop *shop = annotation.shop;
        
            pinView.pinColor = MKPinAnnotationColorRed;
            
            pinView.animatesDrop = YES;
            
            pinView.canShowCallout = YES;
            
            // If appropriate, customize the callout by adding accessory views (code not shown).
//        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        
//        [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 45)];
//        label.numberOfLines = 0;
//        label.font = [UIFont fontWithName:kFontName size:13];
//        label.text = [NSString stringWithFormat:@"%@\n%@",shop.title,shop.address];
//        pinView.rightCalloutAccessoryView = label;
        
        
        
        // Add a custom image to the left side of the callout.
        
//        UIImageView *myCustomImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 67, 45)];
//        myCustomImage.contentMode = UIViewContentModeScaleAspectFit;
//        myCustomImage.layer.masksToBounds = YES;
//        myCustomImage.backgroundColor = [UIColor redColor];
//        NSLog(@"img # %@",shop.posterUrl);
////        [myCustomImage setImageWithURL:[NSURL URLWithString:shop.posterUrl]];
//        
////        myCustomImage.image = [UIImage imageNamed:@"icon_menu.png"];
//        pinView.leftCalloutAccessoryView = myCustomImage;
        
//        [pinView setSize:CGSizeMake(300, 60)];
    }
    
        
        return pinView;
        
    
}
@end
