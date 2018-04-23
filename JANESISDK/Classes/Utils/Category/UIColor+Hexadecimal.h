//
//  UIColor+Hexadecimal.h
//  MVVMDemo
//
//  Created by mc on 2018/3/22.
//  Copyright © 2018年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hexadecimal)

+ (UIColor *)colorWithHex:(NSString *)string;
+ (UIColor *)colorWithHex:(NSString *)string alpha:(CGFloat)alpha;

@end
