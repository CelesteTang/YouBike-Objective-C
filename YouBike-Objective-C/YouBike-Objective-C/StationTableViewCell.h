//
//  StationTableViewCell.h
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markerImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UIButton *viewMapButton;

@end
