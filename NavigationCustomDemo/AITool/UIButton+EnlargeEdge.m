//
//  UIButton+EnlargeEdge.m
//  AIParkSJZ
//
//  Created by lanbiao on 2018/8/18.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import <objc/runtime.h>
#import "UIButton+EnlargeEdge.h"

@interface UIButton()

@end

@implementation UIButton (EnlargeEdge)

static char leftEdge;
static char bottomEdge;
static char rightEdge;
static char topEdge;

- (void)setEnlargeEdge:(CGFloat) edge{
    objc_setAssociatedObject(self, &leftEdge,   [NSNumber numberWithFloat:edge], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomEdge,  [NSNumber numberWithFloat:edge], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightEdge,[NSNumber numberWithFloat:edge], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &topEdge, [NSNumber numberWithFloat:edge], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setEnlargeEdgeWithTop:(CGFloat) top left:(CGFloat) left bottom:(CGFloat) bottom right:(CGFloat) right{
    objc_setAssociatedObject(self, &leftEdge,   [NSNumber numberWithFloat:left],   OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomEdge,  [NSNumber numberWithFloat:bottom],  OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightEdge,[NSNumber numberWithFloat:right],OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &topEdge, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect{
    NSNumber* top_Edge    = objc_getAssociatedObject(self, &topEdge);
    NSNumber* right_Edge  = objc_getAssociatedObject(self, &rightEdge);
    NSNumber* bottom_Edge = objc_getAssociatedObject(self, &bottomEdge);
    NSNumber* left_Edge   = objc_getAssociatedObject(self, &leftEdge);
    
    CGRect boundRect = self.bounds;
    if(left_Edge != NULL){
        boundRect.origin.x -= left_Edge.floatValue;
        boundRect.size.width += left_Edge.floatValue;
    }
    
    if(top_Edge != NULL){
        boundRect.origin.y -= top_Edge.floatValue;
        boundRect.size.height += top_Edge.floatValue;
    }
    
    if(right_Edge != NULL){
        boundRect.size.width += right_Edge.floatValue;
    }
    
    if(bottom_Edge != NULL){
        boundRect.size.height += bottom_Edge.floatValue;
    }
    
    return boundRect;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect rect = [self enlargedRect];
    
    if (CGRectEqualToRect(rect, self.bounds)){
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}
@end
