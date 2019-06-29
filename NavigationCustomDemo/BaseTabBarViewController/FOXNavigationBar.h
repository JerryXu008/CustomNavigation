//
//  FOXNavigationBar.h
//  FOXNavigationBar
//
//  Created by XFoxer on 16/1/20.
//  Copyright © 2016年 XFoxer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FOXBarButton : UIButton
// initWithTitle:@"列表" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)]

@property (nonatomic, copy) void (^clickWithBlock)(); // 暂时不用block
@property (nonatomic,assign) SEL action;
@property (nonatomic,weak) id target;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIImage *backgroundImage;


+ (FOXBarButton *)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

- (FOXBarButton *)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;


+ (FOXBarButton *)buttonWithImage:(UIImage *)image target:(id)target action:(SEL)action;

- (FOXBarButton *)initWithImage:(UIImage *)image target:(id)target action:(SEL)action;


+ (FOXBarButton *)buttonWithBackgroundImage:(UIImage *)image target:(id)target action:(SEL)action;

- (FOXBarButton *)initWithBackgroundImage:(UIImage *)image target:(id)target action:(SEL)action;

@end




/*!
 *  @brief 点击返回按钮回调
 */
typedef void(^BackItemClickBlock)(void);
@interface FOXNavigationBar : UIView

/** 返回按钮回调事件 */
@property (nonatomic, copy) BackItemClickBlock backItemClickBlock;

/** 返回Item */
@property (nonatomic, strong) UIButton *backItem;


/** 标题 */
@property (nonatomic, copy) NSString *title;


/** 标题Label */
@property (nonatomic, strong) UILabel *titleLabel;

/** 左边按钮 */
@property (nonatomic, strong) UIButton *leftItem;

/** 右边按钮 */
@property (nonatomic, strong) UIButton *rightItem;

/** 导航栏上的分割线 */
@property (nonatomic, strong) UIView *barLine;



/*!@brief
 *  设置左侧视图
 */
- (void)showLeftItemView:(UIButton *)leftItem;

///**
// *  清除阴影效果
// */
//- (void)clearShadow;


/*!
 *  @brief 设置右侧视图
 *
 *  @param rightItem
 */
- (void)showRightItemView:(UIButton *)rightItem;



/*! @brief 显示添加在Bar上的View
 *
 * @param subView  自定义视图
 * @note  添加自定义视图， 返回按钮需要自己创建，即返回按钮也需要自定义一个
 */
- (void)showCoverView:(UIView *)subView;



/*!
 *  @brief 显示添加在TitleView上的视图
 *  @param subView
 *  @note  添加在TitleView上的视图默认居中显示
 */
- (void)showCoverViewOnTitleView:(UIView *)subView;



/*!@brief
 *  移除自定义视图
 */
- (void)hiddenCoverView:(UIView *)coverView;

/*!
 *  @brief 是否隐藏导航分割线
 *
 *  @param isHidden
 */
- (void)hiddenBarLine:(BOOL)isHidden;

- (UIButton *)createBackItem;


@end
