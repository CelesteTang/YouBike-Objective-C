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
#import "StationManager.h"
#import "TabBarController.h"
#import "StationViewController.h"

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

//    if ([FBSDKAccessToken currentAccessToken]) {
//        printf("suc");
//    } else {
//        
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        login.loginBehavior = FBSDKLoginBehaviorBrowser;
        [login logInWithReadPermissions:@[@"public_profile",@"email"] fromViewController: self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            
            if (error)
            {
                // Process error
            }
            else if (result.isCancelled)
            {
                // Handle cancellations
            }
            else
            {
                if ([result.grantedPermissions containsObject:@"email"])
                {
                    NSLog(@"result is:%@",result);
                    if ([FBSDKAccessToken currentAccessToken]) {
                        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, email, name, picture.type(large), link"}]
                         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                             if (!error) {
                                 NSLog(@"fetched user:%@", result);
                                 [[NSUserDefaults standardUserDefaults] setObject:[result valueForKeyPath:@"name"] forKey:@"name"];
                                 [[NSUserDefaults standardUserDefaults] setObject:[result valueForKeyPath:@"email"] forKey:@"email"];
                                 [[NSUserDefaults standardUserDefaults] setObject:[[[result valueForKeyPath:@"picture"]valueForKeyPath:@"data"] valueForKeyPath:@"url"]
                                    forKey:@"picture"];
                                 [[NSUserDefaults standardUserDefaults] setObject:[[FBSDKAccessToken currentAccessToken]tokenString] forKey:@"token"];
                                 
                                 //instantiate viewcontroller
                                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: [NSBundle mainBundle]];
                                 TabBarController *vc = [storyboard instantiateViewControllerWithIdentifier:
                                                         @"TabBarController"];
                                 
                                 StationViewController* mainVC = [vc viewControllers][0];
                                 
                                 mainVC.datamodel = [StationManager sharedInstance];
                                 
                                 [StationManager sharedInstance].delegate = mainVC;
                                 
                                 [[StationManager sharedInstance] getStationsWithFacebookToken: [[FBSDKAccessToken currentAccessToken]tokenString]];
                                 
                                 [self presentViewController:vc animated:true completion:^{
                                     
                                 }];
                                 
                             }else{
                                 NSLog(@"%@",error);
                             }
                         }];
                    }
                    
                    
                }
            }
            
        }];
        
        
//    }
    
}

@end
