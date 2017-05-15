//
//  StationViewController.h
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Station.h"
#import "MapViewController.h"

@interface StationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *listGridSegmentedControl;

@property Station *station1;
@property Station *station2;
@property Station *station3;
@property Station *station4;
@property Station *station5;
@property NSArray *stations;

@end
