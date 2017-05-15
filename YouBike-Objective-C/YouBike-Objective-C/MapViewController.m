//
//  MapViewController.m
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import "MapViewController.h"
#import "StationTableViewCell.h"

@interface MapViewController () {

    NSArray *receivedStations;

}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Station *receivedStation = receivedStations[0];
    
    self.title = receivedStation.name;

    // Stationstop and Pin
//    CLLocationCoordinate2D stopLocation = CLLocationCoordinate2DMake(receivedStation.latitude, receivedStation.longitude);
//    [_mapView setRegion:MKCoordinateRegionMakeWithDistance(*stopLocation, 800, 800) animated:YES];
//    MKAnnotationView *pin = [[MKAnnotationView alloc] init];
//    [_mapView addAnnotation:pin];
    
    // Current Location
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    _mapView.showsUserLocation = YES;
    _mapView.zoomEnabled = YES;
    
    // Route
    
    _mapView.delegate = self;
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
        
            [_mapView addOverlay:route.polyline];
            [_mapView setVisibleMapRect:route.polyline.boundingMapRect animated:YES];
        };
    }];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UINib *nibOfTable = [UINib nibWithNibName:@"StationTableViewCell" bundle:nil];
    [_tableView registerNib:nibOfTable forCellReuseIdentifier:@"StationTableViewCell"];
//    UINib *nibOfMap = [UINib nibWithNibName:@"MapTableViewCell" bundle:nil];
//    [_tableView registerNib:nibOfMap forCellReuseIdentifier:@"MapTableViewCell"];
//    UINib *nibOfComment = [UINib nibWithNibName:@"CommentTableViewCell" bundle:nil];
//    [_tableView registerNib:nibOfComment forCellReuseIdentifier:@"CommentTableViewCell"];
    
    [_mapSegmentedControl addTarget:self action:@selector(mapStyleSwitch:) forControlEvents:UIControlEventTouchUpInside];
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
            _mapView.mapType = MKMapTypeStandard;
            break;
            
        case 1:
            _mapView.mapType = MKMapTypeSatellite;
            break;
            
        case 2:
            _mapView.mapType = MKMapTypeHybrid;
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
    
    //    NSInteger *row = indexPath.row;
    
    cell.nameLabel.text = @"";
    cell.addressLabel.text = @"";
    cell.numberLabel.text = @"";
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
