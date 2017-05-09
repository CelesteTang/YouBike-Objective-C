//
//  MapViewController.h
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *mapStyleSegmentedControl;

@end
