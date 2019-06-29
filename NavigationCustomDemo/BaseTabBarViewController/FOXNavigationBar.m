//
//  FOXNavigationBar.m
//  FOXNavigationBar
//
//  Created by XFoxer on 16/1/20.
//  Copyright © 2016年 XFoxer. All rights reserved.
//

#import "FOXNavigationBar.h"
#import "UIButton+EnlargeEdge.h"
#import "UIColor+Extension.h"

/** 状态栏高度 */
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

/** 导航BarSize */
#define kBarSize  CGSizeMake([UIScreen mainScreen].bounds.size.width, kStatusBarHeight + 44)

/** 导航栏按钮Size */
#define kItemSize CGSizeMake(44.0f, kBarSize.height - kStatusBarHeight)  // @"全选" width: 34 默认5的边距

#define kTitleColor  [UIColor colorWithRed:1.0 green:122/255 blue:36/255 alpha:1.0]


@implementation FOXBarButton

- (FOXBarButton *)initWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    
    return [[self class] buttonWithTitle:title target:target action:action];
}

+ (FOXBarButton *)buttonWithTitle:(nullable NSString *)buttonTitle target:(nullable id)target action:(nullable SEL)action {

    FOXBarButton *button = [FOXBarButton buttonWithTarget:target action:action];
    
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:kTitleColor forState:UIControlStateNormal];
    button.title = buttonTitle;

    return button;
    
}


- (FOXBarButton *)initWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    return [[self class] buttonWithImage:image target:target action:action];
   
}

+ (FOXBarButton *)buttonWithImage:(UIImage *)image target:(id)target action:(SEL)action {

    FOXBarButton *button = [FOXBarButton buttonWithTarget:target action:action];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    
    [button setEnlargeEdge:20];
    return button;
}

- (FOXBarButton *)initWithBackgroundImage:(UIImage *)image target:(id)target action:(SEL)action {
    return [[self class] buttonWithBackgroundImage:image target:target action:action];
}

+ (FOXBarButton *)buttonWithBackgroundImage:(UIImage *)image target:(id)target action:(SEL)action {
    FOXBarButton *button = [FOXBarButton buttonWithTarget:target action:action];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateHighlighted];
    return button;
}


#pragma mark - private

- (FOXBarButton *)buttonWithTarget:(id)target action:(SEL)action {
    
    return [[self class] buttonWithTarget:target action:action];
}

+ (FOXBarButton *)buttonWithTarget:(id)target action:(SEL)action {
    
    FOXBarButton *button = [[FOXBarButton alloc] init];
    
//    button.backgroundColor = [UIColor lightGrayColor];
    NSLog(@"button = %p", button);
    button.target = target;
    button.action = action;
    [button addTarget:self action:@selector(barButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


- (void)barButtonClick:(FOXBarButton *)barButton {
    
    [[self class] barButtonClick:barButton];
}

+ (void)barButtonClick:(FOXBarButton *)barButton {
    
    NSLog(@"barButton = %p", barButton);
    if (barButton.clickWithBlock) {
        barButton.clickWithBlock();
        
    }else {
        [barButton.target performSelector:barButton.action withObject:barButton];
    }
}

- (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize {
    
    NSDictionary *atts = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:atts context:nil].size;
}

#pragma mark - setter
-(void)setTitle:(NSString *)title {

    _title = title;
    
//    // 判断左右,将backItem去掉
//    if (self.frame.origin.y < YFScreen.width * 0.5) { // 左边
//        self.
//    }
    
    // 将图片去掉
    [self setImage:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    
    // title
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:kTitleColor forState:UIControlStateNormal];
    
    // 重置宽度
    CGSize titleMaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGFloat titleSizeWidth = [self sizeWithText:title andFont:self.titleLabel.font andMaxSize:titleMaxSize].width + 10;// 宽度多加10的内边距
    
    CGFloat padding = 5;
    
    // 如果在左边,x就是原来的x
    // 如果在右边,x就是屏宽-w
    if (self.frame.origin.x < [UIScreen mainScreen].bounds.size.width * 0.5) { // 左边
        
        CGRect tempF = self.frame;
        tempF = CGRectMake(tempF.origin.x + padding, tempF.origin.y, titleSizeWidth, tempF.size.height);
        self.frame = tempF;
    }else {
        CGRect tempF = self.frame;
        CGFloat x = [UIScreen mainScreen].bounds.size.width - (titleSizeWidth + padding);
        tempF = CGRectMake(x, tempF.origin.y, titleSizeWidth, tempF.size.height);
        self.frame = tempF;
    }
    

}

- (void)setImage:(UIImage *)image {

    _image = image;
    
    // 去掉文字
    [self setTitle:nil forState:UIControlStateNormal];
    _title = nil;
    
    // backItem
    [self setImage:image forState:UIControlStateNormal];
    
    // 重置frame
    CGRect tempF = self.frame;
    tempF = CGRectMake(tempF.origin.x, tempF.origin.y, kItemSize.width, tempF.size.height);
    self.frame = tempF;
    
    NSLog(@"framg = %@", NSStringFromCGRect(self.imageView.frame));
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {

    _backgroundImage = backgroundImage;
    
    // 去掉文字
    [self setTitle:nil forState:UIControlStateNormal];
    
    // backItem
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}

- (void)setEnabled:(BOOL)enabled {

    [super setEnabled:enabled];
    
    if (enabled) {
        [self setTitleColor:kTitleColor forState:UIControlStateNormal];
        self.alpha = 1;
    }else {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.alpha = 0.4;
    }
    
}

@end



@interface FOXNavigationBar()

//
///** 标题Label */
//@property (nonatomic, strong) UILabel *titleLabel;
//
///** 左边按钮 */
//@property (nonatomic, strong) UIButton *leftItem;
//
///** 右边按钮 */
//@property (nonatomic, strong) UIButton *rightItem;
//
///** 导航栏上的分割线 */
//@property (nonatomic, strong) UIView *barLine;


@end



@implementation FOXNavigationBar

- (void)dealloc
{
    _backItemClickBlock = nil;
    _barLine = nil;
    _title = nil;
    _titleLabel = nil;
    _leftItem = nil;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setFrame:CGRectMake(0, 0, kBarSize.width, kBarSize.height)];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        
        [self initViewFeatures];
        
        [self addSubview:self.barLine = [self createBarSeprateLine]];
        [self addSubview:self.backItem = [self createBackItem]];
        [self addSubview:self.titleLabel = [self createTitleLabel]];
        [self addSubview:self.rightItem = [self createRightItem]];
//        [self addSubview:self.leftItem = [self createLeftItem]];
        
    }
    return self;
}



/*!
 *  @brief 给Bar视图添加效果
 */
- (void)initViewFeatures
{

    /** 添加毛玻璃效果 */
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    [effectView setFrame:self.frame];
    [self addSubview:effectView];
    
//    /** 添加边界阴影效果 */
//    [self.layer setShadowColor:[UIColor lightGrayColor].CGColor];
//    [self.layer setShadowOffset:CGSizeMake(0, 0)];
//    [self.layer setShadowOpacity:0.90f];
//    [self.layer setShadowRadius:2.0f];
    
}


#pragma mark - Common Frame

/*!
 *  @brief 左边Item的frame
 *
 *  @return leftFrame
 */
+ (CGRect)leftItemFrame
{
    return CGRectMake(0, kStatusBarHeight, kItemSize.width, kItemSize.height);
 

}

/*!
 *  @brief 右边Item的frame
 *
 *  @return rightFrame
 */
+ (CGRect)rightItemFrame
{
    CGFloat rightX = kBarSize.width - kItemSize.width - 15; // 10是右边的间距
    return CGRectMake(rightX, kStatusBarHeight, kItemSize.width, kItemSize.height);
}

/*!
 *  @brief 导航栏的frame
 *
 *  @return titleFrame
 */
+ (CGRect)titleViewFrame
{
    CGFloat titleHeight = kBarSize.height - kStatusBarHeight;
    CGFloat titleWidth = kBarSize.width - 2*kItemSize.width;
    CGFloat titlePosX = kItemSize.width;
    CGFloat titlePosY = kStatusBarHeight;
    return CGRectMake(titlePosX, titlePosY, titleWidth, titleHeight);
}



#pragma mark - Create NavView Controls


/*!
 *  @brief 导航栏上的分割线
 *
 *  @return barLine
 */
- (UIView *)createBarSeprateLine
{
    CGFloat seprateHeight = 0.5f;
    
    UIView *barLine = [[UIView alloc]initWithFrame:CGRectMake(0, kBarSize.height - seprateHeight, kBarSize.width, seprateHeight)];
    [barLine setBackgroundColor:YFColor(204, 204, 204)];
    return barLine;
}

/*!
 *  @brief 导航栏上的返回按钮
 *
 *  @return backItem
 */
- (UIButton *)createBackItem
{
    UIButton *backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [backItem setFrame:[[self class] leftItemFrame]];
//    backItem.frame = CGRectMake(16, 13, 12, 24);
//    backItem.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    [backItem setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backItem setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    [backItem addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [backItem setEnlargeEdge:15];
    return backItem;
}


- (UIButton *)createRightItem
{
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setFrame:[[self class] rightItemFrame]];
    [rightItem addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    return rightItem;
}

- (UIButton *)createLeftItem
{
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftItem setFrame:[[self class] leftItemFrame]];
    [leftItem addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
    return leftItem;
}



/*!
 *  @brief 导航栏上的标题
 *
 *  @return titleLabel
 */
- (UILabel *)createTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:[[self class] titleViewFrame]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    return titleLabel;
}



+ (UIButton *)createItemImgNormal:(NSString *)strImg
                     imgHighlight:(NSString *)strImgHighlight
                      imgSelected:(NSString *)strImgSelected
                           target:(id)target
                           action:(SEL)action
{
    
    UIImage *imgNormal = [UIImage imageNamed:strImg];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:imgNormal forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:(strImgHighlight ? strImgHighlight : strImg)] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:(strImgSelected ? strImgSelected : strImg)] forState:UIControlStateSelected];
    
    CGFloat fDeltaWidth = (kItemSize.width - imgNormal.size.width)/2.0f;
    CGFloat fDeltaHeight = (kItemSize.height - imgNormal.size.height)/2.0f;
    fDeltaWidth = (fDeltaWidth >= 2.0f) ? fDeltaWidth/2.0f : 0.0f;
    fDeltaHeight = (fDeltaHeight >= 2.0f) ? fDeltaHeight/2.0f : 0.0f;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, fDeltaWidth, fDeltaHeight, fDeltaWidth)];
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, -imgNormal.size.width, fDeltaHeight, fDeltaWidth)];
    
    return btn;
}


#pragma mark - Fountion Methods

/*!
 *  @brief 设置导航栏标题
 *
 *  @param title 标题
 */
- (void)setTitle:(NSString *)title
{
    
    _title = title;
    
    if (!title) {
        //[self.titleLabel setText:@""];
        return;
    }
    
    if ([title isEqualToString:self.titleLabel.text]) {
        return;
    }
    
    
   
    self.titleLabel.backgroundColor = [UIColor greenColor];
    self.titleLabel.textColor = [UIColor blueColor];
    self.titleLabel.text = title;
    
    
    
     [self setNeedsDisplay];
}

/*!@brief
 *  设置左侧视图
 */
- (void)showLeftItemView:(UIButton *)leftItem
{
    // 去除backItem
    if (self.backItem) {
        [self.backItem removeFromSuperview];
    }
    
    if (_leftItem) {
        [self.leftItem removeFromSuperview];
        self.leftItem = nil;
    }
    
    self.leftItem = leftItem;
    if (_leftItem) {
        [self.leftItem setFrame:[[self class] leftItemFrame]];
        [self addSubview:self.leftItem];
    }

}


/*!
 *  @brief 设置右侧视图
 *
 *  @param rightItem
 */
- (void)showRightItemView:(UIButton *)rightItem
{
    if (_rightItem) {
        [self.rightItem removeFromSuperview];
        self.rightItem = nil;
    }
    
    self.rightItem = rightItem;
    if (_rightItem) {
        [self.rightItem setFrame:[[self class] rightItemFrame]];
        [self addSubview:self.rightItem];
    }
}

/*! @brief 显示添加在Bar上的View
 *
 * @param subView  自定义视图
 * @note  添加自定义视图， 返回按钮需要自己创建，即返回按钮也需要自定义一个
 */
- (void)showCoverView:(UIView *)subView
{
    
    if (subView) {
       // [self hiddenBarViews:YES];
        [subView removeFromSuperview];
        
        
        CGFloat barHeight = kBarSize.height - kStatusBarHeight;
        CGFloat barWidth = kBarSize.width;
        
        if (subView.frame.size.height > barHeight) {
            
            CGRect autoSizeRect = subView.frame;
            autoSizeRect.size.height = barHeight;
            subView.frame = autoSizeRect;
            
        }
        
        if (subView.frame.size.width > barWidth) {
            
            CGRect autoSizeRect = subView.frame;
            autoSizeRect.size.width = barWidth;
            subView.frame = autoSizeRect;
        }
        
        [self addSubview:subView];
        
        [self.leftItem setHidden:NO];
        [self bringSubviewToFront:self.leftItem];
    }
    
}

/*!@brief
 *  移除自定义视图
 */
- (void)hiddenCoverView:(UIView *)coverView
{
    
    if (coverView && coverView.superview == self) {
        [coverView removeFromSuperview];
    }
    
}


/*!
 *  @brief 显示添加在TitleView上的视图
 *  @param subView
 *  @note  添加在TitleView上的视图默认居中显示
 */
- (void)showCoverViewOnTitleView:(UIView *)subView
{
    
    if (subView)
    {
        if (self.titleLabel)
        {
            self.titleLabel.hidden = YES;
        }
        
        [subView removeFromSuperview];
        

        if (subView.frame.size.width && subView.frame.size.height) {
            // 就用subview的frame
            // y+20
            CGRect tempF = subView.frame;
            tempF.origin.y = tempF.origin.y + 20;
            subView.frame = tempF;
            
            
        }else {
            CGRect autoSizeRect = subView.frame;
            autoSizeRect.size.height = [[self class] titleViewFrame].size.height;
            autoSizeRect.size.width  = [[self class] titleViewFrame].size.width;
            subView.frame = autoSizeRect;
        
            [subView setCenter:CGPointMake(kBarSize.width/2, kStatusBarHeight + autoSizeRect.size.height/2)];
        }
        [self addSubview:subView];
        NSLog(@"subView.frame = %@", NSStringFromCGRect(subView.frame));
    }
    
}


/*!
 *  @brief 隐藏原生视图控件
 *
 *  @param isHidden 是否隐藏
 */
- (void)hiddenBarViews:(BOOL)isHidden
{
    if (self.leftItem) {
        [self.leftItem setHidden:isHidden];
    }
    
    if (self.rightItem) {
        [self.rightItem setHidden:isHidden];
    }
    
    if (self.backItem) {
        [self.backItem setHidden:isHidden];
    }
    
    if (self.titleLabel) {
        [self.titleLabel setHidden:isHidden];
    }
}

/*!
 *  @brief 是否隐藏导航分割线
 *
 *  @param isHidden
 */
- (void)hiddenBarLine:(BOOL)isHidden
{
    [self.barLine setHidden:isHidden];
    if (isHidden) {
        [self.barLine setAlpha:0.0f];
    }
    else
    {
        [self.barLine setAlpha:1.0f];
    }
}

#pragma mark - Action Event

/*!
 *  @brief 点击返回按钮
 *
 *  @param sender 返回按钮
 */
- (void)popViewController
{
    if (self.backItemClickBlock) {
        self.backItemClickBlock();
    }
}

/*!
 *  @brief 点击返回按钮
 *
 *  @param sender 右侧按钮
 */
- (void)rightItemClick:(id)sender
{
    
}

/*!
 *  @brief 点击返回按钮
 *
 *  @param sender 左侧按钮
 */
- (void)leftItemClick:(id)sender
{

}


@end
