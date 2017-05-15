//
//  MapTableViewCell.h
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/15.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
