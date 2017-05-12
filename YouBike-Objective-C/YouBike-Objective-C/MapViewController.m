//
//  MapViewController.m
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import "MapViewController.h"
#import "StationTableViewCell.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_mapSegmentedControl addTarget:self action:@selector(mapStyleSwitch:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)mapStyleSwitch: (UISegmentedControl *) sender {
    
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
    
    cell.viewMapButton.layer.cornerRadius = 4;
    cell.viewMapButton.layer.borderWidth = 1;
    cell.viewMapButton.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:204/255 green:113/255 blue:93/255 alpha:1]);
    
    return cell;
}

@end
