//
//  MapViewController.m
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_mapStyleSegmentedControl addTarget:self action:@selector(mapStyleSwitch) forControlEvents:UIControlEventTouchUpInside];
}

- (void)mapStyleSwitch {
    
}

@end
