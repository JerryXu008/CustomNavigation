//
//  UIButton+EnlargeEdge.h
//  AIParkSJZ
//
//  Created by lanbiao on 2018/8/18.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 按钮响应事件增大
 */
@interface UIButton (EnlargeEdge)

/**
 设置按钮响应向四周延伸等距

 @param edge 延伸的距离
 */
- (void)setEnlargeEdge:(CGFloat) edge;

/**
 设置按钮响应向四周延伸

 @param top 顶侧延伸距离
 @param left 左侧延伸距离
 @param bottom 底侧延伸距离
 @param right 右侧延伸距离
 */
- (void)setEnlargeEdgeWithTop:(CGFloat) top left:(CGFloat) left bottom:(CGFloat) bottom right:(CGFloat) right;
@end
