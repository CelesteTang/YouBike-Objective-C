//
//  StationViewController.m
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import "StationViewController.h"
#import "StationTableViewCell.h"
#import <UIKit/UIKit.h>

@interface StationViewController ()

@end

@implementation StationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"YouBike";
    
    _tableView.hidden = false;
    _collectionView.hidden = true;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UINib *nibOfTable = [UINib nibWithNibName:@"StationTableViewCell" bundle:nil];
    [_tableView registerNib:nibOfTable forCellReuseIdentifier:@"StationTableViewCell"];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    UINib *nibOfCollection = [UINib nibWithNibName:@"StationCollectionViewCell" bundle:nil];
    [_collectionView registerNib:nibOfCollection forCellWithReuseIdentifier:@"StationCollectionViewCell"];

    [_listGridSegmentedControl addTarget:self action:@selector(indexChanged:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)indexChanged: (UISegmentedControl *) sender {
    
    switch (sender.selectedSegmentIndex) {
            
        case 0:
            _tableView.hidden = true;
            _collectionView.hidden = false;
            
        case 1:
            _tableView.hidden = false;
            _collectionView.hidden = true;
            
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
    [cell.viewMapButton addTarget:self action:@selector(viewMap) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)viewMap {

}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StationCollectionViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


@end
