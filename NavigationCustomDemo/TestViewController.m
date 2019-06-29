//
//  TestViewController.m
//  NavigationCustomDemo
//
//  Created by BruceXu on 2019/6/28.
//  Copyright © 2019 BruceXu. All rights reserved.
//

#import "TestViewController.h"
#import "UIViewController+FOXNavigationBar.h"
#import "NextViewController.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor greenColor];
    
    self.title = @"标题";
    //隐藏导航栏
    self.navigationBarHidden = YES;
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 60,40);
    [self.view addSubview:btn];
    [btn setTitle:@"下一级" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnNext) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnNext {
    NextViewController *next =  [NextViewController new];
  //  next.title = @"aaa";
    [self.tabBarController.navigationController pushViewController:next animated:YES];
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
