//
//  StationTableViewCell.m
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import "StationTableViewCell.h"

@implementation StationTableViewCell

@synthesize markerImageView = _markerImageView;
@synthesize nameLabel = _nameLabel;
@synthesize addressLabel = _addressLabel;
@synthesize numberLabel = _numberLabel;
@synthesize viewMapButton = _viewMapButton;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
