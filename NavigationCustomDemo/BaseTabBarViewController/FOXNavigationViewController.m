//
//  FOXNavigationViewController.m
//  FOXNavigationBar
//
//  Created by XFoxer on 16/1/20.
//  Copyright © 2016年 XFoxer. All rights reserved.
//

#import "FOXNavigationViewController.h"
#import "UIViewController+FOXNavigationBar.h"
#import "FOXNavigationBar.h"
#import "SuperViewController.h"

@interface FOXNavigationViewController ()<UIGestureRecognizerDelegate>

/** 是否允许侧滑返回 */
@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;


//@property (nonatomic, strong) FOXNavigationBar *navigationBar;



@end //风格复古风格

@implementation FOXNavigationViewController


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        //默认最大响应范围
        self.maxAllowedInitialDistance = 30;
        
    }
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    
    
    /** 添加侧滑返回的手势 */
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:target
                                                                                action:internalAction];
    [panGesture setDelegate:self];
    [panGesture setMaximumNumberOfTouches:1];
    [self.view addGestureRecognizer:panGesture];
    
    //关闭系统侧滑
    [self.interactivePopGestureRecognizer setEnabled:NO];

    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    //隐藏导航栏，隐藏之后，系统侧滑就不好使了
    [self setNavigationBarHidden:YES];
    //导航栏是否透明，透明，视图会d顶到头
    self.navigationBar.translucent = YES;
    
}


#pragma mark - Action Event

/*!
 *  @brief 重写Push方法
 *
 *  @param viewController 堆栈压入的视图
 *  @param animated       是否动画压入
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    if (![[viewController class] isSubclassOfClass:[SuperViewController class]]) {
        
        return;
    }
    
   /** 添加导航Bar */

    FOXNavigationBar *foxLazyBar = [[FOXNavigationBar alloc]init];
    [foxLazyBar setBackItemClickBlock:^{

        [self popViewControllerAnimated:YES];
    }];
  
    [viewController setCustomBar:foxLazyBar];
    [viewController.view addSubview:foxLazyBar];

    
    [self setNavigationBarHidden:YES];
    
    
    [foxLazyBar setTitle:viewController.title];

    /** 是否允许侧滑返回 */
    if (viewController.fullScreenPopGestureDisabled) {
        self.fullScreenPopGestureEnabled = NO;
    }
    else
    {
        self.fullScreenPopGestureEnabled = YES;
    }

    /** 导航Bar是否隐藏 */
    if (viewController.navigationBarHidden) {
        [foxLazyBar setHidden:YES];
        [foxLazyBar setAlpha:0.0f];
    }

    /** 根视图，隐藏返回按钮 */
    if (self.childViewControllers.count == 0) {
        [foxLazyBar.backItem setHidden:YES];
        [foxLazyBar.backItem setAlpha:0.0f];
    }
  
   
 
  
    
}

/*!
 *  @brief 重写Pop方法  堆栈推出的视图
 *
 *  @param animated 是否动画退出
 *
 *  @return UIViewController
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    
//    NSLog(@"vcStack = %@", self.user.vcStack);
    return [super popViewControllerAnimated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
 //   NSLog(@"vcStack = %@", self.user.vcStack);
    return [super popToRootViewControllerAnimated:animated];
}




#pragma mark - Gesture Delegate Methods

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    

    CGPoint beginPosition = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = self.maxAllowedInitialDistance;

    if (maxAllowedInitialDistance > 0 &&  beginPosition.x > maxAllowedInitialDistance) {
        return NO;
    }

    if (self.childViewControllers.count == 1) {
        return NO;
    }
    

    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }

    if (!self.fullScreenPopGestureEnabled) {
        return NO;
    }

    return YES;
}
 




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
