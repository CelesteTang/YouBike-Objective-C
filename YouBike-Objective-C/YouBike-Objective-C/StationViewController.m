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
#import "Station.h"

@interface StationViewController ()

@end

@implementation StationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"YouBike";
    
    _tableView.hidden = NO;
    _collectionView.hidden = YES;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UINib *nibOfTable = [UINib nibWithNibName:@"StationTableViewCell" bundle:nil];
    [_tableView registerNib:nibOfTable forCellReuseIdentifier:@"StationTableViewCell"];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    UINib *nibOfCollection = [UINib nibWithNibName:@"StationCollectionViewCell" bundle:nil];
    [_collectionView registerNib:nibOfCollection forCellWithReuseIdentifier:@"StationCollectionViewCell"];
    
    [_listGridSegmentedControl addTarget:self action:@selector(indexChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)indexChanged: (UISegmentedControl *) sender {
    
    switch (sender.selectedSegmentIndex) {
            
        case 0:
            _tableView.hidden = YES;
            _collectionView.hidden = NO;
            
        case 1:
            _tableView.hidden = NO;
            _collectionView.hidden = YES;
            
        default:
            break;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 122;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StationTableViewCell *cell = (StationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"StationTableViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StationTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.markerImageView.image = [UIImage imageNamed:@"iconMarker"];
    
//    NSInteger *row = indexPath.row;

    cell.nameLabel.text = @"";
    cell.addressLabel.text = @"";
    cell.numberLabel.text = @"";

    cell.viewMapButton.layer.cornerRadius = 4;
    cell.viewMapButton.layer.borderWidth = 1;
    cell.viewMapButton.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:204/255 green:113/255 blue:93/255 alpha:1]);
    [cell.viewMapButton addTarget:self action:@selector(viewMap:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)viewMap: (UIButton *) sender {

    [self performSegueWithIdentifier:@"viewMap" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

//    UIButton *button = sender;
//    StationTableViewCell *cell = button.superview.superview;
//    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mapViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
//    mapViewController.receivedStations = [stations[indexPath.row]]
    
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
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StationCollectionViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
//    NSInteger *item = indexPath.item;
    
    cell.nameLabel.text = @"";
    cell.numberLabel.text = @"";
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mapViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
//    mapViewController.receivedStations = [stations[indexPath.row]]
    
    [self.navigationController pushViewController:mapViewController animated:YES];

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(166, 166);
}

-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(14, 14, 14, 14);
}

-(CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    return 14;
}

@end
