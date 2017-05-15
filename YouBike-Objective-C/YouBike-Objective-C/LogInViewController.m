//
//  LogInViewController.m
//  YouBike-Objective-C
//
//  Created by 湯芯瑜 on 2017/5/9.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

#import "LogInViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern-wood.jpg"]];
    
    _logoImageView.layer.cornerRadius = _logoImageView.frame.size.width / 2;
    _logoImageView.layer.borderWidth = 1;
    _logoImageView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:61/255 green:52/255 blue:66/255 alpha:1]);
    
    [_logInButton addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)logIn {

    if ([FBSDKAccessToken currentAccessToken]) {
        printf("suc");
    } else {
        
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        login.loginBehavior = FBSDKLoginBehaviorBrowser;
        [login logInWithReadPermissions:@[@"public_profile",@"email"] fromViewController: self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            
            
            printf("login");
            
            
        }];
        
        
    }
    
}

@end
