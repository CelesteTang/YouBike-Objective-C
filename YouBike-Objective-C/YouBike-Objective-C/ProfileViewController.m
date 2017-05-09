//
//  ProfileViewController.m
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_goToFbButton addTarget:self action:@selector(goToFb) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goToFb {
    
}

@end
