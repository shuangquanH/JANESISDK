//
//  UIView+Extension.h
//  MVVMDemo
//
//  Created by mc on 2018/3/26.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Extension.h"

@interface UIView (Extension)

@property(nonatomic, assign)BOOL openTouch;

-(CGFloat)x;
-(void)setX:(CGFloat)x;
-(CGFloat)y;
-(void)setY:(CGFloat)y;
-(CGFloat)width;
-(void)setWidth:(CGFloat)width;
-(CGFloat)height;
-(void)setHeight:(CGFloat)height;
-(CGPoint)origin;
-(void)setOrigin:(CGPoint)origin;
-(CGSize)size;
-(void)setSize:(CGSize)size;
-(CGFloat)centerX;
-(void)setCenterX:(CGFloat)centerX;
-(CGFloat)centerY;
-(void)setCenterY:(CGFloat)centerY;
-(CGFloat)rightX;
-(void)setRightX:(CGFloat)rightX;
-(CGFloat)bottomY;
-(void)setBottomY:(CGFloat)bottomY;

-(CGRect)insertBy:(NSInteger)dx dy:(NSInteger)dy;
-(UIViewController *)viewControlle;


@end
