//
//  NextViewController.m
//  NavigationCustomDemo
//
//  Created by BruceXu on 2019/6/29.
//  Copyright © 2019 BruceXu. All rights reserved.
//

#import "NextViewController.h"
#import "UIViewController+FOXNavigationBar.h"
@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.customBar.title = @"二级页面";
    id fff = self.customBar;
    int iii=0;
}
- (void)dealloc
{
    NSLog(@"退出");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
