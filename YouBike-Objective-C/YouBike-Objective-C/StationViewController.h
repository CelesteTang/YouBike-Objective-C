//
//  StationViewController.h
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationManager.h"
#import "Station.h"
#import "MapViewController.h"

@interface StationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, StationManagerDelegate> {
    
    
}

@property (strong, atomic, readwrite) StationManager *datamodel;

@property (weak, nonatomic) IBOutlet UITableView *stationTableView;

@property (weak, nonatomic) IBOutlet UICollectionView *stationCollectionView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *listGridSegmentedControl;

-(void) didGetStationFromServer;

@end
