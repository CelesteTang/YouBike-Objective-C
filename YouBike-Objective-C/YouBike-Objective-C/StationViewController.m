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

    self.title = @"YouBike";
    
    _tableView.hidden = false;
    _collectionView.hidden = true;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StationTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
