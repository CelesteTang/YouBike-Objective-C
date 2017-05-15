//
//  StationViewController.m
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationViewController.h"
#import "StationTableViewCell.h"
#import "StationCollectionViewCell.h"

@interface StationViewController ()

@end

@implementation StationViewController

@synthesize tableView;
@synthesize collectionView;
@synthesize listGridSegmentedControl;
@synthesize station1;
@synthesize station2;
@synthesize station3;
@synthesize station4;
@synthesize station5;
@synthesize stations;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    station1 = [[Station alloc]initWithName:@"信義區 / 捷運市政府站(3號出口)" Address:@"忠孝東路/松仁路(東南側)" NumberOfRemainingBikes:20 Latitude:25.0408578889 Longitude:121.567904444];
    station2 = [[Station alloc]initWithName:@"大安區 / 捷運國父紀念館站(2號..." Address:@"忠孝東路四段/光復南路口(..." NumberOfRemainingBikes:3 Latitude:25.0408578889 Longitude:121.567904444];
    station3 = [[Station alloc]initWithName:@"信義區 / 台北市政府" Address:@"台北市政府東門(松智路)" NumberOfRemainingBikes:15 Latitude:25.0408578889 Longitude:121.567904444];
    station4 = [[Station alloc]initWithName:@"信義區 / 市民廣場" Address:@"市府路/松壽路(西北側)" NumberOfRemainingBikes:8 Latitude:25.0408578889 Longitude:121.567904444];
    station5 = [[Station alloc]initWithName:@"信義區 / 興雅國中" Address:@"松仁路/松仁路95巷(東南側)" NumberOfRemainingBikes:9 Latitude:25.0408578889 Longitude:121.567904444];
    
    stations = [[NSArray alloc]initWithObjects:station1, station2, station3, station4, station5, nil];
    
    self.title = @"YouBike";
    
    tableView.hidden = NO;
    collectionView.hidden = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    UINib *nibOfTable = [UINib nibWithNibName:@"StationTableViewCell" bundle:nil];
    [tableView registerNib:nibOfTable forCellReuseIdentifier:@"StationTableViewCell"];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    UINib *nibOfCollection = [UINib nibWithNibName:@"StationCollectionViewCell" bundle:nil];
    [collectionView registerNib:nibOfCollection forCellWithReuseIdentifier:@"StationCollectionViewCell"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setSectionInset:UIEdgeInsetsMake(14, 14, 14, 14)];
    layout.minimumLineSpacing = 14;
    layout.itemSize = CGSizeMake(166, 166);
    
    [listGridSegmentedControl addTarget:self action:@selector(indexChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)indexChanged: (UISegmentedControl *) sender {
        
    switch (sender.selectedSegmentIndex) {
            
        case 0:
            tableView.hidden = NO;
            collectionView.hidden = YES;
            break;
            
        case 1:
            tableView.hidden = YES;
            collectionView.hidden = NO;
            break;
            
        default:
            break;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return stations.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 122;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StationTableViewCell *cell = (StationTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"StationTableViewCell" forIndexPath:indexPath];
    
    cell.markerImageView.image = [UIImage imageNamed:@"iconMarker"];
    
    Station *station = self->stations[indexPath.row];

    cell.nameLabel.text = station.name;
    cell.addressLabel.text = station.address;
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",station.numberOfRemainingBikes];

    cell.viewMapButton.layer.cornerRadius = 4;
    cell.viewMapButton.layer.borderWidth = 1;
    cell.viewMapButton.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:204/255 green:113/255 blue:93/255 alpha:1]);
    [cell.viewMapButton addTarget:self action:@selector(viewMap:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)viewMap: (UIButton *) sender {

    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mapViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
//    mapViewController.receivedStations = [stations[indexPath.row]];
    
    [self.navigationController pushViewController:mapViewController animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController *mapViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
//    mapViewController.receivedStations = stations[indexPath.row];
    
    [self.navigationController pushViewController:mapViewController animated:YES];
    
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    StationCollectionViewCell *cell = (StationCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"StationCollectionViewCell" forIndexPath:indexPath];
    
    Station *station = self->stations[indexPath.item];
    
    cell.nameLabel.text = station.name;
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",station.numberOfRemainingBikes];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController *mapViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
//    mapViewController.receivedStations = stations[indexPath.item];
    
    [self.navigationController pushViewController:mapViewController animated:YES];

}

@end
