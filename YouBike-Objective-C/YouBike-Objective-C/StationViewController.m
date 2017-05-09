//
//  StationViewController.m
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import "StationViewController.h"

@interface StationViewController ()

@end

@implementation StationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_listGridSegmentedControl addTarget:self action:@selector(indexChanged) forControlEvents:UIControlEventTouchUpInside];
}

- (void)indexChanged {
    
}

@end
