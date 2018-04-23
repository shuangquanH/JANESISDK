//
//  UIPageViewController+Extension.m
//  MVVMDemo
//
//  Created by mc on 2018/3/26.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "UIPageViewController+Extension.h"

#import <objc/runtime.h>
static const char * IsGestureRecognizerEnabled = "IsGestureRecognizerEnabled";
static const char * TapIsGestureRecognizerEnabled = "TapIsGestureRecognizerEnabled";

@implementation UIPageViewController (Extension)

-(BOOL)gestureRecognizerEnabled{
    return objc_getAssociatedObject(self, &IsGestureRecognizerEnabled);
}
-(void)setGestureRecognizerEnabled:(BOOL)gestureRecognizerEnabled{
    objc_setAssociatedObject(self, &IsGestureRecognizerEnabled, @(gestureRecognizerEnabled), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)tapGestureRecognizerEnabled{
    return objc_getAssociatedObject(self, &TapIsGestureRecognizerEnabled);
}
-(void)setTapGestureRecognizerEnabled:(BOOL)tapGestureRecognizerEnabled{
    objc_setAssociatedObject(self, &TapIsGestureRecognizerEnabled, @(tapGestureRecognizerEnabled), OBJC_ASSOCIATION_ASSIGN);
}

@end
