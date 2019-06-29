//
//  ViewController.m
//  NavigationCustomDemo
//
//  Created by BruceXu on 2019/6/28.
//  Copyright © 2019 BruceXu. All rights reserved.
//

#import "ViewController.h"
#import "BaseTabBarViewController/BaseTabBarViewController.h"
#import "AppDelegate.h"
#import "FOXNavigationViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BaseTabBarViewController *baseTabBarVC  = [[BaseTabBarViewController alloc] init];
    
    FOXNavigationViewController *indNav = [[FOXNavigationViewController alloc] initWithRootViewController:baseTabBarVC];
    [indNav setNavigationBarHidden:YES];
   
//    UINavigationController *indNav = [[UINavigationController alloc] initWithRootViewController:baseTabBarVC];
//    [indNav setNavigationBarHidden:YES];

    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = indNav;
    
    self.view.backgroundColor=[UIColor blueColor];
}


@end
