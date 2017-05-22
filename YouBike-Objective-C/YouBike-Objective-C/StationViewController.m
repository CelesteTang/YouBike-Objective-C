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
#import "StationManager.h"

@interface StationViewController ()

@end

@implementation StationViewController {
    
}

@synthesize datamodel;
@synthesize stationTableView;
@synthesize stationCollectionView;
@synthesize listGridSegmentedControl;

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.title = @"YouBike";
    
    stationTableView.hidden = NO;
    stationCollectionView.hidden = YES;
    
    stationTableView.delegate = self;
    stationTableView.dataSource = self;
    UINib *nibOfTable = [UINib nibWithNibName:@"StationTableViewCell" bundle:nil];
    [stationTableView registerNib:nibOfTable forCellReuseIdentifier:@"StationTableViewCell"];
    
    stationCollectionView.delegate = self;
    stationCollectionView.dataSource = self;
    UINib *nibOfCollection = [UINib nibWithNibName:@"StationCollectionViewCell" bundle:nil];
    [stationCollectionView registerNib:nibOfCollection forCellWithReuseIdentifier:@"StationCollectionViewCell"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setSectionInset:UIEdgeInsetsMake(14, 14, 14, 14)];
    layout.minimumLineSpacing = 14;
    layout.itemSize = CGSizeMake(166, 166);
    
    [listGridSegmentedControl addTarget:self action:@selector(indexChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)indexChanged: (UISegmentedControl *) sender {
        
    switch (sender.selectedSegmentIndex) {
            
        case 0:
            stationTableView.hidden = NO;
            stationCollectionView.hidden = YES;
            break;
            
        case 1:
            stationTableView.hidden = YES;
            stationCollectionView.hidden = NO;
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
    
    return [datamodel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 122;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StationTableViewCell *cell = (StationTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"StationTableViewCell" forIndexPath:indexPath];
    
    cell.markerImageView.image = [UIImage imageNamed:@"iconMarker"];
    
    Station *station = [datamodel getStationsWith:indexPath.section andRow:indexPath.row];
    
    cell.nameLabel.text = station.name;
    cell.addressLabel.text = station.address;
    cell.numberLabel.text = station.numberOfRemainingBikes;

    cell.viewMapButton.layer.cornerRadius = 4;
    cell.viewMapButton.layer.borderWidth = 1;
    cell.viewMapButton.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:204/255.0 green:113/255.0 blue:93/255.0 alpha:1.0]);
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
    
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    MapViewController *mapViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
//    
//    Station *station = self->stations[indexPath.row];
//    
//    mapViewController.receivedStation = station;
//
//    [self.navigationController pushViewController:mapViewController animated:YES];
    
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [datamodel numberOfRowsInSection:section];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    StationCollectionViewCell *cell = (StationCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"StationCollectionViewCell" forIndexPath:indexPath];
    
    Station *station = [datamodel getStationsWith:indexPath.section andRow:indexPath.row];
    
    cell.nameLabel.text = station.name;
    cell.numberLabel.text = station.numberOfRemainingBikes;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    MapViewController *mapViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
//    
//    Station *station = self->stations[indexPath.item];
//    
//    mapViewController.receivedStation = station;
//    
//    [self.navigationController pushViewController:mapViewController animated:YES];

}

-(void) didGetStationFromServer {
    
    NSLog(@"=========================");
    NSLog(@"Reload data");
    [stationTableView reloadData];
    [stationCollectionView reloadData];
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGSize size = [scrollView contentSize];
    CGPoint offset = [scrollView contentOffset];
    float bottomEdge = scrollView.frame.size.height + offset.y;
    
    if(bottomEdge >= size.height){
        NSLog(@"=================");
        NSLog(@"Reach the end of scroll view");
        [datamodel getMoreStations];
    }
}
@end
