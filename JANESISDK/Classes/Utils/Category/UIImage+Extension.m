//
//  UIImage+Extension.m
//  JSTempFun
//
//  Created by mc on 2018/3/30.
//  Copyright © 2018年 jaseni. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

-(UIImage*)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    //Determine whether the screen is retina
    if([[UIScreen mainScreen] scale] == 2.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    }else if ([[UIScreen mainScreen] scale] == 3.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 3.0);
    }else{
        UIGraphicsBeginImageContext(size);
    }
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)imageWithRect:(CGSize)size image:(UIImage *)image text:(NSString *)msg color:(UIColor *)color{
    // 开启图形'上下文'
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
    CGContextAddPath(graphicsContext,
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:3.0f].CGPath);
    if (color) {
        CGContextSetFillColorWithColor(graphicsContext, color.CGColor);
    }else{
        CGContextSetFillColorWithColor(graphicsContext, [UIColor lightGrayColor].CGColor);
    }
    CGContextFillPath(graphicsContext);

    // 绘制原生图片
    CGRect labelRect;
    if(image){
        CGRect imageRect = CGRectMake(4, 3.5, size.height-7, size.height-7);
        [image drawInRect:imageRect];
        labelRect = CGRectMake(imageRect.origin.x+imageRect.size.width, imageRect.origin.y, size.width-imageRect.origin.x-imageRect.size.width, imageRect.size.height);
    }else{
        labelRect = CGRectMake(4, 0, size.width-4, size.height);
    }
    
    // 在原生图上绘制文字
    UILabel *text = [[UILabel alloc] initWithFrame:labelRect];
    text.textAlignment = NSTextAlignmentLeft;
    [text setTextColor:[UIColor whiteColor]];
    text.adjustsFontSizeToFitWidth = YES;
    text.text = msg;
    text.font = [UIFont systemFontOfSize:11.0];
    
    [text drawTextInRect:labelRect];
    
//    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowColor = RGBA(0, 0, 0, 0.6);
//    shadow.shadowOffset = CGSizeMake(1, 1);
//    shadow.shadowBlurRadius = 2;
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text.text];
//    [attrStr addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, text.text.length)];
//    text.attributedText = attrStr;
    
    // 从当前上下文获取修改后的图片
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 结束图形上下文
    return imageNew;
}
- (UIImage *)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    //将Path添加到上下文中
    CGContextAddPath(contextRef,path.CGPath);
    //裁剪上下文
    CGContextClip(contextRef);
    //将图片绘制到上下文中
    [self drawInRect:rect];
    //设置绘制模式
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < LayoutUtil.screenWidth) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = LayoutUtil.screenWidth;
        btWidth = sourceImage.size.width * (LayoutUtil.screenWidth / sourceImage.size.height);
    } else {
        btWidth = LayoutUtil.screenWidth;
        btHeight = sourceImage.size.height * (LayoutUtil.screenWidth / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
@end
