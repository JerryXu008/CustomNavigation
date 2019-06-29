//
//  BaseTabBarViewController.m
//  NavigationCustomDemo
//
//  Created by BruceXu on 2019/6/28.
//  Copyright © 2019 BruceXu. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "TestViewController.h"
#import "FOXNavigationViewController.h"
#import "UIColor+Extension.h"
#define kRegularFont(font)  ([UIFont systemFontOfSize:font])
#define kSetColor(color) [UIColor colorWithHexString:color]
@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    TestViewController *homeVC = [[TestViewController alloc] init];
    
    FOXNavigationViewController *homeNC = [[FOXNavigationViewController alloc] initWithRootViewController:homeVC];
    
    
    
    
    [self setTabBarItem:homeNC.tabBarItem title:@"首页"  selectedImage:@"tabbaritem_home_select" selectedTitleColor:kSetColor(@"ff8724") normalImage:@"tabbaritem_home" normalTitleColor:kSetColor(@"999999")];
    
    self.viewControllers = @[homeNC];
    
}

- (void)setTabBarItem:(UITabBarItem *)tabbarItem
                title:(NSString *)title
        selectedImage:(NSString *)selectedImage
   selectedTitleColor:(UIColor *)selectColor
          normalImage:(NSString *)unselectedImage
     normalTitleColor:(UIColor *)unselectColor
{
    
    //设置图片
    tabbarItem = [tabbarItem initWithTitle:title image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // S未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:kRegularFont(10)} forState:UIControlStateNormal];
    
    // 选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:kRegularFont(10)} forState:UIControlStateSelected];
}

@end
