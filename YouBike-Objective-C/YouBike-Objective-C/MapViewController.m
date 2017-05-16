//
//  MapViewController.m
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import "MapViewController.h"
#import "StationTableViewCell.h"
#import <CoreLocation/CoreLocation.h>

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize tableView;
@synthesize mapView;
@synthesize mapSegmentedControl;
@synthesize receivedStation;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = receivedStation.name;

    // Stationstop and Pin
    long double latitude = [receivedStation.latitude doubleValue];
    long double longitude = [receivedStation.longitude doubleValue];
    CLLocationCoordinate2D stopLocation = CLLocationCoordinate2DMake(latitude, longitude);
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(stopLocation, 800, 800) animated:YES];
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.title = receivedStation.name;
    pin.subtitle = receivedStation.address;
    pin.coordinate = stopLocation;
    [mapView addAnnotation:pin];
    
    // Current Location
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    mapView.showsUserLocation = YES;
    mapView.zoomEnabled = YES;
    
    // Route
    
    mapView.delegate = self;
    MKDirectionsRequest *directionRequest = [[MKDirectionsRequest alloc] init];
    MKPlacemark *source = [[MKPlacemark alloc]initWithCoordinate:locationManager.location.coordinate];
    directionRequest.source = [[MKMapItem alloc] initWithPlacemark:source];
//    MKPlacemark *destination = [[MKPlacemark alloc]initWithCoordinate:stopLocation];
//    directionRequest.destination = [[MKMapItem alloc]initWithPlacemark:destination];
    directionRequest.requestsAlternateRoutes = YES;
    directionRequest.transportType = MKDirectionsTransportTypeWalking;

    MKDirections *directions = [[MKDirections alloc]initWithRequest:directionRequest];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@", response);
        NSLog(@"%@", error);
        
        for (MKRoute *route in response.routes) {
        
            [mapView addOverlay:route.polyline];
            [mapView setVisibleMapRect:route.polyline.boundingMapRect animated:YES];
        };
    }];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    UINib *nibOfTable = [UINib nibWithNibName:@"StationTableViewCell" bundle:nil];
    [tableView registerNib:nibOfTable forCellReuseIdentifier:@"StationTableViewCell"];
//    UINib *nibOfMap = [UINib nibWithNibName:@"MapTableViewCell" bundle:nil];
//    [_tableView registerNib:nibOfMap forCellReuseIdentifier:@"MapTableViewCell"];
//    UINib *nibOfComment = [UINib nibWithNibName:@"CommentTableViewCell" bundle:nil];
//    [_tableView registerNib:nibOfComment forCellReuseIdentifier:@"CommentTableViewCell"];
    tableView.allowsSelection = NO;
    
    [mapSegmentedControl addTarget:self action:@selector(mapStyleSwitch:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
//    [locationManager stopUpdatingLocation];
}

- (void)mapStyleSwitch: (UISegmentedControl *) sender {
    
    NSLog(@"%ld", (long)sender.selectedSegmentIndex);
    
    switch (sender.selectedSegmentIndex) {
            
        case 0:
            mapView.mapType = MKMapTypeStandard;
            break;
            
        case 1:
            mapView.mapType = MKMapTypeSatellite;
            break;
            
        case 2:
            mapView.mapType = MKMapTypeHybrid;
            break;
            
        default: break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 122;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StationTableViewCell *cell = (StationTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"StationTableViewCell" forIndexPath:indexPath];
    
    cell.markerImageView.image = [UIImage imageNamed:@"iconMarker"];
        
    cell.nameLabel.text = receivedStation.name;
    cell.addressLabel.text = receivedStation.address;
    cell.numberLabel.text = receivedStation.numberOfRemainingBikes;

    cell.viewMapButton.hidden = YES;
    
    return cell;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {

    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc]initWithPolyline:overlay];
    renderer.strokeColor = [UIColor colorWithRed:201/255 green:28/255 blue:187/255 alpha:1];
    renderer.lineWidth = 10;
    
    return renderer;

}

@end
