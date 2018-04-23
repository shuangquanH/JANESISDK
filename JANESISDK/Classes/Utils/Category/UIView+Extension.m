//
//  UIView+Extension.m
//  MVVMDemo
//
//  Created by mc on 2018/3/26.
//  Copyright © 2018年 mc. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/runtime.h>

static const char * IsOpenTouch = "isOpenTouch";

@implementation UIView (Extension)

-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x{
    CGRect r = self.frame;
    r.origin.x = x;
    self.frame = r;
}

-(CGFloat)y{
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y{
    CGRect r = self.frame;
    r.origin.y = y;
    self.frame = r;
}

-(CGFloat)width{
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width{
    CGRect r = self.frame;
    r.size.width = width;
    self.frame = r;
}

-(CGFloat)height{
    return self.frame.size.height;
}
-(void)setHeight:(CGFloat)height{
    CGRect r = self.frame;
    r.size.height = height;
    self.frame = r;
}

-(CGPoint)origin{
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)origin{
    [self setX:origin.x];
    [self setY:origin.y];
}

-(CGSize)size{
    return self.frame.size;
}
-(void)setSize:(CGSize)size{
    [self setWidth:size.width];
}

-(CGFloat)centerX{
    return self.center.x;
}
-(void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.centerY);
}

-(CGFloat)centerY{
    return self.center.y;
}
-(void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.centerX, centerY);
}

-(CGFloat)rightX{
    return self.x+self.width;
}
-(void)setRightX:(CGFloat)rightX{
    [self setX:rightX - self.width];
}

-(CGFloat)bottomY{
    return self.y+self.height;
}
-(void)setBottomY:(CGFloat)bottomY{
    [self setY:bottomY - self.height];
}

-(CGRect)insertBy:(NSInteger)dx dy:(NSInteger)dy{
    self.frame = CGRectMake(self.frame.origin.x+dx, self.frame.origin.y+dy, self.frame.size.width, self.frame.size.height);
    return self.frame;
}
-(BOOL)openTouch{
    return objc_getAssociatedObject(self, &IsOpenTouch);
}
-(void)setOpenTouch:(BOOL)openTouch{
    objc_setAssociatedObject(self, &IsOpenTouch, @(IsOpenTouch), OBJC_ASSOCIATION_ASSIGN);
}

/// 开始触摸
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.openTouch) {
        if (self) [self touchesBegan:touches withEvent:event];
    }else{
        [super touchesBegan:touches withEvent:event];
    }
}
/// 触摸移动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.openTouch) {
        if (self) [self touchesMoved:touches withEvent:event];
    }else{
        [super touchesMoved:touches withEvent:event];
    }
}
/// 触摸结束
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.openTouch) {
        if (self) [self touchesEnded:touches withEvent:event];
    }else{
        [super touchesEnded:touches withEvent:event];
    }
}
/// 触摸取消
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.openTouch) {
        if (self) [self touchesCancelled:touches withEvent:event];
    }else{
        [super touchesCancelled:touches withEvent:event];
    }
}

-(UIViewController *)viewControlle{
    UIResponder *vc = self.nextResponder;
    do{
        if ([vc isKindOfClass:[UIViewController class]]) {
            return vc?(UIViewController *)vc:nil;
        }
        vc = vc.nextResponder;
    }while(vc!=nil);
    return nil;
}


@end
