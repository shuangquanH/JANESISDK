//
//  UIImage+Extension.h
//  JSTempFun
//
//  Created by mc on 2018/3/30.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

-(UIImage*)scaleToSize:(CGSize)size;
+ (UIImage *)imageWithRect:(CGSize)size image:(UIImage *)image text:(NSString *)msg color:(UIColor *)color;
- (UIImage *)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;
@end
