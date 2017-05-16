//
//  ProfileViewController.m
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import "ProfileViewController.h"
#import <SafariServices/SafariServices.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern-wood.jpg"]];
    
    _cardBaseView.layer.cornerRadius = 20;
    
    _photoBorderView.layer.cornerRadius = _photoBorderView.frame.size.width / 2;
    
    _photoImageView.layer.cornerRadius = _photoImageView.frame.size.width / 2;
    _photoImageView.layer.masksToBounds = YES;
    
    _userNameLabel.text = [NSUserDefaults.standardUserDefaults stringForKey:@"name"];

    NSString *pictureURL = [NSUserDefaults.standardUserDefaults stringForKey:@"picture"];
    NSURL *url = [NSURL URLWithString:pictureURL];
    
    if (url == nil) { /* error handling */ }
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    _photoImageView.image = [UIImage imageWithData:data];

    _goToFbButton.layer.cornerRadius = 10;
    [_goToFbButton addTarget:self action:@selector(goToFb) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goToFb {
    
    NSString *linkURL = [NSUserDefaults.standardUserDefaults stringForKey:@"link"];
    NSURL *url = [NSURL URLWithString:linkURL];
    SFSafariViewController *userPage = [[SFSafariViewController alloc] initWithURL:url entersReaderIfAvailable:YES];
    [self presentViewController:userPage animated:YES completion:nil];
    
}

@end
